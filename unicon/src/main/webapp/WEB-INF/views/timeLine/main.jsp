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
<title>타임라인</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<a href="${contextPath}/main.do">뒤로 가기</a>
	<br>
	<form>
		<%-- <%String name = (String)session.getAttribute("name"); %> --%>
		<h3>환영합니다. ${member.nickname}님!</h3>
		<a href="${contextPath}/friend/newsFeed.do"><h3>타임라인 이동</h3></a>
		<a href="${contextPath}/friend/friendList.do?id=${member.id}"><h3>친구 목록</h3></a>
		<a href="${contextPath}/friend/search.do"><h3>친구 찾기</h3></a>
	</form>
</body>
</html>