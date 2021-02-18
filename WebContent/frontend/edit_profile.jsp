<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit My Profile</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>

		<br>
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">Edit My Profile</h4>
				<!-- divider -->
				<hr>
				<form method="post" action="update_profile" id="profileForm">
					<div class="form-group row">
						<label for="inputEmail" class="col-sm-2 col-form-label">E-mail</label>
						<div class="col-sm-8">
							<input type="email" class="form-control" name="email" readonly="readonly"
								value="${loggedCustomer.email}">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputFirstName" class="col-sm-2 col-form-label">First
							Name</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="firstName"
								id="firstName" value="${loggedCustomer.firstname}" required>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputLastName" class="col-sm-2 col-form-label">Last
							Name</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="lastName"
								id="lastName" value="${loggedCustomer.lastname}" required>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputPhoneNumber" class="col-sm-2 col-form-label">Phone
							Number</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="phone" id="phone"
								value="${loggedCustomer.phone}" required>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputAddress1" class="col-sm-2 col-form-label">Address Line 1
							</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="address1"
								id="address1" value="${loggedCustomer.addressLine1}" required>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputAddress2" class="col-sm-2 col-form-label">Address
							Line 2</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="address2"
								id="address2" value="${loggedCustomer.addressLine2}" required>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputCity" class="col-sm-2 col-form-label">City</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="city" id="city"
								value="${loggedCustomer.city}" required>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputState" class="col-sm-2 col-form-label">State</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="state" id="state"
								value="${loggedCustomer.state}" required>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputZipCode" class="col-sm-2 col-form-label">Zip
							Code</label>
						<div class="col-sm-8">
							<input type="text" class="form-control" name="zipCode"
								id="zipCode" value="${loggedCustomer.zipcode}" required>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputCountry" class="col-sm-2 col-form-label">Country</label>
						<div class="col-sm-8">
							<select id="inputCountry" class="form-control" name="country">
								<c:forEach items="${mapCountries}" var="country">
									<option value="${country.value}"
										<c:if test="${loggedCustomer.country eq country.value}">selected='selected'</c:if>>${country.key}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<hr>
					(Leave password fields blank if you don't want to change password)
					<div class="form-group row">
						<label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
						<div class="col-sm-8">
							<input type="password" class="form-control" name="password"
								id="password">
						</div>
					</div>
					<div class="form-group row">
						<label for="inputConfirmPassword" class="col-sm-2 col-form-label">Confirm
							Password</label>
						<div class="col-sm-8">
							<input type="password" class="form-control"
								name="confirmPassword" id="confirmPassword">
						</div>
					</div>
					<div class="col-sm-10 text-right mb-3">
						<button type="button" class="btn btn-primary" id="buttonCancel">Cancel</button>
						<button type="submit" class="btn btn-primary">Save</button>
					</div>
				</form>
			</div>
		</div>

		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
	$('#buttonCancel').click(function() {
		history.go(-1);
	})

	$(document).ready(function() {
		$.validator.addMethod("nameRegex", function(value, element) {
	        return this.optional(element) || /^[a-z\s]+$/i.test(value);
	    }, "First name must contain only letters, and spaces.");
		
		$("#profileForm").validate({
			rules: {
				firstName: {
	                required: true,
	                nameRegex: true,
	            },
	            lastName: {
	                required: true,
	                nameRegex: true,
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
	            password: {
					minlength: 5
				},
				confirmPassword: {
					minlength: 5,
					equalTo: "#password"
				},
			},
			messages: {
				firstName: {
	                required: "First Name is required",
	                nameRegex: "First name must be letters."
	            },
	            lastName: {
	                required: "Last Name is required",
	                nameRegex: "Last name must be letters."
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
	            password: {
					minlength: "Your password must be at least 5 characters long"
				},
				confirmPassword: {
					minlength: "Your password must be at least 5 characters long",
					equalTo: "Please enter the same password as above"
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