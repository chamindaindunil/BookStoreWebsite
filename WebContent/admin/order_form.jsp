<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Order - Rathna Bookstore Administration</title>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Edit Order ID: ${order.orderId}
				</h4>
				<!-- divider -->
				<hr>
				<!-- message -->
				<c:if test="${message != null}">
					<div align="center">${message}</div>
				</c:if>
				<!-- order overview -->
				<form action="update_order" method="post" id="orderForm">
					<div>
						<h5>Order Overview</h5>
						<div class="form-group row">
							<label for="orderedBy" class="col-sm-2 col-form-label">Ordered
								By:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control-plaintext"
									name="orderedBy" value="${order.customer.fullname}">
							</div>
						</div>
						<div class="form-group row">
							<label for="orderedDate" class="col-sm-2 col-form-label">Order
								Date:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control-plaintext"
									name="orderedDate" value="${order.orderDate}">
							</div>
						</div>
						<div class="form-group row">
							<label for="paymentMethod" class="col-sm-2 col-form-label">Payment
								Method:</label>
							<div class="col-sm-8">
								<select id="paymentMethod" class="form-control"
									name="paymentMethod">
									<option value="Cash on Delivery" <c:if test="${order.paymentMethod eq 'Cash on Delivery'}">selected='selected'</c:if> >Cash on Delivery</option>
									<option value="paypal" <c:if test="${order.paymentMethod eq 'paypal'}">selected='selected'</c:if> >PayPal or Credit Card</option>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="orderStatus" class="col-sm-2 col-form-label">Order
								Status:</label>
							<div class="col-sm-8">
								<select id="orderStatus" class="form-control" name="orderStatus">
									<option value="Processing" <c:if test="${order.status eq 'Processing'}">selected='selected'</c:if>>Processing</option>
									<option value="Shipping" <c:if test="${order.status eq 'Shipping'}">selected='selected'</c:if>>Shipping</option>
									<option value="Delivered" <c:if test="${order.status eq 'Delivered'}">selected='selected'</c:if>>Delivered</option>
									<option value="Completed" <c:if test="${order.status eq 'Completed'}">selected='selected'</c:if>>Completed</option>
									<option value="Cancelled" <c:if test="${order.status eq 'Cancelled'}">selected='selected'</c:if>>Cancelled</option>
								</select>
							</div>
						</div><br>
						<h5>Recipient information</h5><br>
						<div class="form-group row">
							<label for="recipientFirstName" class="col-sm-2 col-form-label">First
								Name:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="firstName"
									value="${order.firstname}" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipientLastName" class="col-sm-2 col-form-label">Last
								Name:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="lastName"
									value="${order.lastname}" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipientPhone" class="col-sm-2 col-form-label">
								Phone:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="phone"
									value="${order.phone}" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="shippingAddress" class="col-sm-2 col-form-label">
								Address Line1:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="address1"
									value="${order.addressLine1}" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="shippingAddress" class="col-sm-2 col-form-label">
								Address Line2:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="address2"
									value="${order.addressLine2}" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="city" class="col-sm-2 col-form-label">
								City:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="city"
									value="${order.city}" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="state" class="col-sm-2 col-form-label">
								State:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="state"
									value="${order.state}" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="zipCode" class="col-sm-2 col-form-label">
								Zip Code:</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" name="zipCode"
									value="${order.zipcode}" required>
							</div>
						</div>
						<div class="form-group row">
							<label for="country" class="col-sm-2 col-form-label">Country</label>
							<div class="col-sm-8">
								<select id="country" class="form-control" name="country"
									required>
									<c:forEach items="${mapCountries}" var="country">
										<option value="${country.value}"
											<c:if test="${order.country eq country.value}">selected='selected'</c:if>>${country.key}</option>
									</c:forEach>
								</select>
							</div>
						</div>
					</div>
					<div align="center">
						<h5>Order Books</h5>
						<table class="table table-bordered">
							<thead class="thead-dark">
								<tr>
									<th>Index</th>
									<th>Book Title</th>
									<th>Author</th>
									<th>Price</th>
									<th>Quantity</th>
									<th>Sub Total</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${order.orderDetails}" var="orderDetail"
									varStatus="status">
									<tr>
										<td>${status.index + 1}</td>
										<td>${orderDetail.book.title}</td>
										<td>${orderDetail.book.author}</td>
										<td>
											<input type="hidden" name="price" value="${orderDetail.book.price}">
											<fmt:formatNumber value="${orderDetail.book.price}"
												type="currency" /></td>
										<td>
											<input type="hidden" name="bookId" value="${orderDetail.book.bookId}">
											<input type="text" name="quantity${status.index + 1}"
											class="form-control" size="5" value="${orderDetail.quantity}" required>
										</td>
										<td><fmt:formatNumber value="${orderDetail.subtotal}"
												type="currency" /></td>
										<td><a
											href="remove_book_from_order?id=${orderDetail.book.bookId}">Remove</a></td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<tr>
								<td colspan="5" align="right">
									<b>SUBTOTAL:</b>
								</td>
								<td colspan="2" align="right">
									<b><fmt:formatNumber value="${order.subtotal}" type="currency" /></b>
								</td>
							</tr>
							<tr>
								<td colspan="5" align="right">
									<b>TAX:</b>
								</td>
								<td colspan="2" align="right">
									<input type="text" name="tax"  class="form-control col-sm-6" value="${order.tax}" size="5" required>
								</td>
							</tr>
							<tr>
								<td colspan="5" align="right">
									<b>Shipping Fee:</b>
								</td>
								<td colspan="2" align="right">
									<input type="text" name="shippingFee"  class="form-control col-sm-6" value="${order.shippingFee}" size="5" required>
								</td>
							</tr>
							<tr>
								<td colspan="5" align="right">
									<b>TOTAL:</b>
								</td>
								<td colspan="2" align="right">
									<b><fmt:formatNumber value="${order.total}" type="currency" /></b>
								</td>
							</tr>
							</tfoot>
						</table>
					</div>
					<div align="center">
						<a href="javascript:showAddBookPopup()" class="btn btn-secondary">Add Books</a>
						<button type="submit" class="btn btn-primary">Save</button>
						<button type="button" class="btn btn-danger"
							onclick="javascript:window.location.href='list_order';">Cancel</button>
					</div>
				</form>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$.validator.addMethod("nameRegex", function(value, element) {
	        return this.optional(element) || /^[a-z\s]+$/i.test(value);
	    }, "First name must contain only letters, and spaces.");
		
		$.validator.addMethod("priceRegex", function(value, element) {
	        return this.optional(element) || /^(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/i.test(value);
	    }, "Please enter valid price value.");
		
		$("#orderForm").validate({
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
	                minlength: 10
	            },
	            address1: "required",
	            address2: "required",
	            city: "required",
	            state: "required",
	            zipCode: {
	                required: true,
	                number: true,
	            },
	            <c:forEach items="${order.orderDetails}" var="book" varStatus="status">
					quantity${status.index + 1}: {
						required: true, number: true, min: 1
					},
				</c:forEach>
				tax: {
					required: true,
					priceRegex: true,
					min: 1
				},
				shippingFee: {
					required: true,
					priceRegex: true,
					min: 1
				},
			},
			messages: {
				firstName: {
	                required: "First Name is required",
	                nameRegex: "First name must contain only letters."
	            },
	            lastName: {
	                required: "Last Name is required",
	                nameRegex: "Last name must contain only letters."
	            },
				phone: {
					required: "Phone Number is required",
					number: "Phone number must be a number"
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
				<c:forEach items="${order.orderDetails}" var="book" varStatus="status">
					quantity${status.index + 1}: { 
						required: "Quantity is required",
						number: "Quantity must be a number",
						min: "Quantity must be greater than 0"
					},
				</c:forEach>
				tax: {
					required: "Tax is required",
					priceRegex: "Tax must be a number or decimal number.",
					min: "Tax must be greater than 0"
				},
				shippingFee: {
					required: "shippingFee is required",
					priceRegex: "shippingFee must be a number or decimal number.",
					min: "shippingFee must be greater than 0"
				}
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

function showAddBookPopup() {
	var width = 600;
	var height = 300;
	var left = (screen.width - width) / 2;
	var top = (screen.height - height) / 2;
	window.open('add_book_form', '_blank', 'width=' + width + ', height=' + height + ', top=' + top + ', left=' + left);
}
</script>
</html>