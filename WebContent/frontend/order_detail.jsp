<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Order Details - Rathna Bookstore Administration</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<div class="card">
			<div class="card-body">
				<c:if test="${order == null}">
				<h4 align="center">Sorry, you are not authorized to view this order</h4>
				</c:if>
				<c:if test="${order != null}">
				<h4 class="card-title">
					Your of Order ID: ${order.orderId}
				</h4>
				<!-- divider -->
				<hr>
				<!-- order overview -->
				<jsp:directive.include file="../common/common_order_detail.jsp"/>
				</c:if>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>