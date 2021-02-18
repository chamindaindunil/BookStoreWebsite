<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card text-center mb-3">
			<div class="card-header">
				<h3>Quick Actions:</h3>
			</div>
			<div class="card-body">
				<div class="row row-cols-1 row-cols-md-3">
					<div class="col mb-4">
						<div class="card">
							<a class="btn btn-primary" href="new_book"><i class="fas fa-book"></i> New Book</a>
						</div>
					</div>
					<div class="col mb-4">
						<div class="card">
							<a class="btn btn-primary" href="category_form.jsp"><i class="fas fa-code-branch"></i> New Category</a>
						</div>
					</div>
					<div class="col mb-4">
						<div class="card">
							<a class="btn btn-primary" href="user_form.jsp"><i class="fas fa-user"></i> New User</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="card mb-3">
			<div class="card-header text-center">
				<h3>Recent Sales:</h3>
			</div>
			<div class="card-body">
				<table class="table table-bordered">
					<thead class="thead-dark">
						<tr>
							<th>Order ID</th>
							<th>Ordered by</th>
							<th>Book Copies</th>
							<th>Total</th>
							<th>Payment Method</th>
							<th>Status</th>
							<th>Order Date</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listMostRecentSales}" var="order"
							varStatus="status">
							<tr>
								<td><a href="view_order?id=${order.orderId}">${order.orderId}</a></td>
								<td>${order.customer.fullname}</td>
								<td>${order.bookCopies}</td>
								<td><fmt:formatNumber value="${order.total}"
										type="currency" /></td>
								<td>${order.paymentMethod}</td>
								<td>${order.status}</td>
								<td>${order.orderDate}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="card mb-3">
			<div class="card-header text-center">
				<h3>Recent Reviews:</h3>
			</div>
			<div class="card-body">
				<table class="table table-bordered">
					<thead class="thead-dark">
						<tr>
							<th>Book</th>
							<th>Rating</th>
							<th>Headline</th>
							<th>Customer</th>
							<th>Review On</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listMostRecentReviews}" var="review"
							varStatus="status">
							<tr>
								<td>${review.book.title}</td>
								<td>${review.rating}</td>
								<td><a href="edit_review?id=${review.reviewId}">${review.headline}</a></td>
								<td>${review.customer.fullname}</td>
								<td>${review.reviewTime}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="card">
			<div class="card-header text-center">
				<h3>Statistics:</h3>
			</div>
			<div class="card-body">
				<div class="row row-cols-1 row-cols-md-5">
					<div class="col mb-4">
						<div class="card">
							<div class="card-body">
								Total Users: ${totalUsers}
							</div>
						</div>
					</div>
					<div class="col mb-4">
						<div class="card">
							<div class="card-body">
								Total Books: ${totalBooks}
							</div>
						</div>
					</div>
					<div class="col mb-4">
						<div class="card">
							<div class="card-body">
								Total Customers: ${totalCustomers}
							</div>
						</div>
					</div>
					<div class="col mb-4">
						<div class="card">
							<div class="card-body">
								Total Reviews: ${totalReviews}
							</div>
						</div>
					</div>
					<div class="col mb-4">
						<div class="card">
							<div class="card-body">
								Total Orders: ${totalOrders}
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>