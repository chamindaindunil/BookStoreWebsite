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
	<form method="post" action="">
		<div class="card">
			<table class="table">
				<tbody>
					<tr>
						<td>
							<h5>You already wrote a review for this book</h5>
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
							<br>
							<input type="text" name="headline" class="form-control col-sm-10" value="${review.headline}" readonly>
							<br><br>
							<textarea rows="10" cols="70" name="comment" class="form-control col-sm-10" readonly>${review.comment}</textarea>
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
	$(document).ready(function(){
		$("#rateYo").rateYo({
		    starWidth: "40px",
		    fullStar: true,
		    rating: ${review.rating},
		    readOnly: true
		  });
	});
</script>
</html>