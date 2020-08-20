<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="isLogOn" value="${param.isLogOn}" />
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
<title>인증 완료</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
	<div class="main main-raised">
		<div class="section section-basic">
			<div class="container">
				<br>
				<h3>축하합니다!</h3>
				<p>메일인증이 완료되었습니다.</p><br>
				<p>로그인 하시면 홈페이지 내의 모든 서비스를 이용하실 수 있습니다.</p><br>
			</div>
		</div>
	</div>

</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>