<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register as a Customer</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>

		<br>
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">Register as a Customer</h4>
				<!-- divider -->
				<hr>
				<form method="post" action="register_customer" id="registerForm">
					<jsp:directive.include file="../common/customer_form.jsp" />
				</form>
			</div>
		</div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- Modal -->
	<jsp:include page="../common/model_message.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$('#buttonCancel').click(function(){
		history.go(-1);
	})
	
	$(document).ready(function() {
		$('#registerForm').submit(function(event){
			//stop submit the form, we will post it manually.
			event.preventDefault();
			
			// Create an FormData object
			form_data = $(this).serialize();
			
			$.ajax({
				type: "POST",
				url: "register_customer",
				data: form_data,
				success: function (response){
					$("#modalTitle").text("Register as a Customer");
					
					if (response.includes("successfully")) {
						$("#message").text(response);
						$("#message").addClass('alert-success');
						$("#myModal").modal();
						$(".close").click(function(){
							window.location = "login";
						});
					} else {
						$("#message").text(response);
						$("#message").addClass('alert-danger');
						$("#myModal").modal();
					}
				},
			});
		});
		
		$.validator.addMethod("nameRegex", function(value, element) {
	        return this.optional(element) || /^[a-z\s]+$/i.test(value);
	    }, "First name must contain only letters, and spaces.");
		
		$("#registerForm").validate({
			rules: {
				email: {
					required: true,
					email: true
				},
				firstName: {
	                required: true,
	                nameRegex: true,
	            },
	            lastName: {
	                required: true,
	                nameRegex: true,
	            },
	            password: {
					required: true,
					minlength: 5
				},
				confirmPassword: {
					required: true,
					minlength: 5,
					equalTo: "#password"
				},
				phone: {
	                required: true,
	                number: true,
	                minlength: 10,
	                min: 1,
	            },
	            address1: "required",
	            address2: "required",
	            city: "required",
	            state: "required",
	            zipCode: {
	                required: true,
	                number: true,
	                min: 1,
	            },
			},
			messages: {
				email: {
					required: "Email is required",
					email: "Enter an valid email address"
				},
				firstName: {
	                required: "First Name is required",
	                nameRegex: "First name must be letters."
	            },
	            lastName: {
	                required: "Last Name is required",
	                nameRegex: "Last name must be letters."
	            },
	            password: {
					required: "Password is required",
					minlength: "Your password must be at least 5 characters long"
				},
				confirmPassword: {
					required: "Confirm Password is required",
					minlength: "Your password must be at least 5 characters long",
					equalTo: "Please enter the same password as above"
				},
				phone: {
					required: "Phone Number is required",
					number: "Phone Number must be a number",
					min: "Phone Number must be greater than 0",
				},
				address1: "Address Line 1 is required",
				address2: "Address Line 2 is required",
				city: "City is required",
				state: "State is required",
				zipCode: {
					required: "Zip code is required",
					number: "Zip code must be a number",
					min: "Zip code must be greater than 0",
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
		})
	});
	</script>
</html>