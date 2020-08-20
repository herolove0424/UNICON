<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인확인창</title>
<script type="text/javascript" charset="UTF-8"></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<!-- <script>

	//친구 삭제
	function fn_friendDelete(id_1, id_2) {
		if (confirm("정말 삭제하시겠습니까??") == true){    //확인
			$.ajax({
				url : "${contextPath}/friend/friendDelete.do",
				type : 'post',
				data : {"id_1" : id_1, "id_2" : id_2}
			});
			alert("삭제되었습니다.");
			location.reload();
		}else{   
		    return;
		}
	}
	
	//친구 요청 취소
	function fn_friendRequestDelete(id_1, id_2) {
		$.ajax({
			url : "${contextPath}/friend/friendRequestDelete.do",
			type : 'post',
			data : {"id_1" : id_1, "id_2" : id_2}
		});
		alert("취소되었습니다.");
		location.reload();
	}
	
	//친구 수락
	function fn_friendAccept(id_1, id_2) {
		$.ajax({
			url : "${contextPath}/friend/friendAccept.do",
			type : 'post',
			data : {"id_1" : id_1, "id_2" : id_2}
		});
		alert("친구 수락하셨습니다.");
		location.reload();
	}
	
	//친구 거절
	function fn_friendReject(id_1, id_2) {
		$.ajax({
			url : "${contextPath}/friend/friendReject.do",
			type : 'post',
			data : {"id_1" : id_1, "id_2" : id_2}
		});
		alert("거절하셨습니다.");
		location.reload();
	}
	
</script> -->
</head>
<body>
<%-- 	<a href="${contextPath}/member/main.do">뒤로 가기</a>
	<br>
	<div style="text-align:center">
	<h2>친구수 : ${count}명</h2>
	</div>
	<table border="1" align="center">
		<tr height="10" align="center" bgcolor="lightgreen">
			<td>닉네임</td>
			<td>삭제</td>
		</tr>
		<c:choose>
			<c:when test="${empty friendList}">
				<tr height="10">
					<td colspan="3">
						<p align="center">
							<strong><span style="font-size: 9pt;">등록된 친구가 없습니다.</span></strong>
						</p>
					</td>
				</tr>
			</c:when>
		</c:choose>
		<c:forEach var="friend" items="${friendList}">
			<tr>
				<td>${friend.nickname}</td>					
				<td><input type="button" value="친구 삭제 " onclick="fn_friendDelete('${member.id}','${friend.id_2}')"></td>
			</tr>
		</c:forEach>
	</table>
	<div style="text-align:center">
	<h2>친구 대기</h2>
	</div>
	
	<br>
	
	<table border="1" align="center">
		<tr height="10" align="center" bgcolor="lightgreen">
			<td>닉네임</td>
			<td>상태</td>
			<td>button</td>
		</tr>
			<c:if test="${empty friendRequestList}">
				<c:if test="${empty friendAcceptList}">
					<tr height="10">
						<td colspan="3">
							<p align="center">
								<strong><span style="font-size: 9pt;">등록된 친구가 없습니다.</span></strong>
							</p>
						</td>
					</tr>
				</c:if>
			</c:if>
		<c:forEach var="friendR" items="${friendRequestList}">
			<tr>
				<td>${friendR.nickname}</td>	
				<td>상대방이 수락 대기중입니다.</td>				
				<td><input type="button" value="요청 취소" onclick="fn_friendRequestDelete('${member.id}','${friendR.id_2}')"></td>
			</tr>
		</c:forEach>
		<c:forEach var="friendA" items="${friendAcceptList}">
			<tr>
				<td>${friendA.nickname}</td>
				<td>상대방이 친구 요청하였습니다.</td>					
				<td><input type="button" value="수락 " onclick="fn_friendAccept('${friendA.id_1}','${member.id}')">
				<input type="button" value="거절 " onclick="fn_friendReject('${friendA.id_1}','${member.id}')"></td>
			</tr>
		</c:forEach>
	</table>
	
	
	 --%>
</body>
</html>