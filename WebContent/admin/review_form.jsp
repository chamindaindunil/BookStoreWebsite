<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Review</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">Edit Category</h4>
				<!-- divider -->
				<hr>
				<form method="post" action="update_review" class="needs-validation" id="reviewForm">
					<input type="hidden" name="reviewId" value="${review.reviewId}">
					<div class="form-group row">
						<label for="book" class="col-sm-2 col-form-label">Book</label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" readonly="readonly" value="${review.book.title}">
						</div>
					</div>
					<div class="form-group row">
						<label for="rating" class="col-sm-2 col-form-label">Rating</label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" readonly="readonly" value="${review.rating}">
						</div>
					</div>
					<div class="form-group row">
						<label for="customer" class="col-sm-2 col-form-label">Customer</label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" readonly="readonly" value="${review.customer.fullname}">
						</div>
					</div>
					<div class="form-group row">
						<label for="headline" class="col-sm-2 col-form-label">Headline</label>
						<div class="col-sm-8">
							<input type="text" class="form-control-plaintext" name="headline" readonly="readonly"
								value="${review.headline}">
						</div>
					</div>
					<div class="form-group row">
						<label for="comment" class="col-sm-2 col-form-label">Comment</label>
						<div class="col-sm-8">
							<textarea rows="3" cols="70" class="form-control-plaintext" id="comment" readonly="readonly"
								name="comment">${review.comment}</textarea>
						</div>
					</div><br>
					<div class="form-group row">
						<label for="reply" class="col-sm-2 col-form-label">Reply</label>
						<div class="col-sm-8">
							<textarea rows="5" cols="70" class="form-control" id="reply"
								name="reply">${review.reply}</textarea>
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
	$(document).ready(function(){
		$.validator.addMethod("nameRegex", function(value, element) {
	        return this.optional(element) || /^[a-z\s]+$/i.test(value);
	    }, "Full name must contain only letters, and spaces.");
		
		$("#reviewForm").validate({
			rules: {
				reply: "required",
			},
			messages: {
				reply: "Please enter a reply for the review",
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
	$('#buttonCancel').click(function(){
		history.go(-1);
	})
	</script>
</html>