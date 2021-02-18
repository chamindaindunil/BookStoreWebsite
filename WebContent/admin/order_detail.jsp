<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Details - Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Details of Order ID: ${order.orderId}
				</h4>
				<!-- divider -->
				<hr>
				<!-- message -->
				<c:if test="${message != null}">
					<div align="center">${message}</div>
				</c:if>
				<!-- order overview -->
				<jsp:directive.include file="../common/common_order_detail.jsp"/>
				<%-- <div align="center">
					<a href="edit_order?id=${order.orderId}" class="btn btn-primary">Edit Order</a>
					<a href="javascript:comfirmDelete(${order.orderId})" class="btn btn-danger">Delete Order</a>
				</div> --%>
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