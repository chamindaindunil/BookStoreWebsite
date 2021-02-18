package com.bookstore.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.UserDAO;
import com.bookstore.entity.Users;

public class UserServices {
	private UserDAO userDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;

	public UserServices(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
		userDAO = new UserDAO();
	}
	
	public void listUser() throws ServletException, IOException {
		listUser(null);
	}
	
	public void listUser(String message) throws ServletException, IOException {
		List<Users> listUsers = userDAO.listAll();
		
		request.setAttribute("listUsers", listUsers);
		
		if(message != null) {
			request.setAttribute("message", message);
		}
		
		String listPage = "user_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		requestDispatcher.forward(request, response);
	}
	
	public void createUser() throws ServletException, IOException {
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullname");
		String password = request.getParameter("password");
		
		Users existUser = userDAO.findByEmail(email);
		
		String message = null;
		if(existUser != null) {
			message = "Could not create user. A user with email " + email + " already exists";
			request.setAttribute("message", message);
			listUser(message);
		} else {
			Users newUser = new Users(email, fullName, password);
			userDAO.create(newUser);
			
			message = "New User Created Successfully";
			request.setAttribute("message", message);
			listUser(message);
		}
	}

	public void editUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("id"));
		Users user = userDAO.get(userId);
		
		if(user == null) {
			String errorMessage = "Could not find user with ID " + userId;
			request.setAttribute("message", errorMessage);
			listUser(errorMessage);
		} else {
			request.setAttribute("user", user);
			
			String editPage = "user_form.jsp";
			RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
			requestDispatcher.forward(request, response);
		}
	}

	public void updateUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
		String email = request.getParameter("email");
		String fullName = request.getParameter("fullname");
		String password = request.getParameter("password");
		
		Users userById = userDAO.get(userId);
		
		Users userByEmail = userDAO.findByEmail(email);
		
		if(userByEmail != null && userByEmail.getUserId() != userById.getUserId()) {
			String message = "Could not update user, User with email " + email + " already exists";
			request.setAttribute("message", message);
			listUser(message);
		} else {
			Users user = new Users(userId, email, fullName, password);
			
			userDAO.update(user);
			
			String message = "User has been updated Successfully";
			request.setAttribute("message", message);
			listUser(message);
		}
	}

	public void deleteUser() throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("id"));
		
		Users user = userDAO.get(userId);
		
		String message = "User has been deleted Successfully";
		
		if(user == null) {
			message = "Could not find user with ID " + userId + ", or it might have been deleted by another admin";
			request.setAttribute("message", message);
			listUser(message);
		} else if (userId == 1) {
			message = "The default admin user account cannot be deleted.";
			request.setAttribute("message", message);
			listUser(message);
		} else {
			userDAO.delete(userId);
			listUser(message);
		}
	}

	public void login() throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		
		boolean loginResult = userDAO.checkLogin(email, password);
		
		if (loginResult) {
			request.getSession().setAttribute("useremail", email);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/");
			dispatcher.forward(request, response);
		} else {
			String message = "username or password incorrect";
			request.setAttribute("message", message);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}
}
