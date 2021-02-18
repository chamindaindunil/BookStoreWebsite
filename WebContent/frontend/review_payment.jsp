<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Review Payment - Rathna Book Store</title>
<script src="js/jquery.min.js" type="text/javascript"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<h5 align="center" style="color:red">
			<i>Please carefully review the following information before
				making payment</i>
		</h5>
		<div class="card">
			<div class="card-body">
				<div>
					<h5 class="card-title">Payer Information</h5>
					<div class="form-group row">
						<label for="firstName" class="col-sm-2 col-form-label"><b>First
							Name</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext"
								name="firstName" id="firstName" value="${payer.firstName}">
						</div>
					</div>
					<div class="form-group row">
						<label for="lastName" class="col-sm-2 col-form-label"><b>Last
							Name</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" name="lastName"
								id="lastName" value="${payer.lastName}">
						</div>
					</div>
					<div class="form-group row">
						<label for="email" class="col-sm-2 col-form-label"><b>E-mail</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" name="email"
								id="email" value="${payer.email}">
						</div>
					</div>
				</div>
				<hr>
				<div>
					<h5 class="card-title">Recipient Information</h5>
					<div class="form-group row">
						<label for="recipientName" class="col-sm-2 col-form-label"><b>Recipient
							Name</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext"
								name="firstName" id="firstName"
								value="${recipient.recipientName}">
						</div>
					</div>
					<div class="form-group row">
						<label for="address1" class="col-sm-2 col-form-label"><b>Address
							Line1</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" name="address1"
								id="address1" value="${recipient.line1}">
						</div>
					</div>
					<div class="form-group row">
						<label for="address2" class="col-sm-2 col-form-label"><b>Address
							Line2</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" name="address2"
								id="address2" value="${recipient.line2}">
						</div>
					</div>
					<div class="form-group row">
						<label for="city" class="col-sm-2 col-form-label"><b>City</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" name="city"
								id="city" value="${recipient.city}">
						</div>
					</div>
					<div class="form-group row">
						<label for="state" class="col-sm-2 col-form-label"><b>State</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" name="state"
								id="state" value="${recipient.state}">
						</div>
					</div>
					<div class="form-group row">
						<label for="countryCode" class="col-sm-2 col-form-label"><b>Country
							Code</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext"
								name="countryCode" id="countryCode"
								value="${recipient.countryCode}">
						</div>
					</div>
					<div class="form-group row">
						<label for="postalCode" class="col-sm-2 col-form-label"><b>Postal
							Code</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext"
								name="postalCode" id="postalCode"
								value="${recipient.postalCode}">
						</div>
					</div>
				</div>
				<hr>
				<div>
					<h5>Transaction Details</h5>
					<div class="form-group row">
						<label for="description" class="col-sm-2 col-form-label"><b>Description</b></label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext"
								name="description" id="description"
								value="${transaction.description}">
						</div>
					</div>
					<table class="table table-bordered">
						<thead class="thead-dark">
							<tr>
								<th>No.</th>
								<th>Name</th>
								<th>Quantity</th>
								<th>Price</th>
								<th>Subtotal</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${transaction.itemList.items}" var="item"
								varStatus="var">
								<tr>
									<td>${var.index +1}</td>
									<td>${item.name}</td>
									<td>${item.quantity}</td>
									<td align="right"><fmt:formatNumber value="${item.price}"
											type="currency" /></td>
									<td align="right"><fmt:formatNumber
											value="${item.price * item.quantity}" type="currency" /></td>
							</c:forEach>
							<tr>
								<td colspan="4" align="right">
									<p>
										<b>SubTotal: </b>
									</p>
									<p>
										<b>Tax: </b>
									</p>
									<p>
										<b>Shipping Fee: </b>
									</p>
									<p>
										<b>TOTAL: </b>
									</p>
								</td>
								<td align="right">
									<p>
										<b><fmt:formatNumber
												value="${transaction.amount.details.subtotal}"
												type="currency" /></b>
									</p>
									<p>
										<b><fmt:formatNumber
												value="${transaction.amount.details.tax}" type="currency" /></b>
									</p>
									<p>
										<b><fmt:formatNumber
												value="${transaction.amount.details.shipping}"
												type="currency" /></b>
									</p>
									<p>
										<b><fmt:formatNumber value="${transaction.amount.total}"
												type="currency" /></b>
									</p>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="text-center">
					<form action="execute_payment" method="post">
						<input type="hidden" name="paymentId" value="${param.paymentId}">
						<input type="hidden" name="PayerID" value="${param.PayerID}">
						<button type="submit" class="btn btn-primary">Pay Now</button>
					</form>
				</div>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>