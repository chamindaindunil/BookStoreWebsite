<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Write Review - Online Book Store</title>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="rateyo/jquery.rateyo.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="rateyo/jquery.rateyo.min.css"/>
</head>
<body>
	<div class="container">
	<jsp:include page="header.jsp"></jsp:include>
	<br>
	<form class="needs-validation" method="post" action="submit_review" novalidate>
		<div class="card">
			<table class="table">
				<tbody>
					<tr>
						<td>
							<h4>Write a Review</h4>
						</td>
						<td align="right">
							<h4>${loggedCustomer.fullname}</h4>
						</td>
					</tr>
					<tr>
						<td colspan="6"><h4 style="color: blue;">${book.title}</h4></td>
					</tr>
					<tr>
						<td>
							<img src="data:image/jpg;base64,${book.base64Image}" width="240" height="300">
						</td>
						<td>
							<div id="rateYo"></div>
							<input type="hidden" name="rating" id="rating">
							<input type="hidden" name="bookId" value="${book.bookId}">
							<br>
							<input type="text" name="headline" class="form-control col-sm-10" placeholder="Headline or summary for your review" required>
							<div class="invalid-feedback">
          						Headline is required
        					</div>
							<br><br>
							<textarea rows="10" cols="70" name="comment" class="form-control col-sm-10" placeholder="Write your review details..." required></textarea>
							<div class="invalid-feedback">
          						Comment is required
        					</div>
							<br>
							<div class="col-sm-10 text-center">
								<button type="submit" class="btn btn-lg btn-primary">Save</button>
								<button type="button" class="btn btn-lg btn-primary" id="buttonCancel">Cancel</button>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	<br>
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
	// Example starter JavaScript for disabling form submissions if there are invalid fields
	(function() {
		'use strict';
		window.addEventListener('load', function() {
			// Fetch all the forms we want to apply custom Bootstrap validation styles to
			var forms = document.getElementsByClassName('needs-validation');
			// Loop over them and prevent submission
			var validation = Array.prototype.filter.call(forms, function(form) {
				form.addEventListener('submit', function(event) {
					if (form.checkValidity() === false) {
						event.preventDefault();
						event.stopPropagation();
					}
					form.classList.add('was-validated');
				}, false);
			});
		}, false);
	})();
	
	$(document).ready(function(){
		$("#rateYo").rateYo({
		    starWidth: "40px",
		    fullStar: true,
		    onSet: function(rating, rateYoInstance){
		    	$("#rating").val(rating);
		    }
		  });
		
		$('#buttonCancel').click(function(){
			history.go(-1);
		})
	});
</script>
</html>