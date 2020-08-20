<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
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
<title>비밀번호 완료 창</title>
<script>
	function bye() {
		window.open("about:blank","_self").close();
	}
</script>
</head>
<body>
	<div class="col-lg-4 col-md-6 mx-auto">
		<div class="card card-login">
		<div class="card-header card-header-info text-center">
					<h4 class="card-title">비밀번호 변경 완료!!</h4>
				</div>
			</div>
	</div>
	<table>
	<div class="footer text-center">
					<button type="button" class="btn btn-success"
						onclick="javascript:bye();">로그인하러 가기</button>
	</div>
	</table>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>