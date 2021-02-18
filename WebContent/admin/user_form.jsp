<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create New User</title>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					<c:if test="${user != null}">
						Edit User
					</c:if>
					<c:if test="${user == null}">
						Create New User
					</c:if>
				</h4>
				<!-- divider -->
				<hr>
				<c:if test="${user != null}">
					<form method="post" action="update_user" id="userForm">
						<input type="hidden" name="userId" value="${user.userId}">
				</c:if>
				<c:if test="${user == null}">
					<form method="post" action="create_user" id="userForm">
				</c:if>
				<div class="form-group row">
					<label for="inputEmail" class="col-sm-2 col-form-label">Email</label>
					<div class="col-sm-8">
						<input type="email" class="form-control" name="email"
							id="inputEmail" value="${user.email}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputName" class="col-sm-2 col-form-label">Full
						Name</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="fullname"
							id="inputName" value="${user.fullName}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
					<div class="col-sm-8">
						<input type="password" class="form-control" name="password"
							id="inputPassword" value="${user.password}">
					</div>
				</div>
				<div class="col-sm-10 text-right mb-3">
					<button type="button" class="btn btn-primary" id="buttonCancel">Cancel</button>
					<button type="submit" class="btn btn-primary">Save</button>
				</div>
				</form>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- Modal -->
	<jsp:include page="../common/model_message.jsp"></jsp:include>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$.validator.addMethod("nameRegex", function(value, element) {
		return this.optional(element) || /^[a-z\s]+$/i.test(value);
	}, "Full name must contain only letters, and spaces.");

	// user form validation
	$("#userForm").validate({
		rules : {
			email : {
				required : true,
				email : true
			},
			"fullname" : {
				required : true,
				nameRegex : true,
			},
			password : {
				required : true,
				minlength : 5
			},
		},
		messages : {
			email : {
				required : "Please enter email",
				email : "Please enter an valid email address"
			},
			"fullname" : {
				required : "You must enter a Full name",
				loginRegex : "Full name must contain only letters."
			},
			password : {
				required : "Please provide a password",
				minlength : "Your password must be at least 5 characters long"
			},
		},
		errorElement : "em",
		errorPlacement : function(error, element) {
			// Add the `invalid-feedback` class to the error element
			error.addClass("invalid-feedback");

			error.insertAfter(element);
		},
		highlight : function(element, errorClass, validClass) {
			$(element).addClass("is-invalid").removeClass("is-valid");
		},
		unhighlight : function(element, errorClass, validClass) {
			$(element).addClass("is-valid").removeClass("is-invalid");
		}
	});
});

$('#buttonCancel').click(function() {
	history.go(-1);
});
</script>
</html>