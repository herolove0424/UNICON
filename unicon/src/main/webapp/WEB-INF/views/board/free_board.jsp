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
		<c:forEach var="free" items="${freelist}" varStatus="status">
		<tr>
			<td>
				${free.title}
			</td>
			<td>
				${free.id}
			</td>
			<td>
				${free.writeDate}
			</td>
			<td>
				${free.viewCount}
			</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>