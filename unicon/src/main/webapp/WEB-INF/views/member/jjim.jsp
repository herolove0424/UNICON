<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#tag {
	font-size: 15px;
}

</style>

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
<title>도찜개찜</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
	<div class="main main-raised">
		<div class="section section-basic">
			<div class="container">
				<div class="row">
					<div class="card card-login">
							<h1 class="sans" align="center">찜목록</h1>
							<div class="container" align="center">
								<table class="table" style="align-content: center;">
									<thead>
										<tr align="center">
											<td>일련 번호</td>
											<td>게임 이름</td>
											<td>소분류</td>
											<td></td>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${jjimlist == null}">
												<tr height="10">
													<td colspan="5">
														<p align="center">
															<strong> <span style="font-size: 9pt;">등록된
																	찜목록이 없습니다.</span></strong>
														</p>
													</td>
												</tr>
											</c:when>
										</c:choose>
									</tbody>
									<c:forEach var="jjim" items="${jjimlist}" varStatus="status">
										<tbody>
											<tr align="left">
												<td align="center" style="vertical-align: middle;">
													${jjim.game_code}</td>
												<td align="center" style="vertical-align: middle;"><a
													href="${contextPath}/info/gameview.do?game_code=${jjim.game_code}">${jjim.game_name}</a>
												</td>
												<td>${jjim.small_category}</td>
										</tbody>
									</c:forEach>
								</table>
								<div class="form-group" align="center">
									<input type="button"
										onclick="location.href='${contextPath}/main.do'"
										class="btn btn-primary" value="메인 페이지로 이동">
									<input type="button" class="btn btn-primary"
										onclick="location.href='${contextPath}/member/mypage.do'"
										value="마이페이지로">
									<input type="button" class="btn btn-primary"
										onclick="location.href='${contextPath}/member/mypagepwForm.do'"
										value="취소">

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	<jsp:include page="../bootstrap/footer.jsp" />
</body>
</html>