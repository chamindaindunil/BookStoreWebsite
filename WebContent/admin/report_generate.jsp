<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Generate Reports</title>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
	<div class="container">
		<div class="card">
			<div class="card-body">
				<h4 class="card-title">Generate Reports</h4>
				<!-- divider -->
				<hr>
				<form method="post" action="generate_report" id="reportForm">
					<div class="form-group row">
						<label for="inputreport" class="col-sm-2 col-form-label">Report
							Type</label>
						<div class="col-sm-5">
							<select id="reportType" class="form-control" name="reportType">
								<option value="1" selected>Orders Report</option>
								<option value="2">Customers Report</option>
								<option value="3">Users Report</option>
							</select>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputreport" class="col-sm-2 col-form-label">Duration</label>
						<div class="col-sm-5">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="inlineRadioOptions" id="inlineRadio1" value="option1">
								<label class="form-check-label" for="inlineRadio1">daily</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="inlineRadioOptions" id="inlineRadio2" value="option2">
								<label class="form-check-label" for="inlineRadio2">monthly</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="inlineRadioOptions" id="inlineRadio3" value="option3">
								<label class="form-check-label" for="inlineRadio3">annually</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio"
									name="inlineRadioOptions" id="inlineRadio4" value="option4">
								<label class="form-check-label" for="inlineRadio4">custom</label>
							</div>
						</div>
					</div>
					<div class="form-group row">
						<label for="inputpublishdate" class="col-sm-2 col-form-label">Date</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="fromDate"
								id="fromDate" readonly="readonly">
						</div>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="toDate" id="toDate"
								readonly="readonly">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-9 text-right">
							<button type="submit" class="btn btn-primary">Generate</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		<br>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$('#fromDate').datepicker();
		$('#toDate').datepicker();
	});
</script>
</html>