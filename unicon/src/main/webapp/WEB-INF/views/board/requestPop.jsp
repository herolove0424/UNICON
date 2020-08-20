<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
<title>친구 신청</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
function fn_friendRequest(id_1, id_2) {
	$.ajax({
		url : "${contextPath}/timeLine/friendRequestPop.do",
		type : 'post',
		data : {"id_1" : id_1, "id_2" : id_2}
	});
	alert("신청되었습니다.");
	window.close();
}
</script>
</head>
<body>
<div class="container" align="right">
	<c:choose>
		<c:when test="${alter==0 }">
			<h3 align="center">${id_2 }님에게 <br>친구 신청하시겠습니까?</h3>
			<input type="button" value="신청" class="btn btn-default btn-round" style="align-content: center;" onclick="fn_friendRequest('${sessionScope.member.id}', '${id_2}')">
		</c:when>
		<c:when test="${alter==1 }">
			<h3>이미 친구 관계 입니다.</h3>
			<input type="button" value="닫기" class="btn btn-default btn-round" onclick="javascript:window.close()">
		</c:when>
		<c:when test="${alter==2 }">
			<h3>이미 친구 신청 하셨습니다.</h3>
			<input type="button" value="닫기" class="btn btn-default btn-round" onclick="javascript:window.close()">
		</c:when>
		<c:when test="${alter==3 }">
			<h3>${id_2 }님으로 부터 도착한 친구 신청을 확인해주세요</h3>
			<a href="${contextPath}/timeLine/friendList.do?id=${id_1}" target="_parent">이동</a>
		</c:when>
		
	</c:choose>
</div>
	
</body>
</html>