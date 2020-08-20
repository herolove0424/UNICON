<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../bootstrap/header.jsp" />
<meta charset="UTF-8">
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
	rel="stylesheet" />

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
	function fn_loginCheck(id) {
		if(${member.id == null}) {
			alert("로그인 후 이용해 주세요.");
			location.href='${contextPath}/member/loginForm.do';
		}
		else {
			$.ajax({
		        url : "${contextPath}/info/votesidCheck.do",
		        type : 'post',
		        data : {"id" : id},
		        success:function(data) {
					//	count값이 0일 경우 추천 가능
		        	if(data.count == 0) {
		        		window.open("${contextPath}/info/gamevoteslist.do",'투표 페이지', 'width=400 height=600 left=700 top=200');
		        	}
					//	count값이 1일 경우 이미 동일한 ID로 투표함
		        	else
		        	{
		        		alert("이미 투표하셨습니다.");
		        	}		        	
		        }
			});
		}
	}
	
	function fn_refresh() {
		location.reload();
	}
</script>
<meta charset="UTF-8">
<title>게임 인기 순위</title>
</head>
<body>
	<div class="main main-raised">
		<div class="section section-basic">
			<div class="container">
	<br>
	<h1 align="center" class="title">2020. 08 Game Ranking</h1>
	<br>
	<table style="align-content:center;" class="table">
		<tr height="10" align="center">
			<td>순위</td>
			<td>게임명</td>
			<td>득표수</td>
		</tr>
		<c:forEach var="rank" items="${rankList}">
			<tr align="center">
				<td>${rank.rownum}</td>
				<td><a href="${contextPath}/info/gameview.do?game_code=${rank.game_code}">${rank.game_name}</a></td>
				<td>
					${rank.votes}
				</td>
			</tr>
		</c:forEach>
	</table>
	<div align="center">
		<input type="button" class="btn btn-primary btn-round" value="투표하기" onclick="fn_loginCheck('${member.id}')">
	</div>
	<h6 style="color:gray" align="center">투표는 ID당 월 한 번씩만 가능하며 최대 3개까지 가능합니다.</h6>
	</div>
	</div>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>