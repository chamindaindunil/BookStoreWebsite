<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Profile - Online Book Store</title>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Welcome, ${loggedCustomer.fullname} <a href="edit_profile"
						class="btn btn-primary float-right">Edit Profile</a>
				</h4>
				<!-- divider -->
				<hr>
				<div class="form-group row">
					<label for="Email" class="col-sm-2 col-form-label">E-mail</label>
					<div class="col-sm-8">
						<input type="email" class="form-control-plaintext"
							value="${loggedCustomer.email}">
					</div>
				</div>
				<div class="form-group row">
					<label for="FirstName" class="col-sm-2 col-form-label">First
						Name</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.firstname}">
					</div>
				</div>
				<div class="form-group row">
					<label for="LastName" class="col-sm-2 col-form-label">Last
						Name</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.lastname}">
					</div>
				</div>
				<div class="form-group row">
					<label for="PhoneNumber" class="col-sm-2 col-form-label">Phone
						Number</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.phone}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputAddress1" class="col-sm-2 col-form-label">Address Line 1</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.addressLine1}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputAddress2" class="col-sm-2 col-form-label">Address Line 2</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.addressLine2}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputCity" class="col-sm-2 col-form-label">City</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.city}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputState" class="col-sm-2 col-form-label">State</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.state}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputZipCode" class="col-sm-2 col-form-label">Zip
						Code</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.zipcode}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputCountry" class="col-sm-2 col-form-label">Country</label>
					<div class="col-sm-8">
						<input type="text" class="form-control-plaintext"
							value="${loggedCustomer.countryName}">
					</div>
				</div>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>