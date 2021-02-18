<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping Cart</title>
<!-- fontawesome -->
<link rel="stylesheet" href="fontawesome/css/all.min.css">
<script type="text/javascript" src="fontawesome/js/all.min.js"></script>

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/shoppingcart.js"></script>
</head>
<body>
	<div class="container">
		<jsp:include page="header.jsp"></jsp:include>
		<br>
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">Shopping Cart</h4>

				<c:if test="${fn:length(listCartItems) == 0}">
					<h4 align="center">There's no items in your cart</h4>
				</c:if>

				<c:if test="${fn:length(listCartItems) > 0}">
					<table class="table">
						<tr>
							<td><c:forEach items="${listCartItems}" var="item"
									varStatus="status">
									<div class="card mb-4">
										<div class="row no-gutters" id="row${status.count}">
											<div class="col-md-1 my-auto">
												<div>
													&nbsp;
													<button name="${item.id}" class="btn btn-link removeitem" id="${status.count}">
													<i class="fas fa-trash-alt"></i>
													</button>
												</div>
											</div>
											<div class="col-md-3">
												<img src="data:image/jpg;base64,${item.book.base64Image}"
													height="200" width="150">
											</div>
											<div class="col-md-8">
												<div class="card-body">
													<h5 class="card-title">
														<a href="">${item.book.title}</a>
													</h5>
													<input type="hidden" name="bookId"
														value="${item.book.bookId}" class="bookId">
													<div class="btn-group" role="group"
														aria-label="Basic example">
														<button type="button"
															class="btn btn-secondary d-inline col-sm-2 minus"
															id="minus">-</button>
														<input type="text" id="quantity"
															name="${item.book.bookId}" value="${item.quantity}"
															class="col-sm-2 form-control d-inline qty"
															readonly="readonly">
														<button type="button"
															class="btn btn-secondary d-inline col-sm-2 plus"
															id="plus">+</button>
													</div>
													<div>
														<span>X</span>&nbsp;Rs: <span><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${item.book.price}" /></span>
													</div>
													<div>
														<h5>
															<span>=</span>&nbsp;Rs: 
															<span id="itemTotal${item.book.bookId}" class="itemTotal"><fmt:formatNumber type="number" minFractionDigits="2" maxFractionDigits="2" value="${item.subtotal}" /></span>
														</h5>
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:forEach></td>
							<td align="right">
								<div class="card" style="width: 300px">
									<div class="col-sm-12" align="center">
										<h3>Order Summary</h3>
									</div>
									<hr>
									<div class="row mx-1">
										<div class="col-sm-6" align="left">
											<span>Total:</span>
										</div>
										<div class="col-sm-6" align="right">
											<span>Rs:</span><span id="totalAmount"></span>
										</div>
									</div>
									<hr>
									<div class="col-sm-12 mb-3" align="center">
										<button class="btn btn-primary" id="checkout"
											style="width: 100%">Checkout</button>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</c:if>
			</div>
		</div>
		<br>
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
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>