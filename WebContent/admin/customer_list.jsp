<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Customers - Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Customer Management
					<!-- <a href="new_customer" class="btn btn-sm btn-primary float-right">Create New Customer</a> -->
				</h4>
				<!-- divider -->
				<hr>
				<c:if test="${message != null}">
					<div class="alert alert-info text-center" role="alert">${message}</div>
				</c:if>
				<!-- data table -->
				<table class="table">
					<thead>
						<tr>
							<th>Index</th>
							<th>ID</th>
							<th>E-mail</th>
							<th>Full Name</th>
							<th>Contact Number</th>
							<th>City</th>
							<th>Registered Date</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="customer" items="${listCustomer}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${customer.customerId}</td>
								<td>${customer.email}</td>
								<td>${customer.fullname}</td>
								<td>${customer.phone}</td>
								<td>${customer.city}</td>
								<td><fmt:formatDate type="date" value="${customer.registerDate}"/></td>
								<td>
									<a href="view_customer?id=${customer.customerId}">Detail</a>&nbsp;&nbsp;&nbsp;
									<a href="javascript:comfirmDelete(${customer.customerId})"><i class="fas fa-trash-alt"></i></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>	
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- Delete message -->
	<jsp:include page="delete_message.jsp"></jsp:include>
</body>
<script type="text/javascript">
function comfirmDelete(customerId) {
	$("#deleteMessage").modal();
	$("#modalTitle").text('Blacklist a customer');
	$("#message").text('Are you sure you want to blacklist the customere with ID ' + customerId + '?');
	
	$('#ok').click(function(){
		window.location = 'delete_customer?id=' + customerId;
	});
}
</script>
</html>