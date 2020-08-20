<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/lux/bootstrap.min.css" media="screen">
    <!-- <link rel="stylesheet" href="../_assets/css/custom.min.css"> -->
    <script>

     var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-23019901-1']);
      _gaq.push(['_setDomainName', "bootswatch.com"]);
        _gaq.push(['_setAllowLinker', true]);
      _gaq.push(['_trackPageview']);

     (function() {
       var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
       ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
       var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
     })();

    </script>
<title></title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <a class="navbar-brand" href="${contextPath}/main.do">Unicon</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor01">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#" style="font-size: 10pt;">게임목록 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item dropdown" style="float: right;">
        <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false" style="font-size: 10pt;">게시판 목록</a>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="${contextPath}/board/Free_Board_AllList.do">자유게시판</a>
          <a class="dropdown-item" href="${contextPath}/board/Pc_Board_AllList.do">PC게시판</a>
          <a class="dropdown-item" href="${contextPath}/board/Mobile_Board_AllList.do">Mobile게시판</a>
          <a class="dropdown-item" href="${contextPath}/board/Console_Board_AllList.do">Console게시판</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">타임라인</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${contextPath}/member/mypagepwForm.do">마이페이지</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${contextPath}/message/lookMessage.do">쪽지  ${sessionScope.remainMessage }</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="${contextPath}/member/logout.do">로그아웃</a>
      </li>
      
    </ul>
    <!-- <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="text" placeholder="Search">
      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
    </form> -->
  </div>
</nav>
</body>
</html>