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
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Users Management
					<a href="user_form.jsp" class="btn btn-sm btn-primary float-right">Create New User</a>
				</h4>
				<!-- divider -->
				<hr>
				<!-- message -->
				<c:if test="${message != null}">
					<div class="alert alert-danger text-center" role="alert">${message}</div>
				</c:if>
				<!-- data table -->
				<table class="table">
					<thead>
						<tr>
							<th>Index</th>
							<th>ID</th>
							<th>Email</th>
							<th>Full Name</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${listUsers}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${user.userId}</td>
								<td>${user.email}</td>
								<td>${user.fullName}</td>
								<td>
									<a href="edit_user?id=${user.userId}"><i class="fas fa-edit"></i></a>&nbsp;&nbsp;
									<a href="javascript:comfirmDelete(${user.userId})" id="deleteme${user.userId}" ><i class="fas fa-trash-alt"></i></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- Delete message -->
	<jsp:include page="delete_message.jsp"></jsp:include>
	<!-- Modal -->
	<jsp:include page="../common/model_message.jsp"></jsp:include>
</body>
<script type="text/javascript">
function comfirmDelete(userId) {
	$("#deleteMessage").modal();
	$("#modalTitle").text('Delete a user');
	$("#message").text('Are you sure you want to delete the user with ID ' + userId + '?');
	
	$('#ok').click(function(){
		window.location = 'delete_user?id=' + userId;
	});
}
</script>
</html>