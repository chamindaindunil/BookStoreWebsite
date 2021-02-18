<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Users - Rathna Bookstore Administration</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>

		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Users Management
					<a href="user_form.jsp" class="btn btn-sm btn-primary float-right">Create New User</a>
				</h4>
				<!-- divider -->
				<hr>
				<!-- message -->
				<div align="center">${message}</div>
				
			</div>
		</div>
	
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>