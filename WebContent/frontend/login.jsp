<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Login</title>
<jsp:include page="sources.jsp"></jsp:include>
</head>
<body>
	<div class="container">
	<jsp:include page="header.jsp"></jsp:include>
	<br>
	<form class="needs-validation" method="post" action="login" id="customerLogin">
		<div class="card mx-auto" style="width: 25rem;">
			<div class="card-header text-center">
				<h1 class="card-title">Customer Login</h1>
			</div>
			<div class="card-body">
				<!-- message -->
				<c:if test="${message != null}">
					<div class="alert alert-danger text-center" role="alert">${message}</div>
				</c:if>
				<div class="form-group">
					<label for="inputemail">Email</label> <input type="email"
						name="email" id="email" placeholder="enter email"
						class="form-control" required>
				</div>

				<div class="form-group">
					<label for="inputPassword">Password</label> <input type="password"
						name="password" id="password" placeholder="enter password"
						class="form-control" required>
				</div>
				<button type="submit" class="btn btn-primary float-right">Login</button>
			</div>
		</div>
	</form>
	<hr>
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#customerLogin").validate({
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
			},
			
			/*submitHandler: function(form) {
				form_data = $(form).serialize();
				
				$.ajax({
					type: "POST",
					url: form.action,
					data: form_data,
					success: function (response){
						if (response.includes("failed")) {
							$("#message").text(response);
							$("#message").addClass('alert-danger');
							$("#message").removeClass('d-none');
						} else {
						alert(response)
							window.location = "/RathnaBookStore/login"
						}
					},
				});
			}*/
		});
	});
</script>
</html>