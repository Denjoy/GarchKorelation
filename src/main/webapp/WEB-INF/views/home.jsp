<%@ include file="/common/taglib.jsp"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<link rel="icon" type="image/x-icon"
	href="${contextPath}/resources/img/favicon.ico" />
<title>Fignya</title>

<link rel='stylesheet'
	href='${contextPath}/resources/assets/bootstrap-3.3.7-dist/css/bootstrap.min.css'
	type='text/css' media='all' />
<link rel='stylesheet'
	href='${contextPath}/resources/assets/font-awesome-4.7.0/css/font-awesome.min.css'
	type='text/css' media='all' />
<link rel='stylesheet'
	href='${contextPath}/resources/css/all.css?ver=0.1' type='text/css'
	media='all' />

<link href="https://fonts.googleapis.com/css?family=Open+Sans"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=PT+Sans"
	rel="stylesheet">

</head>

<body class="modiphius-bg">
	<div class="header"></div>

	<table class="table table-striped">
		<thead>
			<tr>
				<th>date</th>
				<th>last price</th>
				<th>bid</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${stockList}" var="stock">
				<tr>
					<td>${stock.date }</td>
					<td>${stock.lastPrice}</td>
					<td>${stock.bid }</td>
				</tr>


			</c:forEach>

		</tbody>
	</table>

	<div class="footer"></div>
	<script type='text/javascript'
		src='${contextPath}/resources/js/jquery-3.2.0.min.js'></script>
	<script type='text/javascript'
		src='${contextPath}/resources/assets/bootstrap-3.3.7-dist/js/bootstrap.min.js'></script>
	<script type='text/javascript'
		src='${contextPath}/resources/js/script.js?ver=0.1'></script>
</body>
</html>