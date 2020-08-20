<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="result" value="${param.result }" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#tag {
	font-size: 15px;
}
</style>
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

<style type="text/css">
.sans {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>

<title>비밀번호 확인</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<c:choose>
	<c:when test="${result=='notfindid'}">
		<script>
			window.onload = function() {
				alert("입력이 잘못되었습니다. 다시 한번 확인해 주세요")
			}
		</script>
	</c:when>
</c:choose>
</head>
<body>
	<div class="col-lg-4 col-md-6 mx-auto">
		<form class="form" action="${contextPath}/member/mypagepw.do"
			method="post">
			<div class="card card-login">
				<div class="card-header card-header-default text-center">
					<span class="sans" style="font-size: 15pt">비밀번호 재입력</span>
				</div>
				<div class="col-md-12">
					<div class="form-group">
						<label>Password</label>
						<input type="password" class="form-control" placeholder="Password" name="password" id="password">
					</div>
				</div>
				<div class="container" align="center" style="margin-bottom:20px">
					<input type="submit" class="btn btn-primary btn-round" style="width:20%;" value="확인">
					<input type="button" class="btn btn-primary btn-round" style="width:20%;" value="취소"
					onclick="location.href='${contextPath}/main.do'">
				</div>
			</div>
		</form>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>