<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="isLogOn" value="${param.isLogOn}" />
<c:set var="id" value="${param.id}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
<title>이메일 인증 확인</title>
</head>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function fn_requestSend(id){
		alert("재전송하였습니다.");
		$.ajax({
			url : "${contextPath}/member/requestSend.do",
			type : 'post',
			data : {"id" : id},
			success : function(data){
				
			}
		});		
	}
	
	function fn_changeEmail(id) {
		window.open("${contextPath}/member/changeEmailForm.do?id=${id}",'이메일 변경', 'width=300 height=200 left=800 top=370');
	}
</script>
<body>
	<div class="section section-signup page-header">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-md-6 mx-auto">
					<div class="card card-login">
						<form class="form" name="login">
							<div class="card-header card-header-default text-center">
								<h4 class="card-title">Email</h4>
							</div>
							<br>
							<p align="center">${id}님 이메일 인증 후 로그인 가능합니다.</p>
							<br>
							<div class="footer text-center">
								<input type="button" class="btn btn-default col-md-8" value="재전송" onclick="fn_requestSend('${id}')"/><br>
								<br>
								<input type="button" class="btn btn-default col-md-8" value="이메일 재설정" onclick="fn_changeEmail('${id}')"/><br>
								<br>
								<input type="button" class="btn btn-default col-md-8" value="메인" onclick="location.href='${contextPath}/main.do'"/>							
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>	
</body>
</html>