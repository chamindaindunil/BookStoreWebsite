<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="col mb-4">
	<div class="card h-100">
		<a href="view_book?id=${book.bookId}"> <img
			src="data:image/jpg;base64,${book.base64Image}" class="card-img-top"
			width="128" height="300">
		</a>
		<div class="card-body">
			<h5 class="card-title">
				<a href="view_book?id=${book.bookId}">${book.title}</a>
			</h5>
			<p class="card-text">
				<jsp:directive.include file="book_rating.jsp" />
			</p>
			<p class="card-text">by ${book.author}</p>
			<b>Rs: <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${book.price}" /></b>
		</div>
	</div>
</div>