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

		<button class="btn" onclick="getByDate()">Get</button>
		<input id="predictSize" type='text' class="form-control" />
		<button class="btn" onclick="getPrediction()">predict</button>
	</div>


	<c:if test="${!empty stockList}">
		<button class="btn" onclick="getImage()">get image</button>
		<a class="btn" href="${xmlFile}">xml</a>
		<a class="btn" href="${xlsFile}">xls</a>
		<a class="btn" href="${csvFile}">csv</a>
		<div id="chart" class="chartClass"></div>

		<!-- 	<p>Correlation coef: ${correlation}</p> -->
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

				</tbody>
			</table>

		</div>
	</c:if>


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

		var chart;

		var u = window.location.href;

		var i = u.indexOf("byDate");

		if (i !== -1) {
			u = 'B' + u.substring(i + 1);
		} else {
			i = u.indexOf("predict");
			if (i !== -1) {
				u = 'Prediction' + u.substring(i + 7);
			} else {
				u = "";
			}
		}

		function drawBasic() {
			$.ajax({
				url : "http://localhost:8080/account/rest/getChart" + u,
				type : 'get',
				dataType : "json",
				success : function(jsonData) {
					var data = new google.visualization.DataTable();
					// assumes "word" is a string and "count" is a number
					data.addColumn('string', 'date');
					data.addColumn('number', 'value');

					for (var i = jsonData.length - 1; i >= 0; --i) {
						data.addRow([ jsonData[i].date, jsonData[i].value ]);
					}

					var options = {
						title : 'Azazazazazaza',
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

					var chart_div = document.getElementById('chart');
					chart = new google.visualization.AreaChart(chart_div);

					chart.draw(data, options);
				},
				error : function() {
					alert('error!');
				}
			});
		}

		function getImage() {
			var a = $("<a>").attr("href", chart.getImageURI()).attr("download",
					"img.png").appendTo("body");
			a[0].click();

			a.remove();
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