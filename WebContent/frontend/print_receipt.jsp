<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payment Receipt - Rathna Book Store</title>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<!-- Bootstrap -->
<link href="../bootstrap/css/bootstrap.min.css" rel="stylesheet">
<script src="../bootstrap/js/bootstrap.min.js"></script>
</head>
<body onload="window.print();">
	<div class="container">
		<div align="center">
			<img src="../images/Logo.png">
		</div>
		<div class="card">
			<div class="card-body"><jsp:directive.include file="../common/receipt.jsp" /></div>
		</div>
		<br>
	</div>
</body>
</html>