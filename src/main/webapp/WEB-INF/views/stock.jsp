<%@ include file="/common/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="icon" type="image/x-icon" href="${contextPath}/resources/img/favicon.ico" />
<title>Stock</title>

<link rel='stylesheet' href='${contextPath}/resources/assets/bootstrap-3.3.7-dist/css/bootstrap.min.css' type='text/css' media='all' />
<link rel='stylesheet' href='${contextPath}/resources/assets/font-awesome-4.7.0/css/font-awesome.min.css' type='text/css' media='all' />
<link rel='stylesheet' href='${contextPath}/resources/css/stock.css' type='text/css' media='all' />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />
<link rel='stylesheet' href='${contextPath}/resources/css/all.css?ver=0.1' type='text/css' media='all' />

<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

</head>

<body class="modiphius-bg">
	<div class="header"></div>

	<div class="container">
		<div class='col-md-5'>
			<div class="form-group">
				<div class='input-group date' id='datetimepicker6'>
					<input type='text' class="form-control" /> <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
			</div>
		</div>
		<div class='col-md-5'>
			<div class="form-group">
				<div class='input-group date' id='datetimepicker7'>
					<input type='text' class="form-control" /> <span class="input-group-addon"> <span class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
			</div>
		</div>
	</div>


	<div id="chart" class="chartClass"></div>

	<div style="background: white;">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Date</th>
					<th>Last Price</th>
					<th>Bid</th>
					<th>Ask</th>
					<th>Min day price</th>
					<th>Max day price</th>
					<th>Avg day price</th>
					<th>Total</th>
					<th>%</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${!empty stockList}">
					<c:forEach items="${stockList}" var="stock">
						<tr>
							<td>${stock.date}</td>
							<td>${stock.lastPrice}</td>
							<td>${stock.bid}</td>
							<td>${stock.ask}</td>
							<td>${stock.minDayPrice}</td>
							<td>${stock.maxDayPrice}</td>
							<td>${stock.avgDayPrice}</td>
							<td>${stock.dayTotal}</td>
							<td>${stock.percentDay}</td>
						</tr>
					</c:forEach>
				</c:if>

			</tbody>
		</table>

	</div>


	<div class="footer"></div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>

	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type='text/javascript' src='${contextPath}/resources/js/script.js?ver=0.1'></script>
	<script type="text/javascript">
		google.charts.load('current', {
			packages : [ 'corechart', 'line' ]
		});
		google.charts.setOnLoadCallback(drawBasic);

		function drawBasic() {
			$.ajax({
				url : "http://localhost:8080/account/rest/getChart",
				type : 'get',
				dataType : "json",
				success : function(jsonData) {
					var data = new google.visualization.DataTable();
					// assumes "word" is a string and "count" is a number
					data.addColumn('string', 'date');
					data.addColumn('number', 'value');

					for (var i = 0; i < jsonData.length; i++) {
						data.addRow([ jsonData[i].date, jsonData[i].value ]);
					}

					var options = {
						title : 'Country Populations',
						legend : {
							position : 'none'
						},
						colors : [ '#e7711c' ],
						histogram : {
							lastBucketPercentile : 5
						},
						explorer : {
							actions : [ 'dragToZoom', 'rightClickToReset' ],
							axis : 'horizontal',
							keepInBounds : true
						},
						hAxis : {
							title : 'Date'
						},
						pointSize : 3,
						vAxis : {
							title : 'Value'
						}
					};

					var chart = new google.visualization.AreaChart(document
							.getElementById('chart'));
					chart.draw(data, options);
				},
				error : function() {
					alert('error!');
				}
			});
		}
	</script>

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
</body>
</html>