<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Books - Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Books Management
					<a href="new_book" class="btn btn-sm btn-primary float-right">Create New Book</a>
				</h4>
				<!-- message -->
				<c:if test="${message != null}">
					<div class="alert alert-info text-center" role="alert">${message}</div>
				</c:if>
				<!-- data table -->
				<table class="table">
					<thead>
						<tr>
							<th>Index</th>
							<th>ID</th>
							<th>Image</th>
							<th>Title</th>
							<th>Author</th>
							<th>Category</th>
							<th>Price</th>
							<th>Last Updated</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="book" items="${listBooks}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${book.bookId}</td>
								<td>
									<img src="data:image/jpg;base64,${book.base64Image}" width="85" height="110">
								</td>
								<td>${book.title}</td>
								<td>${book.author}</td>
								<td>${book.category.name}</td>
								<td><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${book.price}" /></td>
								<td><fmt:formatDate type="date" value="${book.lastUpdateTime}"/></td>
								<td>
									<a href="edit_book?id=${book.bookId}"><i class="fas fa-edit"></i></a> &nbsp; 
									<a href="javascript:comfirmDelete(${book.bookId})"><i class="fas fa-trash-alt"></i></a>
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
	<!-- Modal -->
	<jsp:include page="../common/model_message.jsp"></jsp:include>
</body>
<script type="text/javascript">
function comfirmDelete(bookId) {
	$("#deleteMessage").modal();
	$("#modalTitle").text('Delete a book');
	$("#message").text('Are you sure you want to delete the book with ID ' + bookId + '?');
	
	$('#ok').click(function(){
		window.location = 'delete_book?id=' + bookId;
	});
}
</script>
</html>