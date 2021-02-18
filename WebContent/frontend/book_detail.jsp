<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>${book.title}- Online Book Store</title>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/quantity-controller.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<div class="card">
			<table class="table">
				<tbody>
					<tr>
						<td colspan="3" align="left">
							<h2 style="color: blue;">${book.title}</h2> by ${book.author}
						</td>
					</tr>
					<tr>
						<td rowspan="2"><img
							src="data:image/jpg;base64,${book.base64Image}" width="240"
							height="300"></td>
						<td valign="top" align="left"><jsp:directive.include
								file="book_rating.jsp" /> <a href="#reviews">${fn:length(book.reviews)}Reviews</a>
						</td>
						<td valign="top" rowspan="2" width="20%">
							<h4 style="color: green;">Rs: <fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${book.price}" /></h4> <br> <label>Quantity:</label>
							<div class="btn-group" role="group" aria-label="Basic example">
								<button type="button"
									class="btn btn-secondary d-inline col-sm-2" id="minus">-</button>
								<input type="text" min="1" id="quantity" name="quantity"
									value="1" class="col-sm-3 form-control d-inline"
									readonly="readonly">
								<button type="button"
									class="btn btn-secondary d-inline col-sm-2" id="plus">+</button>
							</div> <br>
						<br>
							<button class="btn btn-primary" id="buttonAddToCart">Add
								to Cart</button>
						</td>
					</tr>
					<tr>
						<td valign="top">${book.description}</td>
					</tr>
					<tr>
						<td><h4>
								<a id="reviews">Customer Reviews</a>
							</h4></td>
						<td colspan="2" align="center">
							<button class="btn btn-info" id="buttonWriteReview">Write
								a Customer Review</button>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<table>
								<c:forEach items="${book.reviews}" var="review">
									<tr>
										<td><c:forTokens items="${review.stars}" delims=","
												var="star">
												<c:if test="${star eq 'on'}">
													<img src="images/rating-on.png">
												</c:if>
												<c:if test="${star eq 'off'}">
													<img src="images/rating-off.png">
												</c:if>
											</c:forTokens> - <b>${review.headline}</b> <br>
										<br> by ${review.customer.fullname} on
											${review.reviewTime} <br>
										<br> ${review.comment} <br> <b>Reply:</b>
											${review.reply}</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" data-backdrop="static"
		tabindex="-1" role="dialog" aria-labelledby="staticBackdropLabel"
		aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modalTitle">Shopping Cart</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body" id="modalBody">
					<div class="alert alert-info text-center" role="alert">${message}</div>
					<a href="view_cart" class="btn btn-primary">Go to the cart</a>
					<a href="${pageContext.request.contextPath}" class="btn btn-secondary">continue
						shopping</a>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$('#buttonWriteReview').click(function(){
			window.location = 'write_review?book_id=' + ${book.bookId};
		});
		
		$('#buttonAddToCart').click(function(){
			quantity = $('#quantity').val();
			window.location = 'add_to_cart?book_id=' + ${book.bookId} + '&quantity=' + quantity;
		});
		
		<c:if test="${message != null}">
			$("#myModal").modal();
		</c:if>
	})
</script>
</html>