<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Details - Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">Details of Customer ID:
					${customer.customerId}</h4>
				<!-- divider -->
				<hr>
				<div align="center">
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th>First Name:</th>
								<td>${customer.firstname}</td>
							</tr>
							<tr>
								<th>Last Name:</th>
								<td>${customer.lastname}</td>
							</tr>
							<tr>
								<th>E-mail :</th>
								<td>${customer.email}</td>
							</tr>
							<tr>
								<th>Contact Number:</th>
								<td>${customer.phone}</td>
							</tr>
							<tr>
								<th>Address Line1:</th>
								<td>${customer.addressLine1}</td>
							</tr>
							<tr>
								<th>Address Line2:</th>
								<td>${customer.addressLine2}</td>
							</tr>
							<tr>
								<th>City:</th>
								<td>${customer.city}</td>
							</tr>
							<tr>
								<th>State:</th>
								<td>${customer.state}</td>
							</tr>
							<tr>
								<th>Postal Code:</th>
								<td>${customer.zipcode}</td>
							</tr>
							<tr>
								<th>Country:</th>
								<td>${customer.countryName}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>