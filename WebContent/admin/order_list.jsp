<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Orders - Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Book Order Management
				</h4>
				<!-- divider -->
				<hr>
				<!-- message -->
				<c:if test="${message != null}">
					<div align="center">${message}</div>
				</c:if>
				<!-- data table -->
				<table class="table">
					<thead>
						<tr>
							<th>Index</th>
							<th>Order ID</th>
							<th>Ordered by</th>
							<th>Book Copies</th>
							<th>Total (Rs)</th>
							<th>Payment Method</th>
							<th>Status</th>
							<th>Order Date</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${listOrder}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${order.orderId}</td>
								<td>${order.customer.fullname}</td>
								<td>${order.bookCopies}</td>
								<td><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${order.total}" /></td>
								<td>${order.paymentMethod}</td>
								<td>${order.status}</td>
								<td><fmt:formatDate value="${order.orderDate}"/></td>
								<td>
									<a href="view_order?id=${order.orderId}">Detail</a> &nbsp;
									<%-- <a href="edit_order?id=${order.orderId}">Edit</a> &nbsp; 
									<a href="javascript:comfirmDelete(${order.orderId})">Delete</a> --%>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
function comfirmDelete(orderId) {
	if(confirm('Are you sure you want to delete the order with ID ' + orderId + '?')) {
		window.location = 'delete_order?id=' + orderId;
	}
}
</script>
</html>