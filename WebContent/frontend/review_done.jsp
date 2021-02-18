<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Review Posted - Online Book Store</title>
</head>
<body>
	<div class="container">
	<jsp:include page="header.jsp"></jsp:include>
	<br>
		<div class="card">
			<table class="table">
				<tbody>
					<tr>
						<td>
							<h4>Your Review</h4>
						</td>
						<td align="right">
							<h4>${loggedCustomer.fullname}</h4>
						</td>
					</tr>
					<tr>
						<td colspan="6"><h4>${book.title}</h4></td>
					</tr>
					<tr>
						<td>
							<img src="data:image/jpg;base64,${book.base64Image}" width="240" height="300">
						</td>
						<td colspan="3">
							<h3>Your review has been posted. Thank you!</h3>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	<br>
	<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>