<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout - Rathna Book Store</title>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/shoppingcart.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<c:if test="${message != null}">
			<div align="center">${message}</div>
		</c:if>
		<div class="card">
			<div class="card-header">
				<h5 class="card-title text-center">Your Order Details</h5>
			</div>
			<div class="card-body">
				<c:if test="${fn:length(listCartItems) == 0}">
					<h4>There's no items in your cart</h4>
				</c:if>

				<c:if test="${fn:length(listCartItems) > 0}">
					<form action="place_order" method="post" id="checkoutForm">
						<div class="row">
							<div class="col-sm-8">
								<div class="card mb-4">
									<div class="card-header text-center">Order Summary</div>
									<div class="card-body">
										<c:forEach items="${listCartItems}" var="item"
											varStatus="status">
											<div class="card mb-4">
												<div class="row no-gutters">
													<div class="col-md-3">
														<img src="data:image/jpg;base64,${item.book.base64Image}"
															height="200" width="150">
													</div>
													<div class="col-md-8">
														<div class="card-body">
															<h5 class="card-title">
																<a>${item.book.title}</a>
															</h5>
															<input type="hidden" name="bookId"
																value="${item.book.bookId}" class="bookId">
															<div class="btn-group" role="group"
																aria-label="Basic example">
																<button type="button"
																	class="btn btn-secondary d-inline col-sm-2 minus"
																	id="minus">-</button>
																<input type="text" id="quantity"
																	name="${item.book.bookId}" value="${item.quantity}"
																	class="col-sm-2 form-control d-inline qty"
																	readonly="readonly">
																<button type="button"
																	class="btn btn-secondary d-inline col-sm-2 plus"
																	id="plus">+</button>
															</div>
															<div>
																<span>X</span>&nbsp;Rs: <span>${item.book.price}</span>
															</div>
															<div>
																<h5>
																	<span>=</span>&nbsp;Rs: <span
																		id="itemTotal${item.book.bookId}" class="itemTotal">${item.subtotal}</span>
																</h5>
															</div>
														</div>
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
								</div>
								<div class="card mb-4">
									<div class="card-header text-center">Delivery Address</div>
									<div class="card-body">
										<div class="form-row">
											<div class="col-md-6 mb-3">
												<label for="firstName">First Name</label> <input type="text"
													class="form-control" name="firstName" id="firstName"
													value="${loggedCustomer.firstname}" required>
											</div>
											<div class="col-md-6 mb-3">
												<label for="lastName">Last Name</label> <input type="text"
													class="form-control" name="lastName" id="lastName"
													value="${loggedCustomer.lastname}" required>
											</div>
										</div>
										<div class="form-row">
											<div class="col-md-6 mb-3">
												<label for="inputPhone">Recipient Phone</label> <input
													type="text" class="form-control" name="phone" id="phone"
													value="${loggedCustomer.phone}" required>
											</div>
										</div>
										<div class="form-row">
											<div class="col-md-12 mb-3">
												<label for="inputAddress1">Address Line 1</label> <input
													type="text" class="form-control" name="address1"
													id="address1" value="${loggedCustomer.addressLine1}"
													required>
											</div>
										</div>
										<div class="form-row">
											<div class="col-md-12 mb-3">
												<label for="inputAddress2">Address Line 2</label> <input
													type="text" class="form-control" name="address2"
													id="address2" value="${loggedCustomer.addressLine2}"
													required>
											</div>
										</div>
										<div class="form-row">
											<div class="col-md-6 mb-3">
												<label for="inputCity">City</label> <input type="text"
													class="form-control" name="city" id="city"
													value="${loggedCustomer.city}" required>
											</div>
											<div class="col-md-6 mb-3">
												<label for="state">State</label> <input type="text"
													class="form-control" name="state" id="state"
													value="${loggedCustomer.state}" required>
											</div>
										</div>
										<div class="form-row">
											<div class="col-md-6 mb-3">
												<label for="inputZipCode">Zip Code</label> <input
													type="text" class="form-control" name="zipCode"
													id="zipCode" value="${loggedCustomer.zipcode}" required>
											</div>
											<div class="col-md-6 mb-3">
												<label for="inputCountry">Country</label> <select
													id="inputCountry" class="form-control" name="country"
													required>
													<c:forEach items="${mapCountries}" var="country">
														<option value="${country.value}"
															<c:if test="${loggedCustomer.country eq country.value}">selected='selected'</c:if>>${country.key}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>
								</div>
								<div class="card">
									<div class="card-header text-center">Payment Option</div>
									<div class="card-body">
										<div class="form-row">
											<div class="col-md-6 mb-3">
												<label for="inputPaymentMethod">Payment Method</label> <select
													id="inputPaymentMethod" class="form-control"
													name="paymentMethod">
													<option value="Cash on Delivery">Cash on Delivery</option>
													<option value="paypal">PayPal or Credit Card</option>
												</select>
											</div>
										</div>
									</div>
								</div>

							</div>
							<div class="col-sm-4">
								<div class="card">
									<div class="card-header text-center">Price Details</div>
									<div class="card-body">
										<div class="row">
											<div class="col-sm-6 text-left">
												<span>Subtotal:</span>
											</div>
											<div class="col-sm-6 text-right">
												<input type="text" name="subtotal" id="subtotal" hidden="hidden"/>
												<span>Rs: </span><span id="totalAmount"></span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-6 text-left">
												<span>Tax:</span>
											</div>
											<div class="col-sm-6 text-right">
												<input type="text" name="tax" id="taxinput" hidden="hidden"/>
												<span>Rs: </span><span id="tax"></span>
											</div>
										</div>
										<div class="row">
											<div class="col-sm-6 text-left">
												<span>Shipping:</span>
											</div>
											<div class="col-sm-6 text-right">
												<input type="text" name="shippingFee" id="shipping" hidden="hidden"/>
												<span>Rs: </span><span id="shippingfee"></span>
											</div>
										</div>
										<hr>
										<div class="row">
											<div class="col-sm-6 text-left">
												<span>Total:</span>
											</div>
											<div class="col-sm-6 text-right">
												<input type="text" name="total" id="totalinput" hidden="hidden"/>
												<span>Rs: </span><span id="Total"></span>
											</div>
										</div>
										<br>
										<div>
											<button class="btn btn-primary" id="checkout"
												style="width: 100%">Confirm Order</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</c:if>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- Modal -->
	<jsp:include page="../common/model_message.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$('#checkoutForm').submit(function(event){
			//stop submit the form, we will post it manually.
			event.preventDefault();
			
			// Create an FormData object
			form_data = $(this).serialize();
			
			$.ajax({
				type: "POST",
				url: "place_order",
				data: form_data,
				success: function (response){
					$("#modalTitle").text("Register as a Customer");
					
					$("#message").text(response);
					$("#message").addClass('alert-success');
					$("#myModal").modal();
					$(".close").click(function(){
						window.location = "view_orders";
					});
				},
			});
		});
		
		$.validator.addMethod("nameRegex", function(value, element) {
	        return this.optional(element) || /^[a-z\s]+$/i.test(value);
	    }, "First name must contain only letters, and spaces.");
		
		$("#checkoutForm").validate({
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
	})
</script>
</html>