<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create New Category</title>
<script type="text/javascript" src="../js/jquery.min.js"></script>
<script type="text/javascript" src="../js/jquery.validate.min.js"></script>
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					<c:if test="${category != null}">
						Edit Category
					</c:if>
					<c:if test="${category == null}">
						Create New Category
					</c:if>
				</h4>
				<!-- divider -->
				<hr>
				<c:if test="${category != null}">
					<form method="post" action="update_category" id="categoryForm">
						<input type="hidden" name="categoryId"
							value="${category.categoryId}">
				</c:if>
				<c:if test="${category == null}">
					<form method="post" action="create_category" id="categoryForm">
				</c:if>
				<div class="form-group row">
					<label for="inputName" class="col-sm-2 col-form-label">Category
						Name</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="name" id="name"
							value="${category.name}">
					</div>
				</div>
				<div class="col-sm-10 text-right mb-3">
					<button type="button" class="btn btn-primary" id="buttonCancel">Cancel</button>
					<button type="submit" class="btn btn-primary">Save</button>
				</div>
				</form>
			</div>
		</div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- Modal -->
	<jsp:include page="../common/model_message.jsp"></jsp:include>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$.validator.addMethod("loginRegex", function(value, element) {
        return this.optional(element) || /^[a-z\-\&\s]+$/i.test(value);
    }, "Category name must contain only letters, numbers, or dashes.");
	
	// category form validation
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
		}
	});
});

$('#buttonCancel').click(function() {
	history.go(-1);
});
</script>
</html>