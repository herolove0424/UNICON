<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
   request.setCharacterEncoding("UTF-8");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <!--     Fonts and icons     -->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<!-- CSS Files -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.0/minty/bootstrap.min.css">
<title>회원 정보 상세 페이지</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">

</style>

</head>
	<jsp:include page="../bootstrap/managerSerchSidebar.jsp"></jsp:include>
<body>
	
	<!-- 기본적으로 나오는것  초기 화면-->
	
	
	 <div>
		<div class="table-responsive">
		<c:choose>
			<c:when test="${detail_Info.id!=''||detail_Info.id!=null }">
			<table class="table table-condensed">
		
			<tr>
			<td><strong>이름</strong></td>
			<td>${detail_Info.name }</td>
			</tr>
			
			<tr>
			<td><strong>아이디</strong></td>
			<td>${detail_Info.id }</td>
			</tr>
			
			<tr>
			<td><strong>가입일</strong></td>
			<td><fmt:formatDate value="${detail_Info.join_date }" pattern="YYYY/MM/d HH:mm:ss"/></td>
			</tr>
			
			<tr>
			<td><strong>성별</strong></td>
			<td>${detail_Info.sex }</td>
			</tr>
	
			<tr>
			<td><strong>닉네임</strong></td>
			<td>${detail_Info.nickname }</td>
			</tr>
	
			<tr>
			<td><strong>휴대폰 번호</strong></td>
			<td>${detail_Info.phone_number }</td>
			</tr>
	
			<tr>
			<td><strong>생년월일</strong></td>
			<td>${detail_Info.birthday }</td>
			</tr>
	
			<tr>
			<td><strong>이메일</strong></td>
			<td>${detail_Info.email }</td>
			</tr>
			
			<!-- 게임장르 관련 -->
			<tr>
			<c:if test="${detail_Info.genre1==null and detail_Info.genre2==null  }">
				<td><strong>게임 장르</strong></td>
				<td>선택된 게임 장르가 없습니다.</td>
			</c:if>
			<tr>
			<c:if test="${detail_Info.genre1!=null or detail_Info.genre2!=null  }">
				<td><strong>게임 장르</strong></td>
				<td>${detail_Info.genre1 }   ${detail_Info.genre2 }</td>
			</c:if>
			</tr>
			<!-- 게임장르 관련 -->
			
			<!-- 해시 태그 관련 -->
			<tr>
			<c:if test="${detail_Info.hashtag1==null and detail_Info.hashtag2==null and detail_Info.hashtag3==null }">
				<td><strong>해시 태그</strong></td>
				<td>선택된 해시태그가 없습니다.</td>
			</c:if>
			</tr>
			<tr>
			<c:if test="${detail_Info.hashtag1!=null or detail_Info.hashtag2!=null or detail_Info.hashtag3!=null }">
				<td><strong>해시 태그</strong></td>
				<td>${detail_Info.hashtag1 }  ${detail_Info.hashtag2 }  ${detail_Info.hashtag3 }</td>
			</c:if>
			</tr>
			
			<tr>
			<td><strong>플레이</strong></td>
			<td>${detail_Info.play_type }</td>
			</tr>
		</table>
			</c:when>
			<c:otherwise>
					<table>
						<tr>
							<td>검색된 아이디와 일치하는 정보가 없습니다.</td>
						</tr>
					</table>
				</c:otherwise>
		</c:choose>
		</div> 
		
		
	</div>
	
	

</body>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="${contextPath}/resources/js/bootstrap-switch.js"></script>
<!--  Chartist Plugin  -->
<script src="${contextPath}/resources/js/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${contextPath}/resources/js/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script
	src="${contextPath}/resources/js/light-bootstrap-dashboard.js?v=2.0.0 "
	type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="${contextPath}/resources/js/demo.js"></script>
</html>