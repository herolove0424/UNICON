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
<title>로그인확인창</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<!-- 관리자단 이동 추가 : 07.06 김도경 -->
	<c:if test="${member.grade!=0 }">
		<form action="">
			<a href="${contextPath}/management/main.ddun">관리자 페이지로 이동</a>
		</form>
	</c:if>

	<form>
		<%-- <%String name = (String)session.getAttribute("name"); %> --%>
		<h3>환영합니다. ${member.nickname}님!</h3>
		<a href="${contextPath}/member/logout.do"><h3>로그아웃</h3></a>
		<a href="${contextPath}/info/gamelist.do"><h3>게임 목록으로 이동</h3></a>
		<a href="${contextPath}/board/mainBoard.do"><h3>게시판  목록으로 이동</h3></a>
		<a href="${contextPath}/member/mypagepwForm.do"><h3>마이페이지</h3></a>
		<a href="${contextPath}/message/lookMessage.do"><h3>쪽지 ${remainMessage }</h3></a>
	</form>
</body>
</html>