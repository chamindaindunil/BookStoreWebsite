<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Book to Order</title>
<jsp:include page="sources.jsp"></jsp:include>
</head>
<body>
	<div class="mx-5 mt-2">
		<h2 align="center">Add book to Order ID: ${order.orderId}</h2>
		<form action="add_book_to_order" method="post">
			<div class="form-group">
				<label for="selectBook" class="col-form-label">Select
					a Book:</label>
				<div class="col-sm-12">
					<select id="bookId" class="form-control" name="bookId">
						<c:forEach items="${listBook}" var="book" varStatus="status">
							<option value="${book.bookId}">${book.title}-
								${book.author}</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="numberOfCopies" class="col-form-label">Number
					of Copies:</label>
				<div class="col-sm-3">
					<select id="quantity" class="form-control" name="quantity">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
					</select>
				</div>
			</div>
			<div align="right">
				<button type="submit" class="btn btn-primary">Add</button>
				<button type="button" class="btn btn-danger"
					onclick="javascript:self.close();">Cancel</button>
			</div>
		</form>
	</div>
</body>
</html>