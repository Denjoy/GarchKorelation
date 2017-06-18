<%@ include file="/common/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="icon" type="image/x-icon" href="${contextPath}/resources/img/favicon.ico" />
<title>Home</title>

<link rel='stylesheet' href='${contextPath}/resources/assets/bootstrap-3.3.7-dist/css/bootstrap.min.css' type='text/css' media='all' />
<link rel='stylesheet' href='${contextPath}/resources/assets/font-awesome-4.7.0/css/font-awesome.min.css' type='text/css' media='all' />
<link rel='stylesheet' href='${contextPath}/resources/css/all.css?ver=0.1' type='text/css' media='all' />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />

<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

</head>

<body class="modiphius-bg">
	<div class="header"></div>


	<div class="container">
		<div class='col-md-5'>
			<div class="form-group">
				<div class='input-group date' id='datetimepicker6'>
					<input id="start_date" type='text' class="form-control" /> <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
			</div>
		</div>
		<div class='col-md-5'>
			<div class="form-group">
				<div class='input-group date' id='datetimepicker7'>
					<input id="end_date" type='text' class="form-control" /> <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
			</div>
		</div>
		<select class="selectpicker" id="combobox">
			<c:forEach items="${stockNameList}" var="stockName">
				<option value="${stockName.ENName}">${stockName.name}</option>
			</c:forEach>
		</select>

		<button onclick="getByDate()">Get</button>
		<input id="predictSize" type='text' class="form-control" />
		<button onclick="getPrediction()">predict</button>
	</div>



	<div class="footer"></div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>

	<script type='text/javascript' src='${contextPath}/resources/js/script.js?ver=0.1'></script>

	<script type="text/javascript">
		$(function() {
			$('#datetimepicker6').datetimepicker({
				format : 'YYYY-MM-DD'
			});
			$('#datetimepicker7').datetimepicker({
				useCurrent : false,
				format : 'YYYY-MM-DD'
			//Important! See issue #1075
			});
			$("#datetimepicker6").on("dp.change", function(e) {
				$('#datetimepicker7').data("DateTimePicker").minDate(e.date);
			});
			$("#datetimepicker7").on("dp.change", function(e) {
				$('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
			});
		});
	</script>

	<script type="text/javascript">
		function getByDate() {
			var start = $('#start_date').val();
			var end = $('#end_date').val();
			var stockName = $('#combobox').find('option:selected').val();
			window.location.href = 'http://localhost:8080/account/stock/byDate?start='
					+ start + '&end=' + end + "&stockName=" + stockName;
		}
	</script>

	<script type="text/javascript">
		function getPrediction() {
			var start = $('#start_date').val();
			var end = $('#end_date').val();
			var stockName = $('#combobox').find('option:selected').val();
			var predictSize = $('#predictSize').val();
			window.location.href = 'http://localhost:8080/account/stock/predict?start='
					+ start
					+ '&end='
					+ end
					+ "&stockName="
					+ stockName
					+ "&predictSize=" + predictSize;
		}
	</script>

</body>
</html>