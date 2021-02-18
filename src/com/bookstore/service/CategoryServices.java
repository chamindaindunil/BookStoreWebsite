package com.bookstore.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.entity.Category;

public class CategoryServices {
	private CategoryDAO categoryDAO;
	private HttpServletRequest request;
	private HttpServletResponse response;
	
	public CategoryServices(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
		categoryDAO = new CategoryDAO();
	}
	
	public void listCategory() throws ServletException, IOException {
		listCategory(null);
	}
	
	public void listCategory(String message) throws ServletException, IOException {
		List<Category> listCategory = categoryDAO.listAll();
		
		request.setAttribute("listCategory", listCategory);
		
		if(message != null) {
			request.setAttribute("message", message);
		}
		
		String listPage = "category_list.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(listPage);
		
		requestDispatcher.forward(request, response);
	}

	public void createCategory() throws ServletException, IOException {
		String name = request.getParameter("name");
		Category existCategory = categoryDAO.findByName(name);
		
		String message = null;
		
		if(existCategory != null) {
			message = "Could not create category. " + "A category with name " + name + " already exists.";
		} else {
			Category newcategory = new Category(name);
			categoryDAO.create(newcategory);
			
			message = "New category created successfully";
		}
		request.setAttribute("message", message);
		listCategory(message);
	}
	
	public void editCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		Category category = categoryDAO.get(categoryId);
		
		String editPage = "category_form.jsp";
		
		if (category != null) {
			request.setAttribute("category", category);
		} else {
			String message = "Could not find category with ID " + categoryId;
			request.setAttribute("message", message);
			listCategory(message);
		}
		
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(editPage);
		requestDispatcher.forward(request, response);
	}

	public void updateCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("categoryId"));
		String categoryName = request.getParameter("name");
		
		Category categoryById = categoryDAO.get(categoryId);
		Category categoryByName = categoryDAO.findByName(categoryName);
		
		String message = null;
		
		if(categoryByName != null && categoryById.getCategoryId() != categoryByName.getCategoryId()) {
			message = "Could not update category." + " A category with name " + categoryName + " already exists.";
			request.setAttribute("message", message);
			listCategory(message);
		} else {
			categoryById.setName(categoryName);
			categoryDAO.update(categoryById);
			
			message = "Category has been updated successfully";
			request.setAttribute("message", message);
			listCategory(message);
		}
	}

	public void deleteCategory() throws ServletException, IOException {
		int categoryId = Integer.parseInt(request.getParameter("id"));
		
		BookDAO bookDAO = new BookDAO();
		long numberOfBooks = bookDAO.countByCategory(categoryId);
		
		String message;
		
		Category category = categoryDAO.get(categoryId);
		
		if (category == null) {
			message = "Could not find category with ID " + categoryId + ", or it might have been deleted.";
		} else if (numberOfBooks > 0) {
			message = "Could not delete the category ID: " + categoryId + " because it contains some books.";
		} else {
			categoryDAO.delete(categoryId);
			message = "The category with ID " + categoryId + " has been removed successfully.";
		}
		
		request.setAttribute("message", message);
		listCategory(message);
	}
}
