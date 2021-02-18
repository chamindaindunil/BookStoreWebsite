package com.bookstore.service;

import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.Category;

public class BookServices {
	private BookDAO bookDAO;
	private CategoryDAO categoryDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public BookServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		bookDAO = new BookDAO();
		categoryDAO = new CategoryDAO();
	}
	
	public void listBooks() throws ServletException, IOException {
		listBooks(null);
	}
	
	public void listBooks(String message) throws ServletException, IOException {
		List<Book> listBooks = bookDAO.listAll();
		
		request.setAttribute("listBooks", listBooks);
		
		if (message != null) {
			request.setAttribute("message", message);
		}
		
		String listPage = "book_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
	}

	public void showBookNewForm() throws ServletException, IOException {
		List<Category> listCategory = categoryDAO.listAll();
		request.setAttribute("listCategory", listCategory);
		
		String newPage = "book_form.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(newPage);
		requestDispatcher.forward(request, response);
	}
	
	public void readBookFields(Book book) throws IOException, ServletException {
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String description = request.getParameter("description");
		String isbn = request.getParameter("isbn");
		float price = Float.parseFloat(request.getParameter("price"));
		
		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		Date publishDate;
		
		try {
			publishDate = dateFormat.parse(request.getParameter("publishDate"));
		} catch (ParseException e) {
			e.printStackTrace();
			throw new ServletException("Error parsing publish date (format is MM/dd/yyyy)");
		}
		
		book.setTitle(title);
		book.setAuthor(author);
		book.setDescription(description);
		book.setIsbn(isbn);
		book.setPublishDate(publishDate);
		
		Integer categoryId = Integer.parseInt(request.getParameter("category"));
		Category category = categoryDAO.get(categoryId);
		book.setCategory(category);
		
		book.setPrice(price);
		
		Part part = request.getPart("bookImage");
		
		if (part != null && part.getSize() > 0) {
			long size = part.getSize();
			byte[] imageBytes = new byte[(int) size];
			
			InputStream inputStream = part.getInputStream();
			inputStream.read(imageBytes);
			inputStream.close();
			
			book.setImage(imageBytes);
		}
	}

	public void createBook() throws ServletException, IOException {
		String title = request.getParameter("title");
		System.out.println(title);
		Book existBook = bookDAO.findByTitle(title);
		
		String message = null;
		
		if (existBook != null) {
			message = "Could not create new book because the title already exists.";
		}
		
		Book newBook = new Book();
		
		readBookFields(newBook);
		
		Book createdBook = bookDAO.create(newBook);
		
		if (createdBook.getBookId() > 0) {
			message = "A new book has been created successfully";
		}
		
		request.setAttribute("message", message);
		listBooks(message);
	}

	public void editBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book = bookDAO.get(bookId);
		
		String editPage = "book_form.jsp";
		
		if (book != null) {
			List<Category> listCategory = categoryDAO.listAll();
			
			request.setAttribute("book", book);
			request.setAttribute("listCategory", listCategory);
		} else {
			editPage = "message.jsp";
			String message = "Could not find book with ID " + bookId;
			request.setAttribute("message", message);
		}
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
	}

	public void updateBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("bookId"));
		String title = request.getParameter("title");
		
		Book bookByTitle = bookDAO.findByTitle(title);
		String message = null;
		
		Book existBook = bookDAO.get(bookId);
		
		if (bookByTitle != null && bookByTitle.getBookId() != bookId) {
			message = "Could not update book because there's another book having same title.";
		} else {
			readBookFields(existBook);
			
			bookDAO.update(existBook);
			
			message = "The book has been updated successfully.";
			
		}
		
		request.setAttribute("message", message);
		listBooks(message);
	}

	public void deleteBook() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book = bookDAO.get(bookId);
		
		String message = null;
		
		if (book == null) {
			message = "Could not find book with ID " + bookId + ", or it might have been deleted.";
			
			return;
		} else {
			message = "The book " + bookId + " has been removed successfully.";
			
			bookDAO.delete(bookId);
		}
		
		request.setAttribute("message", message);
		listBooks(message);
	}

	public void listBookByCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		Category category = categoryDAO.get(categoryId);
		
		if (category == null) {
			String message = "Sorry, the category ID " + categoryId + " is not available.";
			request.setAttribute("message", message);
			
			String messagePage = "frontend/message.jsp";
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(messagePage);
			requestDispatcher.forward(request, response);
		}
		
		List<Book> listBooks = bookDAO.listByCategory(categoryId);
		
		request.setAttribute("listBooks", listBooks);
		request.setAttribute("category", category);
		
		String listPage = "frontend/books_list_by_category.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
	}

	public void viewBookDetail() throws ServletException, IOException {
		Integer bookId = Integer.parseInt(request.getParameter("id"));
		Book book = bookDAO.get(bookId);
		
		String detailPage = "frontend/book_detail.jsp";
		
		if (book != null) {
			request.setAttribute("book", book);
		} else {
			detailPage = "frontend/message.jsp";
			String message = "Sorry, the book with ID " + bookId + " is not available.";
			request.setAttribute("message", message);
		}
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(detailPage);
		requestDispatcher.forward(request, response);
	}

	public void search() throws ServletException, IOException {
		String keyword = request.getParameter("keyword");
		
		List<Book> result = null;
		
		if (keyword.equals("")) {
			result = bookDAO.listAll();
		} else {
			result = bookDAO.search(keyword);
		}
		
		request.setAttribute("keyword", keyword);
		request.setAttribute("result", result);
		
		String resultPage = "frontend/search_result.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(resultPage);
		requestDispatcher.forward(request, response);
	}
}
