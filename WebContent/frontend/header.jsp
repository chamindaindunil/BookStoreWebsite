<jsp:include page="sources.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div align="center">
	<img src="images/Logo.png">
</div>
<nav class="navbar navbar-expand-lg navbar-primary bg-light">
	<a class="navbar-brand" href="${pageContext.request.contextPath}">Rathna Bookstore</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarNavDropdown">
		<form class="form-inline" action="search" method="get">
			<input class="form-control mr-sm-2" type="search" name="keyword"
				placeholder="Search" aria-label="Search">
			<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
		</form>
		<ul class="navbar-nav ml-auto">
			<c:if test="${loggedCustomer == null}">
				<li class="nav-item"><a class="nav-link" href="login">Sign
					In</a></li>
				<li class="nav-item"><a class="nav-link" href="register"><i
					class="fa fa-user"></i> Register</a></li>
			</c:if>
			<c:if test="${loggedCustomer != null}">
				<li class="nav-item"><a class="nav-link" href="view_cart"><i
					class="fa fa-shopping-cart"></i> Cart</a></li>
				<li class="nav-item"><a class="nav-link" href="view_profile">Welcome, ${loggedCustomer.fullname}</a></li>
				<li class="nav-item"><a class="nav-link" href="view_orders"><i
					class="fa fa-user"></i> My Orders</a></li>
				<li class="nav-item"><a class="nav-link" href="logout"><i
					class="fa fa-sign-out-alt"></i> Logout</a></li>
			</c:if>
		</ul>
	</div>
</nav>
<br>
<div class="card">
	<ul class="nav nav-tabs nav-fill">
		<c:forEach var="category" items="${listCategory}" varStatus="status">
			<li class="nav-item"><a class="nav-link active"
				href="view_category?id=${category.categoryId}"><c:out value="${category.name}"></c:out></a></li>
		</c:forEach>
	</ul>
</div>