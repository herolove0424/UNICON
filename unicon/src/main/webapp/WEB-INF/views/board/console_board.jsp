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
				플랫폼
			</td>
			<td>
				제목
			</td>
			<td>
				작성자
			</td>
			<td>
				작성일
			</td>
			<td>
				조회수
			</td>
		</tr>
		<c:forEach var="console" items="${consolelist}" varStatus="status">
		<tr>
			<td>
				${console.platform}
			</td>
			<td>
				${console.title}
			</td>
			<td>
				${console.id}
			</td>
			<td>
				${console.writeDate}
			</td>
			<td>
				${console.viewCount}
			</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>