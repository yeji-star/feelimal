<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/jsp/feelimals/common/head.jspf"%>
<meta charset="UTF-8">
<title>에러 페이지</title>
</head>
<body>
	<%@ include file="/WEB-INF/jsp/feelimals/common/header.jspf"%>
	<div id="main">
		<div class="fof">
			<h1>Error 404</h1>
		</div>
	</div>
</body>
</html>

<style>
* {
	transition: all 0.6s;
}

html {
	height: 100%;
}

body {
	font-family: 'Lato', sans-serif;
	color: #888;
	margin: 0;
}

#main {
	display: table;
	width: 100%;
	height: 100vh;
	text-align: center;
}

.fof {
	display: table-cell;
	vertical-align: middle;
}

.fof h1 {
	font-size: 50px;
	display: inline-block;
	padding-right: 12px;
	animation: type .5s alternate infinite;
}

@
keyframes type {
	from {box-shadow: inset -3px 0px 0px #888;
}

to {
	box-shadow: inset -3px 0px 0px transparent;
}
}
</style>