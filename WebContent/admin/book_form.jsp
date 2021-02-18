<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create New Book</title>

</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">
					<c:if test="${book != null}">
						Edit Book
					</c:if>
					<c:if test="${book == null}">
						Create New Book
					</c:if>
				</h4>
				<!-- divider -->
				<hr>
				<c:if test="${book != null}">
					<form method="post" action="update_book"
						enctype="multipart/form-data" id="bookForm">
						<input type="hidden" name="bookId" value="${book.bookId}">
				</c:if>
				<c:if test="${book == null}">
					<form method="post" action="create_book"
						enctype="multipart/form-data" id="bookForm">
				</c:if>
				<div class="form-group row">
					<label for="inputCategory" class="col-sm-2 col-form-label">Category</label>
					<div class="col-sm-8">
						<select id="inputCategory" class="form-control" name="category">
							<c:forEach items="${listCategory}" var="category">
								<c:if test="${category.categoryId eq book.category.categoryId}">
									<option value="${category.categoryId}" selected>
								</c:if>
								<c:if test="${category.categoryId ne book.category.categoryId}">
									<option value="${category.categoryId}">
								</c:if>
										${category.name}
									</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label for="inputTitle" class="col-sm-2 col-form-label">Title</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="title"
							id="inputTitle" value="${book.title}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputAuthor" class="col-sm-2 col-form-label">Author</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="author"
							id="inputAuthor" value="${book.author}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputIsbn" class="col-sm-2 col-form-label">ISBN</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="isbn" id="inputisbn"
							value="${book.isbn}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputpublishdate" class="col-sm-2 col-form-label">Publish
						Date</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="publishDate"
							id="publishDate"
							value='<fmt:formatDate pattern="MM/dd/yyyy" value="${book.publishDate}"/>'>
					</div>
				</div>
				<div class="form-group row">
					<label for="bookImageUpload" class="col-sm-2 col-form-label">Book
						Image</label>
					<div class="col-sm-8">
						<input type="file" class="form-control" name="bookImage"
							id="bookImage"> <img id="thumbnail" alt="Image Preview"
							src="data:image/jpg;base64,${book.base64Image}"
							style="width: 20%; margin-top: 10px">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputprice" class="col-sm-2 col-form-label">Price</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" name="price"
							id="inputprice" value="${book.price}">
					</div>
				</div>
				<div class="form-group row">
					<label for="inputDescription" class="col-sm-2 col-form-label">Description</label>
					<div class="col-sm-8">
						<textarea rows="5" cols="50" class="form-control" id="Description"
							name="description">${book.description}</textarea>
					</div>
				</div>
				<div class="col-sm-10 text-right mb-3">
					<button type="button" class="btn btn-primary" id="buttonCancel">Cancel</button>
					<button type="submit" class="btn btn-primary" id="butonSave">Save</button>
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
	$('#buttonCancel').click(function(){
		history.go(-1);
	})
	
	$(document).ready(function() {		
		$('#publishDate').datepicker();
		
		$('#bookImage').change(function() {
			showImageThumbnail(this);
		});
		
		$.validator.addMethod("authorRegex", function(value, element) {
	        return this.optional(element) || /^[a-z\s\,]+$/i.test(value);
	    }, "Author name must contain only letters.");
		
		$.validator.addMethod("priceRegex", function(value, element) {
	        return this.optional(element) || /^(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/i.test(value);
	    }, "Please enter valid price value.");
	    
	    $.validator.addMethod("filesize", function(value, element, param) {
	        return this.optional(element) || (element.files[0].size <= param);
	    }, "File size must be less than {0}");
		
		$("#bookForm").validate({
			rules: {
				category: "required",
				title: "required",
				author: {
	                required: true,
	                authorRegex: true,
	            },
	            isbn: {
	                required: true,
	                number: true,
	                min: 1
	            },
				publishDate: "required",
				<c:if test="${book == null}">
				bookImage: {
					required: true,
					extension: "jpg,jpeg",
					filesize: 1024 * 300,
				},
				</c:if>
				price: {
	                required: true,
	                priceRegex: true,
	                min: 1,
	            },
	            description: {
	            	required: true,
	            	minlength: 10,
	            },
			},
			messages: {
				category: "Please select a category for the book",
				title: "Please enter title of the book",
				author: {
					required: "Please enter author of the book",
					authorRegex: "Please enter valid author name"
				},
				isbn: {
					required: "Please enter ISBN of the book",
					number: "ISBN must be a number",
					min: "ISBN must be greater than 0",
				},
				publishDate: "Please enter publish date of the book",
				
				bookImage: {
					required: "Please choose an image of the book",
					extension: "Please upload only jpg or jpeg files.",
					filesize: "File size must be less than 300KB"
				},
				
				price: {
					required: "Please enter price of the book",
					priceRegex: "Please enter valid price value",
					min: "Price must be greater than 0",
				},
				description: {
					required: "Please enter description of the book",
					minlength: "Enter more than 10 characters"
				}
			},
			errorElement: "em",
			errorPlacement: function ( error, element ) {
				// Add the `invalid-feedback` class to the error element
				error.addClass( "invalid-feedback" );

				error.insertAfter( element );
			},
			highlight: function ( element, errorClass, validClass ) {
				$( element ).addClass( "is-invalid" ).removeClass( "is-valid" );
			},
			unhighlight: function (element, errorClass, validClass) {
				$( element ).addClass( "is-valid" ).removeClass( "is-invalid" );
			}
		})
	});
	
	function showImageThumbnail(fileInput){
		var file = fileInput.files[0];
		
		var reader = new FileReader();
		
		reader.onload = function(e) {
			$('#thumbnail').attr('src', e.target.result);
		};
		
		reader.readAsDataURL(file);
	}
	</script>
</html>