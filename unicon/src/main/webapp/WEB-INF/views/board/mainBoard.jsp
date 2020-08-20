<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
%>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 갈림길</title>
</head>
<body>
  <h2><a href="${contextPath}/board/Pc_Board_AllList.do">PC게시판</a></h2>
  <br>
  <h2><a href="${contextPath}/board/Mobile_Board_AllList.do">MOBILE게시판</a></h2>
  <br>
  <h2><a href="${contextPath}/board/Console_Board_AllList.do">CONSOLE게시판</a></h2>
  <br>
  <h2><a href="${contextPath}/board/Free_Board_AllList.do">FREE게시판</a></h2>
  <br>
  <h2><a href="${contextPath}/board/timeLine.do" >타임라인으로가자</a></h2>
  <br>
  <h2><a href="${contextPath}/board/myWall.do" >담벼락으로가자</a></h2>
</body>
</html>