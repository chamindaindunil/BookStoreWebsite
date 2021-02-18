package com.bookstore.controller.admin.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.service.BookServices;

/**
 * Servlet implementation class UpdateBookServlet
 */
@WebServlet("/admin/update_book")
@MultipartConfig(
		fileSizeThreshold = 1024 * 10,	// 10 KB
		maxFileSize = 1024 * 300,		// 100 KB
		maxRequestSize = 1024 * 1024	// 1 MB
		)
public class UpdateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public UpdateBookServlet() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BookServices bookServices = new BookServices(request, response);
		bookServices.updateBook();
	}

}
