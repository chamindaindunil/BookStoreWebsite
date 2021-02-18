<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Books in ${category.name} - Online Book Store</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		
		<br>

		<div class="row row-cols-1 row-cols-md-2">
			<c:forEach items="${listBooks}" var="book">
				<div class="col mb-4">
					<div class="card mb-4 h-100" style="max-width: 540px; max-height: 250px;">
						<div class="row no-gutters">
							<div class="col-md-4">
								<a href="view_book?id=${book.bookId}">
									<img src="data:image/jpg;base64,${book.base64Image}" class="card-img" height="250">
								</a>
							</div>
							<div class="col-md-8">
								<div class="card-body">
									<h5 class="card-title">
										<a href="view_book?id=${book.bookId}">${book.title}</a>
									</h5>
									<p class="card-text">by ${book.author}</p>
									<p class="card-text">
										<jsp:directive.include file="book_rating.jsp"/>
									</p>
									<b>Rs: <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${book.price}" /></b>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>

		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>