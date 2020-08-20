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
<style type="text/css">
</style>
<meta charset="UTF-8">
<%-- <link rel="apple-touch-icon" sizes="76x76"
	href="${contextPath}/resources/img/apple-icon.png">
<!-- <link rel="icon" type="image/png" href="../assets/img/favicon.ico"> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Management Main</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' /> --%>
<!--     Fonts and icons     -->
 <!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<!-- CSS Files -->
<%--  <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" /> --%>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">
<link href="${contextPath}/resources/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
<link href="../resources/css/demo.css" rel="stylesheet" />
</head>
<body>
	<div class="wrapper">
		<div class="sidebar" data-image="">
			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="${contextPath }/management/main.ddun" class="simple-text">
						UNICON</a>
				</div>
				<ul class="nav nav-pills">
					<li><a class="nav-link"
						href="${contextPath }/management/member_Search_Form.ddun"> <!--   <i class="nc-icon nc-circle-09"></i> -->
							<i class="fa fa-user-circle-o" style="font-size: 34px"></i>
							<p>회원 검색</p>
					</a></li>
					
					<li>
                        <a class="nav-link" href="${contextPath }/management/gamelist.ddun">
                            <i class="fa fa-keyboard-o" style="font-size:34px"></i>
                            <p>게임 등록</p>
                        </a>
                    </li>
                    
                    <li>
                        <a class="nav-link" href="${contextPath }/management/gameReview.ddun">
                            <i class="fa fa-commenting" style="font-size:34px"></i>
                            <p>게임 리뷰 관리</p>
                        </a>
                    </li>
                    
                    <li>
                        <a class="nav-link" href="${contextPath }/management/notice.ddun">
                            <i class="fa fa-warning" style="font-size:34px"></i>
                            <p>공지 관리</p>
                        </a>
                    </li>
                    
                    <%-- <li>
                        <a class="nav-link" href="${contextPath }/management/gameReview.ddun">
                            <i class="fa fa-commenting" style="font-size:34px"></i>
                            <p>신고 게시글 관리</p>
                        </a>
                    </li> --%>
                    
                    
					<c:if test="${member.grade==2 }">
					<li class="nav-item active active-pro">
                        <a class="nav-link active" href="${contextPath }/management/authorMain.ddun">
                            <i class="fa fa-id-card"></i>
                            <p>권한 관리</p>
                        </a>
                    </li>
					 </c:if> 
				</ul>
			</div>
		</div>
		<div class="main-panel">
		<!-- <h1>임시 관리자 화면입니다.</h1>  -->
             <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                <div class="container-fluid">
                    <a class="navbar-brand" href="${contextPath }/main.do" target="_blank">Fast Move</a>
                     <button href="${contextPath }/main.do" class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-bar burger-lines"></span>
                        <span class="navbar-toggler-bar burger-lines"></span>
                        <span class="navbar-toggler-bar burger-lines"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-end" id="navigation">
                        <ul class="nav navbar-nav mr-auto">
                            <!-- <li class="nav-item">
                                <a href="#" class="nav-link" data-toggle="dropdown">
                                    <i class="nc-icon nc-palette"></i>
                                     <span class="d-lg-none">Dashboard</span>
                                </a>
                            </li> -->
                            <li class="dropdown nav-item">
                                <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                    <i class="nc-icon nc-planet"></i>
                                    <!-- <span class="notification">5</span> -->
                                     <span class="d-lg-none">Fast Move To Site</span>
                                </a>
                                <ul class="dropdown-menu">
                                	<a class="dropdown-item" href="${contextPath }/info/gamelist.do" target="_blank">GAME INFO</a>
                                    <a class="dropdown-item" href="${contextPath }/board/Free_Board_AllList.do" target="_blank">FREE</a>
                                    <a class="dropdown-item" href="${contextPath }/board/Pc_Board_AllList.do" target="_blank">PC</a>
                                    <a class="dropdown-item" href="${contextPath }/board/Mobile_Board_AllList.do" target="_blank">MOBILE</a>
                                    <a class="dropdown-item" href="${contextPath }/board/Console_Board_AllList.do" target="_blank">CONSOLE</a>
                                </ul>
                            </li>
                           <!--  <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="nc-icon nc-zoom-split"></i>
                                    <span class="d-lg-block">&nbsp;Search</span>
                                </a>
                            </li> -->
                        </ul>
                        <ul class="navbar-nav ml-auto">
                            <li class="nav-item">
                                <a class="nav-link">
                                    <span class="no-icon">${sessionScope.memberforBoard }님</span>
                                </a>
                            </li>
                            <!-- <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="no-icon">Dropdown</span>
                                </a>
                                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                    <a class="dropdown-item" href="#">Action</a>
                                    <a class="dropdown-item" href="#">Another</a>
                                    <a class="dropdown-item" href="#">Something</a>
                                    <a class="dropdown-item" href="#">Something</a>
                                    <div class="divider"></div>
                                    <a class="dropdown-item" href="#">Separated link</a>
                                </div>
                            </li> -->
                            <li class="nav-item">
                                <a class="nav-link" href="${contextPath }/management/logout.do">
                                    <span class="no-icon">Log out</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
</body>
<!--   Core JS Files   -->
<%--  <script src="${contextPath}/resources/js/jquery.3.2.1.min.js"
	type="text/javascript"></script> 
<script src="${contextPath}/resources/js/core/jquery.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/core/popper.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"
	type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="${contextPath}/resources/js/bootstrap-switch.js"></script>
<!--  Chartist Plugin  -->
<script src="${contextPath}/resources/js/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${contextPath}/resources/js/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="${contextPath}/resources/js/light-bootstrap-dashboard.js?v=2.0.0 " type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="${contextPath}/resources/js/demo.js"></script>  --%>
</html>