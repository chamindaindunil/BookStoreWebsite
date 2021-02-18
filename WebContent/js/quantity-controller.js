$(document).ready(function() {
	$('#minus').click(function() {
		var qty = document.getElementById('quantity').value;
		var newqty = parseInt(qty) - 1;
		if (newqty > 0) {
			document.getElementById('quantity').value = newqty;
		}
	});
	$('#plus').click(function() {

		var qty = document.getElementById("quantity").value;
		var newqty = parseInt(qty) + 1;
		if (newqty < 10) {
			document.getElementById("quantity").value = newqty;
		}
	});

	/*
	 * $("#cartForm").validate({ rules: { <c:forEach items="${cart.items}"
	 * var="item" varStatus="status"> quantity${status.index + 1}: { required:
	 * true, number: true, min: 1 }, </c:forEach> }, messages: { <c:forEach
	 * items="${cart.items}" var="item" varStatus="status">
	 * quantity${status.index + 1}: { required: "Quantity is required", number:
	 * "Quantity must be a number", min: "Quantity must be greater than 0" },
	 * </c:forEach> }, errorElement: "em", errorPlacement: function ( error,
	 * element ) { // Add the `invalid-feedback` class to the error element
	 * error.addClass( "invalid-feedback" );
	 * 
	 * error.insertAfter( element ); }, highlight: function ( element,
	 * errorClass, validClass ) { $( element ).addClass( "is-invalid"
	 * ).removeClass( "is-valid" ); }, unhighlight: function (element,
	 * errorClass, validClass) { $( element ).addClass( "is-valid"
	 * ).removeClass( "is-invalid" ); } })
	 */
});