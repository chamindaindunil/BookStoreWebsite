<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Rathna Book Shop - Online Book Store</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<div>
			<h4 align="center">New Books</h4><br>
			<div class="row row-cols-1 row-cols-md-4">
				<c:forEach items="${listNewBooks}" var="book">
					<jsp:directive.include file="book_group.jsp"/>
				</c:forEach>
			</div>
		</div>
		<div>
			<h4 align="center">Best-Selling Books</h4><br>
			<div class="row row-cols-1 row-cols-md-4">
				<c:forEach items="${listBestSellingBooks}" var="book">
					<jsp:directive.include file="book_group.jsp"/>
				</c:forEach>
			</div>
		</div>
		<div>
			<h4 align="center">Most-Favored Books</h4><br>
			<div class="row row-cols-1 row-cols-md-4">
				<c:forEach items="${listFavoredBooks}" var="book">
					<jsp:directive.include file="book_group.jsp"/>
				</c:forEach>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>