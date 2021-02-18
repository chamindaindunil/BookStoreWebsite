<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Reviews - Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					review Management
				</h4>
				<!-- divider -->
				<hr>
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
							<th>Book</th>
							<th>Rating</th>
							<th>Headline</th>
							<th>Customer</th>
							<th>Review On</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="review" items="${listReviews}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${review.reviewId}</td>
								<td>${review.book.title}</td>
								<td>${review.rating}</td>
								<td>${review.headline}</td>
								<td>${review.customer.fullname}</td>
								<td><fmt:formatDate type="date" value="${review.reviewTime}"/></td>
								<td>
									<a href="edit_review?id=${review.reviewId}"><i class="fas fa-edit"></i></a> &nbsp; 
									<a href="javascript:comfirmDelete(${review.reviewId})"><i class="fas fa-trash-alt"></i></a>
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
function comfirmDelete(reviewId) {
	$("#deleteMessage").modal();
	$("#modalTitle").text('Delete a review');
	$("#message").text('Are you sure you want to delete the review with ID ' + reviewId + '?');
	
	$('#ok').click(function(){
		window.location = 'delete_review?id=' + reviewId;
	});
}
</script>
</html>