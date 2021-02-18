<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="form-group row">
	<label for="inputEmail" class="col-sm-2 col-form-label">E-mail</label>
	<div class="col-sm-8">
		<input type="email" class="form-control" name="email" id="email"
			value="${customer.email}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputFirstName" class="col-sm-2 col-form-label">First
		Name</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" name="firstName"
			id="firstName" value="${customer.firstname}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputLastName" class="col-sm-2 col-form-label">Last
		Name</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" name="lastName" id="lastName"
			value="${customer.lastname}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
	<div class="col-sm-8">
		<input type="password" class="form-control" name="password"
			id="password" value="${customer.password}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputConfirmPassword" class="col-sm-2 col-form-label">Confirm
		Password</label>
	<div class="col-sm-8">
		<input type="password" class="form-control" name="confirmPassword"
			id="confirmPassword" value="${customer.password}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputPhoneNumber" class="col-sm-2 col-form-label">Phone
		Number</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" name="phone" id="phone"
			value="${customer.phone}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputAddress1" class="col-sm-2 col-form-label">Address
		Line 1</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" name="address1" id="address1"
			value="${customer.addressLine1}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputAddress2" class="col-sm-2 col-form-label">Address
		Line 2</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" name="address2" id="address2"
			value="${customer.addressLine2}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputCity" class="col-sm-2 col-form-label">City</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" name="city" id="city"
			value="${customer.city}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputState" class="col-sm-2 col-form-label">State</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" name="state" id="state"
			value="${customer.state}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputZipCode" class="col-sm-2 col-form-label">Zip
		Code</label>
	<div class="col-sm-8">
		<input type="text" class="form-control" name="zipCode" id="zipCode"
			value="${customer.zipcode}" required>
	</div>
</div>
<div class="form-group row">
	<label for="inputCountry" class="col-sm-2 col-form-label">Country</label>
	<div class="col-sm-8">
		<select id="inputCountry" class="form-control" name="country" required>
			<c:forEach items="${mapCountries}" var="country">
				<option value="${country.value}"
					<c:if test="${customer.country eq country.value}">selected='selected'</c:if>>${country.key}</option>
			</c:forEach>
		</select>
	</div>
</div>
<div class="col-sm-10 text-right mb-3">
	<button type="button" class="btn btn-primary" id="buttonCancel">Cancel</button>
	<button type="submit" class="btn btn-primary">Save</button>
</div>