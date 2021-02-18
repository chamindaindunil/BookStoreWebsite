package com.bookstore.controller.frontend.customer;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class CustomerLoginFilter
 */
@WebFilter("/*")
public class CustomerLoginFilter implements Filter {
	
	private static final String[] loginRequiredURLs = {
			"/view_profile", "/edit_profile", "/update_profile", "/write_review", "/checkout", "/place_order", "/view_order",
			"/show_order_detail", "/view_cart", "/add_to_cart"
	};

    /**
     * Default constructor. 
     */
    public CustomerLoginFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpSession session = httpRequest.getSession(false);
		
		String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
		
		if (path.startsWith("/admin/")) {
			// pass the request along the filter chain
			chain.doFilter(request, response);
			return;
		}
		
		boolean loggedIn = session != null && session.getAttribute("loggedCustomer") != null;
		
		String requestURL = httpRequest.getRequestURI().toString();
		
		if (!loggedIn && isLoginRequired(requestURL)) {
			String queryString = httpRequest.getQueryString();
			String redirectURL = requestURL;
			
			if (queryString != null) {
				redirectURL = redirectURL.concat("?").concat(queryString);
			}
			
			session.setAttribute("redirectURL", redirectURL);
						
			String loginPage = "frontend/login.jsp"; 
			RequestDispatcher dispatcher = httpRequest.getRequestDispatcher(loginPage); dispatcher.forward(request, response);
		} else {
			// pass the request along the filter chain
			chain.doFilter(request, response);
		}

	}
	
	private boolean isLoginRequired(String requestURL) {
		for (String loginRequiredURL : loginRequiredURLs) {
			if (requestURL.contains(loginRequiredURL)) {
				return true;
			}
		}
		
		return false;
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
