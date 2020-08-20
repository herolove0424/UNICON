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
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7" rel="stylesheet" />
<link href="${contextPath}/resources/css/modern-business.css" rel="stylesheet">

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css" ref="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
</head>
<body>
	<nav
		class="navbar fixed-top navbar-dark bg-dark navbar-expand-lg"
		color-on-scroll="100" id="sectionsNav">
		<div class="container">
			<div class="navbar-translate">
				<%-- <img src='${contextPath}/resources/img/uniconMain.png' style="width:80px; height:50px;"> --%>
				
				
				<a class="navbar-brand" href="${contextPath}/main.do">
					Unicon
				</a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					aria-expanded="false" aria-label="Toggle navigation">
					<span class="sr-only">Toggle navigation</span>
					<span class="navbar-toggler-icon"></span>
					<span class="navbar-toggler-icon"></span>
					<span class="navbar-toggler-icon"></span>
				</button>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item">
						<a class="nav-link" href="${contextPath}/info/gamelist.do">
							<i class="material-icons">videogame_asset</i>게임 목록
						</a>
					</li>
					<li class="dropdown nav-item">
						<a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
						<i class="material-icons">list</i>게시판 목록
					</a>
						 <div class="dropdown-menu dropdown-with-icons">
                     <a href="${contextPath}/board/Free_Board_AllList.do" class="dropdown-item">
                        <i class="material-icons">comment</i>자유게시판
                     </a>
                     <a href="${contextPath}/board/Pc_Board_AllList.do" class="dropdown-item">
                        <i class="material-icons">computer</i>PC게시판
                     </a>
                     <a href="${contextPath}/board/Mobile_Board_AllList.do" class="dropdown-item">
                        <i class="material-icons">smartphone</i>Mobile게시판
                     </a>
                     <a href="${contextPath}/board/Console_Board_AllList.do" class="dropdown-item">
                        <i class="material-icons">gamepad</i>Console게시판
                     </a>
                     <c:if test="${member.id != null}">
                     <a href="${contextPath}/board/timeLine.do" class="dropdown-item">
								<i class="material-icons">explore</i>타임라인
					 </a>
					 </c:if>
                  </div>
					</li>
					<c:choose>
						<c:when test="${empty member.id}">
							<li class="nav-item">
								<a class="nav-link" rel="tooltip"
								title="" data-placement="bottom"
								href="${contextPath}/member/loginForm.do"
								rel="nofollow">
									<i class="material-icons">login</i>로그인
								</a>
							</li>
						</c:when>
						<c:when test="${!empty member.id}">
							 <%-- 반갑습니다. ${member.nickname}님! --%>
							<li class="nav-item">
								<a class="nav-link" href="${contextPath}/member/mypagepwForm.do">
									<i class="material-icons">assignment_ind</i>마이페이지
								</a>
							</li>
							<!-- 쪽지로 인한 추가 -->
							<li class="nav-item">
								<a class="nav-link" href="${contextPath}/message/lookMessage.do">
									<i class="material-icons">message</i>쪽지 ${sessionScope.remainMessage }
								</a>
							</li>
							<li class="nav-item"><a class="nav-link" rel="tooltip"
								title="" data-placement="bottom"
								href="${contextPath}/member/logout.do" rel="nofollow"> <i
									class="material-icons">power_settings_new</i>로그아웃
							</a></li>
							<li class="nav-item"><a class="nav-link" href="#"> <i
									class="material-icons">loyalty</i>${member.nickname}님
							</a></li>

						</c:when>
					</c:choose>
				</ul>
			</div>
		</div>
	</nav>
</body>
</html>