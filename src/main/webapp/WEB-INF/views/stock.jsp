<%@ include file="/common/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="icon" type="image/x-icon" href="${contextPath}/resources/img/favicon.ico" />
<title>Fignya 2</title>

<link rel='stylesheet' href='${contextPath}/resources/assets/bootstrap-3.3.7-dist/css/bootstrap.min.css' type='text/css' media='all' />
<link rel='stylesheet' href='${contextPath}/resources/assets/font-awesome-4.7.0/css/font-awesome.min.css' type='text/css' media='all' />
<link rel='stylesheet' href='${contextPath}/resources/css/all.css?ver=0.1' type='text/css' media='all' />

<link href="https://fonts.googleapis.com/css?family=Open+Sans" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=PT+Sans" rel="stylesheet">

</head>

<body class="modiphius-bg">
	<div class="header"></div>

	<div id="chart"></div>

	<div class="footer"></div>

	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script type='text/javascript' src='${contextPath}/resources/js/jquery-3.2.0.min.js'></script>
	<script type='text/javascript' src='${contextPath}/resources/assets/bootstrap-3.3.7-dist/js/bootstrap.min.js'></script>
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
							title : 'X'
						},
						pointSize : 3,
						vAxis : {
							title : 'Y'
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
</body>
</html>