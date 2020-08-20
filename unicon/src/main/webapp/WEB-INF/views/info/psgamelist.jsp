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
<meta charset="UTF-8">
<title>PS 게임 목록창</title>
</head>
<body>
	<h1 align="center">PS 게임 목록</h1>
	<a style="text-align:center;" href="${contextPath}/info/gamerank.do"><h3>게임 순위</h3></a>
	<c:choose>
		<c:when test="${empty member.id}">
			<a style="text-align:center" href="${contextPath}/member/loginForm.do"><h4>로그인</h4></a>
		</c:when>
		<c:when test="${!empty member.id}">
			<h4 align="center">안녕하세요! ${member.nickname}님!</h4>
			<a style="text-align:center" href="${contextPath}/member/logout.do"><h4>로그아웃</h4></a>
		</c:when>
	</c:choose>
	<table border="0" align="center">
		<tr align="center">
			<form name="frmGameSearch" method="post" action="${contextPath}/info/gamesearch.do">
				<td>
					<input type="text" name="searchValue">
					<input type="hidden" name="genre" value="ps4">
					<input type="submit" value="검색"><br>
				</td>
			</form>
			<td>
				<select id="genre" onchange="window.open(value,'_self');">
					<option value="#">---플랫폼---</option>
					<option value="${contextPath}/info/gamelist.do">ALL</option>
					<option value="${contextPath}/info/pcgamelist.do">PC</option>
					<option value="${contextPath}/info/mobilegamelist.do">Mobile</option>
					<option value="${contextPath}/info/xboxgamelist.do">Xbox</option>
					<option value="${contextPath}/info/psgamelist.do" selected>PS</option>
					<option value="${contextPath}/info/nintendogamelist.do">Nintendo</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="ALL" onclick="location.href='${contextPath}/info/gamelist.do'">&nbsp;
				<input type="button" value="PC" onclick="location.href='${contextPath}/info/pcgamelist.do'">&nbsp;
				<input type="button" value="Mobile" onclick="location.href='${contextPath}/info/mobilegamelist.do'">&nbsp;
				<input type="button" value="Xbox" onclick="location.href='${contextPath}/info/xboxgamelist.do'">&nbsp;
				<input type="button" value="PS" onclick="location.href='${contextPath}/info/psgamelist.do'">&nbsp;
				<input type="button" value="Nintendo" onclick="location.href='${contextPath}/info/nintendogamelist.do'">
			</td>
		</tr>
	</table>
	<table border="1" align="center">
		<tr height="10" align="center" bgcolor="lightgreen">
			<td colspan="3">PS 게임 목록</td>
		</tr>
		<c:choose>
			<c:when test="${psgameList == null}">
				<tr height="10">
					<td colspan="3">
						<p align="center">
							<strong><span style="font-size: 9pt;">등록된 글이 없습니다.</span></strong>
						</p>
					</td>
				</tr>
			</c:when>
		</c:choose>
		<c:forEach var="psgame" items="${psgameList}">
			<tr align="left">
				<td><a href="${contextPath}/info/gameview.do?game_code=${psgame.game_code}">${psgame.game_name}</a></td>
				<td>
					장르 : ${psgame.genre}<br>
					플랫폼 : ${psgame.small_category}<br>
					배급사 : ${psgame.share_company}<br>
				</td>
				<td>
					<img src="${contextPath}/resources/image/logo/${psgame.game_code}.jpg" style="width:300px;"/>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>