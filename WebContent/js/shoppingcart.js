$(document).ready(function() {	
	$('.minus').click(function(){
		quantityField = $(this).next();
		bookId = quantityField.attr("name");
		quantity = parseInt(quantityField.val(), 10) - 1;
		if (quantityField.val() > 1) {
			quantityField.val(quantity);
		}
		updateQuantity(bookId, quantity);
	});
	
	$('.plus').click(function() {
		quantityField = $(this).prev();
		bookId = quantityField.attr("name");
		quantity = parseInt(quantityField.val(), 10) + 1;
		if (quantityField.val() < 10) {
			quantityField.val(quantity);
		}
		updateQuantity(bookId, quantity);
	});
	
	$('.removeitem').click(function() {
		removeFromCart($(this));
	});
	
	$('#checkout').click(function(){
		window.location = contextUrl + '/checkout';
	});
		
	updateSubtotal();
	calculateTax();
	calculateShippingFee();
	updateTotal();
});

var appHost = window.location.host;
var appProtocol = window.location.protocol;
var pathArray = window.location.pathname.split('/');
var context = pathArray[1];

var contextUrl = appProtocol +"//"+ appHost +"/"+ context;

function removeFromCart(link){
	cartId = link.attr("name");
	
	url = contextUrl + '/remove_from_cart?cart_id=' + cartId;
	
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text"
	}).done(function(response){
		if (response.includes("removed")) {
			$("#myModal").on("hide.bs.modal", function(e){
				rowNumber = link.attr("id");
				removeBook(rowNumber);
				updateSubtotal();
				updateTotal();
			});
		}
		
		$("#modalBody").text(response);
		$("#myModal").modal();
	});
}

function removeBook(rowNumber){
	rowId = "row" + rowNumber;
	$("#" + rowId).remove();
}

function updateQuantity(bookId, quantity) {
	url = contextUrl + '/update_cart?book_id=' + bookId + '&quantity=' + quantity;
	$.ajax({
		type: "GET",
		url: url,
		dataType: "text"
	}).done(function(newItemTotal){
		updateItemTotal(newItemTotal, bookId);
		updateSubtotal();
		updateTotal();
	});
}

function updateItemTotal(newItemTotal, bookId){
	$("#itemTotal" + bookId).text(newItemTotal);
}

function updateSubtotal(){
	subtotal = 0.0;
	
	$(".itemTotal").each(function() {
		subtotal = subtotal + parseFloat($(this).text(), 10);
	});
	
	$("#totalAmount").text(subtotal.toFixed(2));
	$("#subtotal").text(subtotal.toFixed(2));
}

function calculateTax(){
	subtotal = parseFloat($("#totalAmount").text());
	
	tax = subtotal * 0.1;
	
	$("#tax").text(tax.toFixed(2));
	$("#taxinput").val(tax.toFixed(2));
}

function calculateShippingFee(){
	zipCode = $("#zipCode").text();
	shippingFee = 0.0;
	
	if(zipCode==11020){
		shippingFee = 120.00;
	} else {
		shippingFee = 300.00;
	}
	
	$("#shippingfee").text(shippingFee.toFixed(2));
	$("#shipping").val(shippingFee.toFixed(2));
}

function updateTotal(){
	subtotal = parseFloat($("#totalAmount").text());
	tax = parseFloat($("#tax").text());
	shipping = parseFloat($("#shippingfee").text());
	
	Total = subtotal + tax + shipping;
	
	$("#Total").text(Total.toFixed(2));
	$("#totalinput").val(Total.toFixed(2));
}