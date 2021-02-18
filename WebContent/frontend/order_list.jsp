<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Order History - Rathna Bookstore</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					My Order History
				</h4>
				<!-- divider -->
				<hr>
				<c:if test="${fn:length(listOrders) == 0}">
				<div align="center"><h4>You have not placed any orders.</h4></div>
				</c:if>
				<!-- data table -->
				<c:if test="${fn:length(listOrders) > 0}">
				<table class="table">
					<thead>
						<tr>
							<th>Index</th>
							<th>Order ID</th>
							<th>Quantity</th>
							<th>Order Amount</th>
							<th>Order Date</th>
							<th>Status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order" items="${listOrders}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${order.orderId}</td>
								<td>${order.bookCopies}</td>
								<td><fmt:formatNumber value="${order.total}" type="currency" /></td>
								<td><fmt:formatDate value="${order.orderDate}"/></td>
								<td>${order.status}</td>
								<td>
									<a href="show_order_detail?id=${order.orderId}">View Detail</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</c:if>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
function comfirmDelete(reviewId) {
	if(confirm('Are you sure you want to delete the review with ID ' + reviewId + '?')) {
		window.location = 'delete_review?id=' + reviewId;
	}
}
</script>
</html>