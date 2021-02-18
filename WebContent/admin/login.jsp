<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Login</title>
<!-- JQuery -->
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/popper.min.js"></script>
<!-- JQuery Validation-->
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
<jsp:include page="sources.jsp"></jsp:include>
</head>
<body>
	<form class="needs-validation" method="post" action="login" id="adminlogin" novalidate>
		<div class="card mx-auto mt-5" style="width: 20rem;">
			<div class="card-header text-center">
				<h2 class="card-title"><i class="fas fa-user-tie"></i> Admin Login</h2>
			</div>
			<div class="card-body">
				<c:if test="${message != null}">
					<div class="alert alert-danger" role="alert">${message}</div>
				</c:if>
				<div class="form-group">
					<i class="fas fa-user-lock"></i> <label for="inputemail">Email</label> <input type="email"
						name="email" id="email" placeholder="enter email"
						class="form-control" required>
				</div>

				<div class="form-group">
					<i class="fas fa-key"></i> <label for="inputPassword">Password</label> <input type="password"
						name="password" id="password" placeholder="enter password"
						class="form-control" required>
				</div>
				<button type="submit" class="btn btn-primary float-right">Login</button>

			</div>
		</div>
	</form>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#adminlogin").validate({
			rules: {
				email: {
					required: true,
					email: true
				},
	            password: {
					required: true,
					minlength: 5
				},
			},
			messages: {
				email: {
					required: "Please enter email",
					email: "Please enter an valid email address"
				},
	            password: {
					required: "Please provide a password",
					minlength: "Your password must be at least 5 characters long"
				},
			},
			errorElement: "em",
			errorPlacement: function ( error, element ) {
				// Add the `invalid-feedback` class to the error element
				error.addClass( "invalid-feedback" );

				error.insertAfter( element );
			},
			highlight: function ( element, errorClass, validClass ) {
				$( element ).addClass( "is-invalid" ).removeClass( "is-valid" );
			},
			unhighlight: function (element, errorClass, validClass) {
				$( element ).addClass( "is-valid" ).removeClass( "is-invalid" );
			}
		});
	});
</script>
</html>