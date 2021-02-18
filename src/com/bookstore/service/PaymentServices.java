package com.bookstore.service;

import java.io.IOException;
import java.rmi.ServerException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.entity.Book;
import com.bookstore.entity.BookOrder;
import com.bookstore.entity.Customer;
import com.bookstore.entity.OrderDetail;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payer;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.PaymentExecution;
import com.paypal.api.payments.RedirectUrls;
import com.paypal.api.payments.ShippingAddress;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

public class PaymentServices {
	private static final String CLIENT_ID = "AZo54wixMM7uK3vnRJeHCqtQmfIg5QmUxBWZsB5KH98Ku3OdEXUXczMonuYYteiY9PRVJ93d5GPMux37";
	private static final String CLIENT_SECRET = "EBaEXxSTkqGQGYE8go6eiiWazc_ErtpW6EaRiRAUWprawJb958whwiNnVIZWeKBQwxQ_I9ljzx3LtFrE";
	private String mode = "sandbox";
	
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public PaymentServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
	}
	
	public void authorizePayment(BookOrder order) throws IOException {
		// get payer information
		Payer payer = getPayerInformation(order);
		
		// get redirect URLs
		RedirectUrls redirectUrls = getRedirectUrls();
		
		// get transaction details
		List<Transaction> transactions = getTransactionInformation(order);
		
		// request payment
		Payment requestPayment = new Payment();
		requestPayment.setPayer(payer);
		requestPayment.setRedirectUrls(redirectUrls);
		requestPayment.setIntent("authorize");
		requestPayment.setTransactions(transactions);
		
		System.out.println("====== REQUEST PAYMENT: ======");
		System.out.println(requestPayment);
		
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
		
		try {
			Payment authorizedPayment = requestPayment.create(apiContext);
			
			System.out.println("====== AUTHORIZED PAYMENT: ======");
			System.out.println(authorizedPayment);
			
			String approvalURL = getApprovalURL(authorizedPayment);
			
			response.sendRedirect(approvalURL);
		} catch (PayPalRESTException e) {
			e.printStackTrace();
			throw new ServerException("Error in authorizing payment.");
		}
		
		// get approval link
		
		// redirect to Paypal's payment page
	}

	private Payer getPayerInformation(BookOrder order) {
		Payer payer = new Payer();
		payer.setPaymentMethod("paypal");
		
		Customer customer = order.getCustomer();
		
		PayerInfo payerInfo = new PayerInfo();
		payerInfo.setFirstName(customer.getFirstname());
		payerInfo.setLastName(customer.getLastname());
		payerInfo.setEmail(customer.getEmail());
		
		payer.setPayerInfo(payerInfo);
		
		return payer;
	}
	
	private RedirectUrls getRedirectUrls() {
		String requestURL = request.getRequestURL().toString();
		String requestURI = request.getRequestURI();
		String baseURL = requestURL.replace(requestURI, "").concat(request.getContextPath());
		
		RedirectUrls redirectUrls = new RedirectUrls();
		
		String cancelUrl = baseURL.concat("/view_cart");
		String returnUrl = baseURL.concat("/review_payment");
		
		System.out.println("Return URL: " + returnUrl);
		System.out.println("Cancel URL: " + cancelUrl);
		
		redirectUrls.setCancelUrl(cancelUrl);
		redirectUrls.setReturnUrl(returnUrl);
		
		return redirectUrls;
	}
	
	private Amount getAmountDetails(BookOrder order) {
		Details details = new Details();
		
		details.setShipping(String.format("%.2f", order.getShippingFee()));
		details.setTax(String.format("%.2f", order.getTax()));
		details.setSubtotal(String.format("%.2f", order.getSubtotal()));
		
		Amount amount = new Amount();
		
		amount.setCurrency("USD");
		amount.setDetails(details);
		amount.setTotal(String.format("%.2f", order.getTotal()));
		
		return amount;
	}
	
	private ShippingAddress getRecipientInformation(BookOrder order) {
		ShippingAddress shippingAddress = new ShippingAddress();
		
		String recipientName = order.getFirstname() + " " + order.getLastname();
		
		shippingAddress.setRecipientName(recipientName);
		shippingAddress.setPhone(order.getPhone());
		shippingAddress.setLine1(order.getAddressLine1());
		shippingAddress.setLine2(order.getAddressLine2());
		shippingAddress.setCity(order.getCity());
		shippingAddress.setState(order.getState());
		shippingAddress.setPostalCode(order.getZipcode());
		shippingAddress.setCountryCode(order.getCountry());
		
		return shippingAddress;
	}
	
	private List<Transaction> getTransactionInformation(BookOrder order) {
		Transaction transaction = new Transaction();
		transaction.setDescription("Books ordered on Rathna Book Store");
		
		// get amount details
		Amount amount = getAmountDetails(order);
		transaction.setAmount(amount);
		
		ItemList itemList = new ItemList();
		
		// shipping address (recipient info)
		ShippingAddress shippingAddress = getRecipientInformation(order);
		itemList.setShippingAddress(shippingAddress);
		
		List<Item> paypalItems = new ArrayList<>();
		
		Iterator<OrderDetail> iterator = order.getOrderDetails().iterator();
		
		while (iterator.hasNext()) {
			OrderDetail orderDetail = (OrderDetail) iterator.next();
			Book book = orderDetail.getBook();
			Integer quantity = orderDetail.getQuantity();
			
			Item paypalItem = new Item();
			paypalItem.setCurrency("USD");
			paypalItem.setName(book.getTitle());
			paypalItem.setQuantity(String.valueOf(quantity));
			paypalItem.setPrice(String.format("%.2f", book.getPrice()));
			
			paypalItems.add(paypalItem);
		}
		
		itemList.setItems(paypalItems);
		transaction.setItemList(itemList);
		
		List<Transaction> listTransaction = new ArrayList<>();
		listTransaction.add(transaction);
		
		return listTransaction;
	}
	
	private String getApprovalURL(Payment authorizedPayment) {
		String approvalURL = null;
		
		List<Links> links = authorizedPayment.getLinks();
		
		for (Links link : links) {
			if (link.getRel().equalsIgnoreCase("approval_url")) {
				approvalURL = link.getHref();
				break;
			}
		}
		return approvalURL;
	}

	public void reviewPayment() throws ServletException {
		String paymentId = request.getParameter("paymentId");
		String payerId = request.getParameter("PayerID");
		
		if (paymentId == null || payerId == null) {
			throw new ServletException("Error in displaying payment review");
		}
		
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
		
		try {
			Payment payment = Payment.get(apiContext, paymentId);
			
			PayerInfo payerInfo = payment.getPayer().getPayerInfo();
			Transaction transaction = payment.getTransactions().get(0);
			ShippingAddress shippingAddress = transaction.getItemList().getShippingAddress();
			
			request.setAttribute("payer", payerInfo);
			request.setAttribute("recipient", shippingAddress);
			request.setAttribute("transaction", transaction);
			
			String reviewPage = "frontend/review_payment.jsp?paymentId=" + paymentId + "&PayerID=" + payerId;
			request.getRequestDispatcher(reviewPage).forward(request, response);
		} catch (PayPalRESTException | IOException e) {
			e.printStackTrace();
			throw new ServletException("Error in getting payment details from paypal");
		}
	}

	public Payment executePayment() throws PayPalRESTException {
		String paymentId = request.getParameter("paymentId");
		String payerId = request.getParameter("PayerID");
		
		PaymentExecution paymentExecution = new PaymentExecution();
		paymentExecution.setPayerId(payerId);
		
		Payment payment = new Payment().setId(paymentId);
		
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
		
		return payment.execute(apiContext, paymentExecution);
	}
}