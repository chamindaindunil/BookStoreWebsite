<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Book to Order</title>
<jsp:include page="sources.jsp"></jsp:include>
</head>
<body>
	<div align="center">
		<h4>The book ${book.title} has been added to the order ID ${order.orderId}</h4>
		<br>
		<button type="button" class="btn btn-danger" onclick="javascript: self.close();">Close</button>
	</div>
	<script type="text/javascript">
		window.onunload = function() {
			window.opener.location.reload();
		}
	</script>
</body>
</html>