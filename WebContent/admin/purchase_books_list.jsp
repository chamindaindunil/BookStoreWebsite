<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Purchase Report - Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Purchase Report Management
				</h4>
				<!-- divider -->
				<hr>
				<!-- data table -->
				<table class="table">
					<thead>
						<tr>
							<th>Index</th>
							<th>Title</th>
							<th>Author</th>
							<th>Unit Price</th>
							<th>No of Books</th>
							<th>Category</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="report" items="${listMostPurchasedBooks}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${report.book.title}</td>
								<td>${report.book.author}</td>
								<td>${report.book.price}</td>
								<td>${report.quantity}</td>
								<td>${report.book.category.name}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>