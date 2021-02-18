<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payment Receipt - Rathna Book Store</title>
<script src="js/jquery.min.js" type="text/javascript"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<h5 align="center" style="color:green">
			<i>You have made payment successfully. Thank you for purchasing!</i>
		</h5>
		<div class="card">
			<div class="card-body">
				<jsp:directive.include file="../common/receipt.jsp" />
				<div class="text-center">
					<button type="button" class="btn btn-primary" onclick="javascript:showPrintReceiptPopup();">Print Receipt</button>
				</div>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<script>
		function showPrintReceiptPopup() {
			var width = 600;
			var height = 250;
			var left = (screen.width - width) / 2;
			var top = (screen.width - width) / 2;
			
			window.open('frontend/print_receipt.jsp', '_blank', 'width=' + width + 
					', height=' + height + ', top=' + top + ', left=' + left);
		}
	</script>
</body>
</html>