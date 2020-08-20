<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function pc_board_select() {
		var pc = document.getElementById("pc");
		var mobile = document.getElementById("mobile");
		var console = document.getElementById("console");
		var free = document.getElementById("free");
		if (mobile.style.display == "block" || console.style.display == "block"
				|| free.style.display == "block") {
			mobile.style.display = "none";
			console.style.display = "none";
			free.style.display = "none";
			pc.style.display = "block";
		} else if (pc.style.display == "none") {
			pc.style.display = "block";
		} else if (pc.style.display == "block") {
			pc.style.display = "none";
		}
	}
</script>
<!-- 게시판 댓글 출력 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function mobile_board_select() {
		var pc = document.getElementById("pc");
		var mobile = document.getElementById("mobile");
		var console = document.getElementById("console");
		var free = document.getElementById("free");
		if (pc.style.display == "block" || console.style.display == "block"
				|| free.style.display == "block") {
			pc.style.display = "none";
			console.style.display = "none";
			free.style.display = "none";
			mobile.style.display = "block";
		} else if (mobile.style.display == "none") {
			mobile.style.display = "block";
		} else if (mobile.style.display == "block") {
			mobile.style.display = "none";
		}
	}
</script>
<!-- 게시판 댓글 출력 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function console_board_select() {
		var pc = document.getElementById("pc");
		var mobile = document.getElementById("mobile");
		var console = document.getElementById("console");
		var free = document.getElementById("free");
		if (pc.style.display == "block" || mobile.style.display == "block"
				|| free.style.display == "block") {
			pc.style.display = "none";
			mobile.style.display = "none";
			free.style.display = "none";
			console.style.display = "block";
		} else if (console.style.display == "none") {
			console.style.display = "block";
		} else if (console.style.display == "block") {
			console.style.display = "none";
		}
	}
</script>
<!-- 게시판 댓글 출력 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function free_board_select() {
		var pc = document.getElementById("pc");
		var mobile = document.getElementById("mobile");
		var console = document.getElementById("console");
		var free = document.getElementById("free");
		if (pc.style.display == "block" || mobile.style.display == "block"
				|| console.style.display == "block") {
			pc.style.display = "none";
			console.style.display = "none";
			mobile.style.display = "none";
			free.style.display = "block";
		} else if (free.style.display == "none") {
			free.style.display = "block";
		} else if (free.style.display == "block") {
			free.style.display = "none";
		}
	}
</script>
<style type="text/css">
.sans {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
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

<title>게시판 관리</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" charset="utf-8"></script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
	<div class="main main-raised">
		<div class="section section-basic" style="padding-bottom:20px">
			<div class="container">
				<h1 class="sans" align="center">게시글 관리 페이지</h1>
				<div class="container" align="center">
					<nav class="navbar navbar-expand-lg bg-white" style="width: 50%">
						<div class="container" align="center">
							<input type="button" id="pc_board" class="btn btn-primary"
								onclick="pc_board_select()" value="PC 게시글"> <input
								type="button" id="mobile_board" class="btn btn-primary"
								onclick="mobile_board_select()" value="모바일 게시글"> <input
								type="button" id="console_board" class="btn btn-primary"
								onclick="console_board_select()" value="콘솔 게시글"> <input
								type="button" id="free_board" class="btn btn-primary"
								onclick="free_board_select()" value="자유게시글">
						</div>
					</nav>
				</div>
				<div id="pc" style="display: none;">
					<div class="container" align="center">
						<h2 class="sans">pc게시글 관리</h2>
						<table class="table">
							<thead>
								<tr align="center">
									<td>제목</td>
									<td>등록날짜</td>
									<td>조회수</td>
								</tr>
							</thead>
							<c:choose>
								<c:when test="${pcboard == null}">
									<tr align="center">
										<td colspan="4">
											<p align="center">
												<strong><span style="font-size: 9pt;">등록된
														리뷰가 없습니다.</span></strong>
											</p>
										</td>
									</tr>
								</c:when>
							</c:choose>
							<c:forEach var="p" items="${pcboard}" varStatus="status">
								<tr align="center">
									<td><a href="${contextPath}/board/viewArticle2.do?boardNO=${p.boardNO}">${p.title}</a></td>
									<td>${p.writeDate}</td>
									<td>${p.viewCount}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div id="mobile" style="display: none;">
					<div class="container" align="center">
						<h2 class="sans">모바일게시글 관리</h2>
						<table class="table">
							<thead>
								<tr align="center">
									<td>제목</td>
									<td>등록날짜</td>
									<td>조회수</td>
								</tr>

							</thead>
							<c:choose>
								<c:when test="${mobileboard == null}">
									<tr align="center">
										<td colspan="4">
											<p align="center">
												<strong><span style="font-size: 9pt;">등록된
														리뷰가 없습니다.</span></strong>
											</p>
										</td>
									</tr>
								</c:when>
							</c:choose>
							<c:forEach var="m" items="${mobileboard}" varStatus="status">
								<tr align="center">
									<td><a href="${contextPath}/board/MobileViewArticle.do?boardNO=${m.boardNO}">${m.title}</a></td>
									<td>${m.writeDate}</td>
									<td>${m.viewCount}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div id="console" style="display: none;">
					<div class="container" align="center">
						<h2 class="sans">콘솔게시글 관리</h2>
						<table class="table">
							<thead>
								<tr align="center">
									<td>플랫폼</td>
									<td>제목</td>
									<td>등록날짜</td>
									<td>조회수</td>
								</tr>

							</thead>
							<c:choose>
								<c:when test="${consoleboard == null}">
									<tr align="center">
										<td colspan="4">
											<p align="center">
												<strong><span style="font-size: 9pt;">등록된
														리뷰가 없습니다.</span></strong>
											</p>
										</td>
									</tr>
								</c:when>
							</c:choose>
							<c:forEach var="c" items="${consoleboard}" varStatus="status">
								<tr align="center">
									<td>${c.platform}</td>
									<td><a
										href="${contextPath}/board/ConsoleViewArticle.do?boardNO=${c.boardNO}">${c.title}</a></td>
									<td>${c.writeDate}</td>
									<td>${c.viewCount}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div id="free" style="display: none;">
					<div class="container" align="center">
						<h2 class="sans">자유게시글 관리</h2>
						<table class="table" style="align-content: center;">
							<thead>
								<tr align="center">
									<td>제목</td>
									<td>등록날짜</td>
									<td>조회수</td>
								</tr>

							</thead>
							<c:choose>
								<c:when test="${freeboard == null}">
									<tr align="center">
										<td colspan="4">
											<p align="center">
												<strong><span style="font-size: 9pt;">등록된
														리뷰가 없습니다.</span></strong>
											</p>
										</td>
									</tr>
								</c:when>
							</c:choose>
							<c:forEach var="f" items="${freeboard}" varStatus="status">
								<tr align="center">
									<td><a href="${contextPath}/board/FreeViewArticle.do?boardNO=${f.boardNO}">${f.title}</a></td>
									<td>${f.writeDate}</td>
									<td>${f.viewCount}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				<div class="footer text-center">
					<input type="button" class="btn btn-primary"
						onclick="location.href='${contextPath}/main.do'" value="메인페이지로 이동">
					<input type="button" class="btn btn-primary"
						onclick="location.href='${contextPath}/member/mypage.do'"
						value="마이페이지로 이동">
				</div>
			</div>
		</div>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>