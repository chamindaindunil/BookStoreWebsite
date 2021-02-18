package com.bookstore.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.dao.CartItemDAO;
import com.bookstore.dao.OrderDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.BookOrder;
import com.bookstore.entity.CartItems;
import com.bookstore.entity.Customer;
import com.bookstore.entity.OrderDetail;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;

public class OrderServices {
	private OrderDAO orderDAO;
	private CartItemDAO cartItemDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public OrderServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		this.orderDAO = new OrderDAO();
		this.cartItemDAO = new CartItemDAO();
	}

	public void listAllOrder(String message) throws ServletException, IOException {
		List<BookOrder> listOrder = orderDAO.listAll();
		
		if (message != null) {
			request.setAttribute("message", message);
		}
		
		request.setAttribute("listOrder", listOrder);
		
		String listPage = "order_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(listPage);
		dispatcher.forward(request, response);
	}
	
	public void listAllOrder() throws ServletException, IOException {
		listAllOrder(null);
	}

	public void viewOrderDetailForAdmin() throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("id"));
		
		BookOrder order = orderDAO.get(orderId);
		
		request.setAttribute("order", order);
		
		String detailPage = "order_detail.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
		dispatcher.forward(request, response);
	}

	public void showCheckoutForm() throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		
		List<CartItems> listCartItems = cartItemDAO.findByCustomer(customer.getCustomerId());
		
		request.setAttribute("listCartItems", listCartItems);
		
		CommonUtility.generateCountryList(request);
		
		String checkOutPage = "frontend/checkout.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(checkOutPage);
		dispatcher.forward(request, response);
	}

	public void placeOrder() throws ServletException, IOException {
		String paymentMethod = request.getParameter("paymentMethod");
		BookOrder order = readOrderInfo();
		
		if (paymentMethod.equals("paypal")) {
			PaymentServices paymentServices = new PaymentServices(request, response);
			request.getSession().setAttribute("order4Paypal", order);
			paymentServices.authorizePayment(order);
		} else {
			//Cash on delivery
			placeOrderCOD(order);
		}
		
	}
	
	private BookOrder readOrderInfo() {
		String paymentMethod = request.getParameter("paymentMethod");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String phone = request.getParameter("phone");
		String addressLine1 = request.getParameter("address1");
		String addressLine2 = request.getParameter("address2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipCode = request.getParameter("zipCode");
		String country = request.getParameter("country");
		
		BookOrder order = new BookOrder();
		order.setFirstname(firstName);
		order.setLastname(lastName);
		order.setPhone(phone);
		order.setAddressLine1(addressLine1);
		order.setAddressLine2(addressLine2);
		order.setCity(city);
		order.setState(state);
		order.setZipcode(zipCode);
		order.setCountry(country);
		order.setPaymentMethod(paymentMethod);
		
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		order.setCustomer(customer);
		
		List<CartItems> listCartItems = cartItemDAO.findByCustomer(customer.getCustomerId());
		
		Set<OrderDetail> orderDetails = new HashSet<>();
		
		for (CartItems cartItems : listCartItems) {
			Book book = cartItems.getBook();
			Integer quantity = cartItems.getQuantity();
			float itemTotal = quantity * book.getPrice();
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(book);
			orderDetail.setBookOrder(order);
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(itemTotal);
			
			orderDetails.add(orderDetail);
		}
		
		order.setOrderDetails(orderDetails);
		
		float subtotal = Float.parseFloat(request.getParameter("subtotal"));
		float tax = Float.parseFloat(request.getParameter("tax"));
		float shippingFee = Float.parseFloat(request.getParameter("shippingFee"));
		float total = Float.parseFloat(request.getParameter("total"));
		
		order.setSubtotal(subtotal);
		order.setTax(tax);
		order.setShippingFee(shippingFee);
		order.setTotal(total);
		
		return order;
	}
	
	private Integer saveOrder(BookOrder order) {
		BookOrder savedOrder = orderDAO.create(order);
		
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		
		List<CartItems> listCartItems = cartItemDAO.findByCustomer(customer.getCustomerId());
		
		// clear cart
		for (CartItems cartItems : listCartItems) {
			cartItemDAO.delete(cartItems.getId());
		}
		
		return savedOrder.getOrderId();
	}

	private void placeOrderCOD(BookOrder order) throws ServletException, IOException {
		saveOrder(order);
		
		String message ="Thank you. Your order has been received. We will deliver your books within a few days.";
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		out.print(message);
		out.flush();
	}

	public Integer placeOrderPaypal(Payment payment) {
		BookOrder order =  (BookOrder) request.getSession().getAttribute("order4Paypal");
		
		ItemList itemList = payment.getTransactions().get(0).getItemList();
		ShippingAddress shippingAddress = itemList.getShippingAddress();
		String shippingPhoneNumber = itemList.getShippingPhoneNumber();
		
		String recipientName = shippingAddress.getRecipientName();
		String[] names = recipientName.split(" ");
		
		order.setFirstname(names[0]);
		order.setLastname(names[1]);
		order.setAddressLine1(shippingAddress.getLine1());
		order.setAddressLine2(shippingAddress.getLine2());
		order.setCity(shippingAddress.getCity());
		order.setState(shippingAddress.getState());
		order.setCountry(shippingAddress.getCountryCode());
		order.setPhone(shippingPhoneNumber);
		
		return saveOrder(order);
	}

	public void listOrderByCustomer() throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		
		List<BookOrder> listOrders = orderDAO.listByCustomer(customer.getCustomerId());
		
		request.setAttribute("listOrders", listOrders);
		
		String historyPage = "frontend/order_list.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(historyPage);
		dispatcher.forward(request, response);
	}

	public void showOrderDetailForCustomer() throws ServletException, IOException {
		int orderId = Integer.parseInt(request.getParameter("id"));
		
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		
		BookOrder order = orderDAO.get(orderId, customer.getCustomerId());
		
		request.setAttribute("order", order);
		
		String detailPage = "frontend/order_detail.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(detailPage);
		dispatcher.forward(request, response);
	}

	public void showEditOrderForm() throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("id"));
		
		BookOrder order = orderDAO.get(orderId);
		
		HttpSession session = request.getSession();
		Object isPendingBook = session.getAttribute("NewBookPendingToAddToOrder");
		
		if (isPendingBook == null) {
			session.setAttribute("order", order);
		} else {
			session.removeAttribute("NewBookPendingToAddToOrder");
		}
		
		CommonUtility.generateCountryList(request);
		
		String editPage = "order_form.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(editPage);
		dispatcher.forward(request, response);
	}

	public void updateOrder() throws ServletException, IOException {
		HttpSession session = request.getSession();
		BookOrder order = (BookOrder) session.getAttribute("order");
		
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String phone = request.getParameter("phone");
		String address1 = request.getParameter("address1");
		String address2 = request.getParameter("address2");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipCode = request.getParameter("zipCode");
		String country = request.getParameter("country");
		
		float shippingFee = Float.parseFloat(request.getParameter("shippingFee"));
		float tax = Float.parseFloat(request.getParameter("tax"));
		
		String paymentMethod = request.getParameter("paymentMethod");
		String orderStatus = request.getParameter("orderStatus");
		
		order.setFirstname(firstName);
		order.setLastname(lastName);
		order.setPhone(phone);
		order.setAddressLine1(address1);
		order.setAddressLine2(address2);
		order.setCity(city);
		order.setState(state);
		order.setZipcode(zipCode);
		order.setCountry(country);
		order.setShippingFee(shippingFee);
		order.setTax(tax);
		order.setPaymentMethod(paymentMethod);
		order.setStatus(orderStatus);
		
		String[] arrayBookId = request.getParameterValues("bookId");
		String[] arrayPrice = request.getParameterValues("price");
		String[] arrayQuantity = new String[arrayBookId.length];
		
		for (int i = 1; i <= arrayQuantity.length; i++) {
			arrayQuantity[i - 1] = request.getParameter("quantity" + i);
		}
		
		Set<OrderDetail> orderDetails = order.getOrderDetails();
		orderDetails.clear();
		
		float totalAmount = 0.0f;
		
		for (int i = 0; i < arrayBookId.length; i++) {
			int bookId = Integer.parseInt(arrayBookId[i]);
			int quantity = Integer.parseInt(arrayQuantity[i]);
			float price = Float.parseFloat(arrayPrice[i]);
			
			float subtotal = price * quantity;
			
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setBook(new Book(bookId));
			orderDetail.setQuantity(quantity);
			orderDetail.setSubtotal(subtotal);
			orderDetail.setBookOrder(order);
			
			orderDetails.add(orderDetail);
			
			totalAmount += subtotal;
		}
		
		order.setTotal(totalAmount);
		totalAmount += shippingFee;
		totalAmount += tax;
		
		order.setTotal(totalAmount);
		
		orderDAO.update(order);
		
		String message = "The order " + order.getOrderId() + " has been updated successfully";
		
		listAllOrder(message);
	}

	public void deleteOrder() throws ServletException, IOException {
		Integer orderId = Integer.parseInt(request.getParameter("id"));
		
		orderDAO.delete(orderId);
		
		String message = "The order ID " + orderId + " has been deleted.";
		
		listAllOrder(message);
	}
	
}
