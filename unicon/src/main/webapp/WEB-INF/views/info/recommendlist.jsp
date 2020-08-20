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
<style type="text/css">
#tag {
	font-size: 15px;
}
</style>
<meta charset="UTF-8">
<title>게임 목록창</title>
</head>
<body>
	<div class="main main-raised">
		<div class="section section-basic">
			<div class="container">
				<br>
				<h1 align="center" class="title">Game Recommend</h1>
				<h6 style="color: gray" align="center">게임 추천 기준은 선택한 game play
					style 입니다.</h6>
				<table style="align-content: center;" class="table">
					<tr height="10" align="center">
						<td colspan="7">추천 게임 목록</td>
					</tr>
					<c:choose>
						<c:when test="${recommendlist == null}">
							<tr height="10">
								<td colspan="3">
									<p align="center">
										<strong><span style="font-size: 9pt;">추천할 게임이
												없습니다...</span></strong>
									</p>
								</td>
							</tr>
						</c:when>
					</c:choose>
					<c:forEach var="game" items="${recommendlist}" varStatus="status">
						<tbody>
							<tr align="left">
								<td align="center" style="vertical-align: middle;">
									${status.count}</td>
								<td align="center" style="vertical-align: middle;"><a
									href="${contextPath}/info/gameview.do?game_code=${game.game_code}">${game.game_name}</a>
								</td>
								<td align="center" style="vertical-align: middle;">장르 :
									${game.genre}<br> 플랫폼 : ${game.small_category}<br>
									배급사 : ${game.share_company}<br>
								</td>
								<td align="center" style="vertical-align: middle;">
									<div class="container">
										<a
											href="${contextPath}/info/gamesearch.do?searchValue=${game.hash_tag}&small_category=all">#${game.hash_tag}</a><br>
										<a
											href="${contextPath}/info/gamesearch.do?searchValue=${game.hash_tag2}&small_category=all">#${game.hash_tag2}</a><br>
										<a
											href="${contextPath}/info/gamesearch.do?searchValue=${game.hash_tag3}&small_category=all">#${game.hash_tag3}</a>
									</div>
								</td>
								<c:forEach var="logo" items="${logolist}">
									<c:if test="${logo.game_code == game.game_code}">
										<td><img
											src="${contextPath}/info/download.do?imagefilename=${logo.imagefilename}&game_code=${game.game_code}"
											style="width: 100px; height: 100px;" /></td>
									</c:if>
								</c:forEach>
							</tr>
						</tbody>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
</body>
</html>