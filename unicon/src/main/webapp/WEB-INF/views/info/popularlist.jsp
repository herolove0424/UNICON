<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<table class="table">
		<tr>
			<td>
				순위
			</td>
			<td>
				게임명
			</td>
			<td>
				장르
			</td>
			<td>
				배급사
			</td>
		</tr>
		<c:forEach var="popularlist" items="${popularlist}" varStatus="status">
		<tr>
			<td>
				${status.count}
			</td>
			<td>
				${popularlist.game_name}
			</td>
			<td>
				${popularlist.genre}
			</td>
			<td>
				${popularlist.share_company}
			</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>