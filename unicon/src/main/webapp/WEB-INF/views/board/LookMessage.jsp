<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
	rel="stylesheet" />

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style type="text/css">
.sans {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
<title>메세지 함</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<jsp:include page="../bootstrap/header.jsp"/>
<body>
	<div class="main main-raised">
		<div class="section section-basic">
			<div class="container">
				<h2 class="sans">쪽지 관리</h2>
				<div class="container">
					<input class="btn btn-default btn-round" type="button" value="받은 쪽지함" 
					onclick="location.href='${contextPath}/message/lookMessage.do'" style="width:49%">
					<input class="btn btn-default btn-round" type="button" value="보낸 쪽지함"
					onclick="location.href='${contextPath}/message/lookSendMessage.do'" style="width:49%">
					<!-- 나중에 구현하고 아작스 되면 해주끼...<a href="#">쪽지 쓰기</a> -->
				</div>
			</div>
			<jsp:include page="${whatPage}" flush="false"/>
		</div>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp"/>
</html>