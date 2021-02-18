<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Results for ${keyword} - Online Book Store</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<c:if test="${fn:length(result) == 0}">
			<h4 align="center">No Results for ${keyword}</h4>
		</c:if>

		<c:if test="${fn:length(result) > 0}">
			<div>
				<h4 align="center">Results for ${keyword}</h4><br>
				<c:forEach items="${result}" var="book">
					<div class="card mb-4"
						style="max-width: auto; max-height: 250px;">
						<div class="row no-gutters">
							<div class="col-md-2">
								<a href="view_book?id=${book.bookId}"> <img
									src="data:image/jpg;base64,${book.base64Image}"
									class="card-img" height="250">
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
									${fn:substring(book.description, 0, 250)}...
								</div>
							</div>
							<div class="col-md-2">
								<div class="card-body">
									<h4 class="card-title">Rs: <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${book.price}" /></h4>
									<br>
									<button class="btn btn-primary" type="submit">Add to Cart</button>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</c:if>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>