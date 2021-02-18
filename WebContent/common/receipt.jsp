<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<h4 align="center" class="card-title">Your Payment Receipt</h4>
<div>
	<h5 class="card-title">Seller Information</h5>
	<div class="form-group row">
		<label for="email" class="col-sm-2 col-form-label"><b>E-mail</b></label>
		<div class="col-sm-8">
			<input type="text" class="form-control-plaintext" name="email"
				id="email" value="sales@rathnabookstore.com">
		</div>
	</div>
	<div class="form-group row">
		<label for="phone" class="col-sm-2 col-form-label"><b>Phone</b></label>
		<div class="col-sm-8">
			<input type="text" class="form-control-plaintext" name="phone"
				id="phone" value="0112285456">
		</div>
	</div>
</div>
<hr>
<div>
	<h5 class="card-title">Buyer Information</h5>
	<div class="form-group row">
		<label for="firstName" class="col-sm-2 col-form-label"><b>First
				Name</b></label>
		<div class="col-sm-8">
			<input type="text" class="form-control-plaintext" name="firstName"
				id="firstName" value="${payer.firstName}">
		</div>
	</div>
	<div class="form-group row">
		<label for="lastName" class="col-sm-2 col-form-label"><b>Last
				Name</b></label>
		<div class="col-sm-8">
			<input type="text" class="form-control-plaintext" name="lastName"
				id="lastName" value="${payer.lastName}">
		</div>
	</div>
	<div class="form-group row">
		<label for="email" class="col-sm-2 col-form-label"><b>E-mail</b></label>
		<div class="col-sm-8">
			<input type="text" class="form-control-plaintext" name="email"
				id="email" value="${payer.email}">
		</div>
	</div>
</div>
<hr>
<div>
	<h5>Order Details</h5>
	<div class="form-group row">
		<label for="orderId" class="col-sm-2 col-form-label"><b>Order
				ID</b></label>
		<div class="col-sm-8">
			<input type="text" class="form-control-plaintext" name="orderId"
				id="orderId" value="${orderId}">
		</div>
	</div>
	<div class="form-group row">
		<label for="orderBy" class="col-sm-2 col-form-label"><b>Ordered
				By</b></label>
		<div class="col-sm-8">
			<input type="text" class="form-control-plaintext" name="orderBy"
				id="orderBy" value="${loggedCustomer.fullname}">
		</div>
	</div>
	<div class="form-group row">
		<label for="description" class="col-sm-2 col-form-label"><b>Description</b></label>
		<div class="col-sm-8">
			<input type="text" class="form-control-plaintext" name="description"
				id="description" value="${transaction.description}">
		</div>
	</div>
	<table class="table table-bordered">
		<thead class="thead-dark">
			<tr>
				<th>No.</th>
				<th>Name</th>
				<th>Quantity</th>
				<th>Price</th>
				<th>SubTotal</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${transaction.itemList.items}" var="item"
				varStatus="var">
				<tr>
					<td>${var.index +1}</td>
					<td>${item.name}</td>
					<td>${item.quantity}</td>
					<td align="right"><fmt:formatNumber value="${item.price}"
							type="currency" /></td>
					<td align="right"><fmt:formatNumber
							value="${item.price * item.quantity}" type="currency" /></td>
			</c:forEach>
			<tr>
				<td colspan="4" align="right">
					<p>
						<b>SubTotal: </b>
					</p>
					<p>
						<b>Tax: </b>
					</p>
					<p>
						<b>Shipping Fee: </b>
					</p>
					<p>
						<b>TOTAL: </b>
					</p>
				</td>
				<td align="right">
					<p>
						<b><fmt:formatNumber
								value="${transaction.amount.details.subtotal}" type="currency" /></b>
					</p>
					<p>
						<b><fmt:formatNumber value="${transaction.amount.details.tax}"
								type="currency" /></b>
					</p>
					<p>
						<b><fmt:formatNumber
								value="${transaction.amount.details.shipping}" type="currency" /></b>
					</p>
					<p>
						<b><fmt:formatNumber value="${transaction.amount.total}"
								type="currency" /></b>
					</p>
				</td>
			</tr>
		</tbody>
	</table>
</div>