<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	request.setCharacterEncoding("UTF-8");
	String session_id = (String) session.getAttribute("session_id");
	System.out.println("세션아이디:" + session_id);
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Bootstrap -->
<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<title>타임라인이다 이자식아</title>
<title>TimeLine Friend List</title>
<style>
	.btn_save {
		display: none;
	}
	
	 body {padding-top: 60px;}
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//친구 수락
function fn_friendAccept(id_1, id_2) {
	$.ajax({
		url : "${contextPath}/timeLine/friendAccept.do",
		type : 'post',
		data : {"id_1" : id_1, "id_2" : id_2}
	});
	alert("친구 수락하셨습니다.");
	location.reload();
}


//친구 거절
function fn_friendReject(id_1, id_2) {
	$.ajax({
		url : "${contextPath}/timeLine/friendReject.do",
		type : 'post',
		data : {"id_1" : id_1, "id_2" : id_2}
	});
	alert("거절하셨습니다.");
	location.reload();
}

function fn_friendRequestDelete(id_1, id_2) {
	$.ajax({
		url : "${contextPath}/timeLine/friendReject.do",
		type : 'post',
		data : {"id_1" : id_1, "id_2" : id_2}
	});
	alert("취소되었습니다.");
	location.reload();
}

</script>

</head>
<jsp:include page="../bootstrap/timelineheader.jsp"></jsp:include>
<body>
<div class="col-md-10">
    <div class="jumbotron" style="background-color: white;">
    <div style="background-color: white;">
    	<c:choose>
	    		<c:when test="${friendAcceptList!=null}">
    			<label><h3>받은 친구 신청</h3></label>
    				<table class="table">
    				<tr class="danger" align="center">
    					<td><strong>닉네임</strong></td>
    					<td><strong>수락/거절</strong></td>
    				</tr>
    				<c:forEach var="list" items="${friendAcceptList }" varStatus="num">
    					<tr  align="center">
    						<td>${list.nickname }</td>
    						<td>
								<input type="button" class="btn btn-default" value="수락 " onclick="fn_friendAccept('${list.id_1}','${member.id}')">
								<input type="button" class="btn btn-default" value="거절 " onclick="fn_friendReject('${list.id_1}','${member.id}')">
							</td>
    					</tr>
    				</c:forEach>
    			</table>
    		</c:when>
    		
    		<c:when test="${empty friendAcceptList }">
    		<table class="table">
    			<tr align="center">
    				<td colspan="2">접수된 친구 요청이 없습니다.</td>
    			</tr>
    		</table>
    		</c:when>
    		
    	</c:choose>
    	<br>
    	<hr>
    	<br>
    	<c:choose>
    		
    		<c:when test="${friendRequestList!=null }">
    			<label><h3>보낸 친구 신청</h3></label>
    				<table class="table">
    				<tr class="danger"  align="center">
    					<td><strong>닉네임</strong></td>
    					<td><strong>상태</strong></td>
    					<td><strong>요청 취소</strong></td>
    				</tr>
    				<c:forEach var="list" items="${friendRequestList }" varStatus="num">
    					<tr  align="center">
    						<td>${list.nickname }</td>
    						<td>
								<span style="color: #FF0033;">상대방이 수락 대기중입니다.</span>
							</td>
							<td>
								<input type="button" class="btn btn-default" value="요청 취소" onclick="fn_friendRequestDelete('${member.id}','${list.id_2}')">
							</td>
    					</tr>
    				</c:forEach>
    			</table>
    		</c:when>
    		
    		<c:when test="${empty friendRequestList }">
    			<table class="table">
    			<tr  align="center">
    				<td colspan="3">접수된 친구 요청이 없습니다.</td>
    			</tr>
    		</table>
    		</c:when>
    		
    		
    	</c:choose>
    	
    	
    </div>
  </div>
</div> 
 <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
    <!-- <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script> -->
</body>
</html>