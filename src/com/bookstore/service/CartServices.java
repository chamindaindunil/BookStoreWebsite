package com.bookstore.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CartItemDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.CartItems;
import com.bookstore.entity.Customer;

public class CartServices {
	private CartItemDAO cartItemDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	private BookDAO bookDAO;
	
	public CartServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		this.cartItemDAO = new CartItemDAO();
		this.bookDAO = new BookDAO();
	}

	public void listCartItems() throws ServletException, IOException {
		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loggedCustomer");
		
		List<CartItems> listCartItems = cartItemDAO.findByCustomer(customer.getCustomerId());
		
		request.setAttribute("listCartItems", listCartItems);
		
		String cartPage = "frontend/shopping_cart.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(cartPage);
		dispatcher.forward(request, response);
	}

	public void addToCart() throws IOException, ServletException {
		Integer bookId = Integer.parseInt(request.getParameter("book_id"));
		Integer quantity = Integer.parseInt(request.getParameter("quantity"));
		
		HttpSession session = request.getSession();
		Customer customerObj = (Customer) session.getAttribute("loggedCustomer");
		
		boolean checkBook = cartItemDAO.checkBook(bookId, customerObj.getCustomerId());
		
		String message = null;
		
		if (!checkBook) {
			Book book = new Book();
			
			book.setBookId(bookId);
			
			Customer customer = new Customer();
			customer.setCustomerId(customerObj.getCustomerId());
			
			CartItems cartItems = new CartItems();
			cartItems.setBook(book);
			cartItems.setCustomer(customer);
			cartItems.setQuantity(quantity);
			
			cartItemDAO.create(cartItems);
			
			String bookTitle = cartItems.getBook().getTitle();
			
			message = bookTitle + " " + "book added to your shopping cart";
			request.setAttribute("message", message);
		} else {
			List<CartItems> bookByCustomer = cartItemDAO.findByBookAndCustomer(bookId, customerObj.getCustomerId());
			
			Integer existQuantity = 0;
			Integer cartId = 0;
			
			for (CartItems existItem : bookByCustomer) {
				existQuantity = existItem.getQuantity();
				cartId = existItem.getId();
			}
			
			Integer newQuantity = existQuantity + quantity;
			
			CartItems cartItems = cartItemDAO.get(cartId);
			
			cartItems.setQuantity(newQuantity);
			
			cartItemDAO.update(cartItems);
			
			String bookTitle = cartItems.getBook().getTitle();
			
			message = bookTitle + " " + "already exist in your shopping cart." + " " + "book quantity increased by" + " " + quantity;
			request.setAttribute("message", message);
		}
		
		//List<CartItems> listCartItems = cartItemDAO.findByCustomer(customerObj.getCustomerId());
		
		//request.setAttribute("listCartItems", listCartItems);
		
		Book book = bookDAO.get(bookId);
		request.setAttribute("book", book);
		
		String cartPage = "frontend/book_detail.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(cartPage);
		dispatcher.forward(request, response);
	}

	public void removeFromCart() throws IOException {
		Integer cartId = Integer.parseInt(request.getParameter("cart_id"));
		
		cartItemDAO.delete(cartId);
		
		String message = "A book has been removed from your Shopping Cart.";
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		out.print(message);
		out.flush();
	}

	public void updateQuantity() throws IOException {
		Integer bookId = Integer.parseInt(request.getParameter("book_id"));
		Integer quantity = Integer.parseInt(request.getParameter("quantity"));
		
		HttpSession session = request.getSession();
		Customer customerObj = (Customer) session.getAttribute("loggedCustomer");
		
		List<CartItems> bookByCustomer = cartItemDAO.findByBookAndCustomer(bookId, customerObj.getCustomerId());
		
		Integer cartId = 0;
		
		for (CartItems existItem : bookByCustomer) {
			cartId = existItem.getId();
		}
		
		CartItems cartItems = cartItemDAO.get(cartId);
		
		cartItems.setQuantity(quantity);
		
		cartItemDAO.update(cartItems);
		
		Book book = bookDAO.get(bookId);
		
		float ItemTotal = book.getPrice() * quantity;
		
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		out.print(ItemTotal);
		out.flush();
	}
	
}
