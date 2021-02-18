<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Categories - Rathna Bookstore Administration</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					Category Management
					<a href="category_form.jsp" class="btn btn-sm btn-primary float-right">Create New Category</a>
				</h4>
				<!-- divider -->
				<hr>
				<!-- message -->
				<c:if test="${message != null}">
					<div class="alert alert-info text-center" role="alert">${message}</div>
				</c:if>
				<!-- data table -->
				<table class="table">
					<thead>
						<tr>
							<th>Index</th>
							<th>ID</th>
							<th>Name</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="cat" items="${listCategory}" varStatus="status">
							<tr>
								<td>${status.index + 1}</td>
								<td>${cat.categoryId}</td>
								<td>${cat.name}</td>
								<td>
									<a href="edit_category?id=${cat.categoryId}"><i class="fas fa-edit"></i></a> &nbsp;&nbsp;&nbsp; 
									<a href="javascript:comfirmDelete(${cat.categoryId})"><i class="fas fa-trash-alt"></i></a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- Delete message -->
	<jsp:include page="delete_message.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function comfirmDelete(categoryId) {
		$("#deleteMessage").modal();
		$("#modalTitle").text('Delete a category');
		$("#message").text('Are you sure you want to delete the category with ID ' + categoryId + '?');
		
		$('#ok').click(function(){
			window.location = 'delete_category?id=' + categoryId;
		});
	}

	$(document).ready(function(){
		$("#submitBtn").click(function(){        
	        $("#categoryForm").submit(); // Submit the form
	    });
		$.validator.addMethod("loginRegex", function(value, element) {
	        return this.optional(element) || /^[a-z\-\&\s]+$/i.test(value);
	    }, "Category name must contain only letters, numbers, or dashes.");

		$("#categoryForm").validate({
			rules: {
				"name": {
	                required: true,
	                loginRegex: true,
	            }
			},
			messages: {
				"name": {
	                required: "You must enter a category name",
	                loginRegex: "Category name must contain only letters and dashes."
	            }
			},
			errorElement: "em",
			errorPlacement: function ( error, element ) {
				// Add the `invalid-feedback` class to the error element
				error.addClass( "invalid-feedback" );

				/* if ( element.prop( "type" ) === "checkbox" ) {
					error.insertAfter( element.next( "label" ) );
				} else {
					error.insertAfter( element );
				} */
				error.insertAfter( element );
			},
			highlight: function ( element, errorClass, validClass ) {
				$( element ).addClass( "is-invalid" ).removeClass( "is-valid" );
			},
			unhighlight: function (element, errorClass, validClass) {
				$( element ).addClass( "is-valid" ).removeClass( "is-invalid" );
			},
			
			submitHandler: function(form) {
				form_data = $(form).serialize();
			
				$.ajax({
					type: "POST",
					url: form.action,
					data: form_data,
					success: function (response){
						if (response.includes("successfully")) {
							$("#modalMessage").text(response);
							$("#modalMessage").addClass('alert-success');
							$("#modalMessage").removeClass('d-none');
							$(".form-group").addClass('d-none');
							$(".modal-footer").addClass('d-none');
							$(".close").click(function(){
								window.location = "list_category";
							});
						} else {
							$("#modalMessage").text(response);
							$("#modalMessage").addClass('alert-danger');
							$("#modalMessage").removeClass('d-none');
							$(".close").click(function(){
								window.location = "list_category";
							});
						}
					},
				})
			}
		})
	});
</script>
</html>