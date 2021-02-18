<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div align="center">
	<h5>Order Overview</h5>
	<table class="table table-bordered">
		<tbody>
			<tr>
				<th>Ordered By:</th>
				<td>${order.customer.fullname}</td>
			</tr>
			<tr>
				<th>Order Status:</th>
				<td>${order.status}</td>
			</tr>
			<tr>
				<th>Order Date:</th>
				<td>${order.orderDate}</td>
			</tr>
			<tr>
				<th>Payment Method:</th>
				<td>${order.paymentMethod}</td>
			</tr>
			<tr>
				<th>Book Copies:</th>
				<td>${order.bookCopies}</td>
			</tr>
			<tr>
				<th>Total Amount:</th>
				<td>Rs: ${order.total}</td>
			</tr>
		</tbody>
	</table>
	<h5>Recipient Information</h5>
	<table class="table table-bordered">
		<tbody>
			<tr>
				<th>First Name:</th>
				<td>${order.firstname}</td>
			</tr>
			<tr>
				<th>Last Name:</th>
				<td>${order.lastname}</td>
			</tr>
			<tr>
				<th>Recipient Phone:</th>
				<td>${order.phone}</td>
			</tr>
			<tr>
				<th>Address Line1:</th>
				<td>${order.addressLine1}</td>
			</tr>
			<tr>
				<th>Address Line2:</th>
				<td>${order.addressLine2}</td>
			</tr>
			<tr>
				<th>City:</th>
				<td>${order.city}</td>
			</tr>
			<tr>
				<th>State:</th>
				<td>${order.state}</td>
			</tr>
			<tr>
				<th>Zip Code:</th>
				<td>${order.zipcode}</td>
			</tr>
			<tr>
				<th>Country:</th>
				<td>${order.countryName}</td>
			</tr>
		</tbody>
	</table>
</div>
<div align="center">
	<h5>Order Books</h5>
	<table class="table table-bordered">
		<thead class="thead-dark">
			<tr>
				<th>Index</th>
				<th>Book Title</th>
				<th>Author</th>
				<th>Price</th>
				<th>Quantity</th>
				<th>Sub Total</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${order.orderDetails}" var="orderDetail"
				varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td><img style="vertical-align: middle;"
						src="data:image/jpg;base64,${orderDetail.book.base64Image}"
						width="48" height="64"> ${orderDetail.book.title}</td>
					<td>${orderDetail.book.author}</td>
					<td><fmt:formatNumber value="${orderDetail.book.price}"
							type="currency" /></td>
					<td>${orderDetail.quantity}</td>
					<td><fmt:formatNumber value="${orderDetail.subtotal}"
							type="currency" /></td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5" align="right"><b>SUBTOTAL:</b></td>
				<td><b><fmt:formatNumber value="${order.subtotal}"
							type="currency" /></b></td>
			</tr>
			<tr>
				<td colspan="5" align="right"><b>TAX:</b></td>
				<td><b><fmt:formatNumber value="${order.tax}"
							type="currency" /></b></td>
			</tr>
			<tr>
				<td colspan="5" align="right"><b>Shipping Fee:</b></td>
				<td><b><fmt:formatNumber value="${order.shippingFee}"
							type="currency" /></b></td>
			</tr>
			<tr>
				<td colspan="5" align="right"><b>TOTAL:</b></td>
				<td><b><fmt:formatNumber value="${order.total}"
							type="currency" /></b></td>
			</tr>
		</tfoot>
	</table>
</div>