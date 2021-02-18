<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="sources.jsp"></jsp:include>
<nav class="navbar navbar-expand-lg navbar-primary bg-light">
	<a class="navbar-brand" href="${pageContext.request.contextPath}/admin/">Rathna Bookstore</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarNavDropdown">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="list_users">
					<i class="fa fa-users"></i> Users<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link"
				href="list_category"> <i class="fa fa-code-branch"></i> Categories<span
					class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link" href="list_books">
					<i class="fa fa-book"></i> Books<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link" href="list_customer">
					<i class="fas fa-user-friends"></i> Customers<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link" href="list_review">
					<i class="fa fa-thumbs-up"></i> Reviews<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link" href="list_order">
					<i class="fa fa-luggage-cart"></i> Orders<span class="sr-only">(current)</span>
			</a></li>
			<li class="nav-item active"><a class="nav-link" href="view_report_generate">
					<i class="fas fa-chart-line"></i> Reports<span class="sr-only">(current)</span>
			</a></li>
		</ul>
		<ul class="navbar-nav ml-auto">
			<li class="nav-item"><a class="nav-link" href="#"><i
					class="fa fa-user"></i> <c:out value="${sessionScope.useremail}"></c:out> </a></li>
			<li class="nav-item"><a class="nav-link" href="logout"><i
					class="fa fa-sign-out-alt"></i> Logout</a></li>
		</ul>
	</div>
</nav>
<br>