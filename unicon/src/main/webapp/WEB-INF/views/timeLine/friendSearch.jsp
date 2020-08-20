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
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function fn_friend_search() {
		var nickname_search=document.friend_search;
		var nickname_search_check=nickname_search.friend_nickname.value;
	
		if(nickname_search_check==null||nickname_search_check==0){
			alert("검색어를 입력해주세요");
		}else{
			nickname_search.method="post";
			nickname_search.action="${contextPath}/timeLine/nicknameSearch.do";
			nickname_search.submit();
		}
	}
	
	
	//친구 수락
	//도경 수정 0812-----------------------------------
	function fn_friendRequest(id_1, id_2) {
		$.ajax({
			url : "${contextPath}/timeLine/friendRequest.do",
			type : 'get',
			/* type : 'post', */
			data : {"id_1" : id_1, "id_2" : id_2},
			success:function(data){
				 if(data=="0"){
					 alert("신청되었습니다.");
				}else if(data=="1"){
					 alert("이미 친구 상태입니다.");
				}else if(data=="2"){
					 alert("이미 친구 신청하셨습니다.");
				}else{
					alert("친구로부터 도착한 친구 신청을 확인해주세요.");
					location.href='${contextPath}/board/friendRequest.do';
				}
		        
			},
			error:function(data){
				alter("오류가 발생했습니다. 다시 시도해주세요");
				location.href = location.href;
	        }
			
		});
		
	}
	
</script>
</head>
<jsp:include page="../bootstrap/timelineheader.jsp"></jsp:include>
<body>
<div class="col-md-10" style="background-color: white;">
    <div class="jumbotron" style="background-color: white;">
    <div style="background-color: white;">
	<%-- <h1>친구 닉네임 검색</h1>
	<form name="friend_search" method="post">		
		<input type="text" name="friend_nickname" size="20" value="${searchValue}">
		<input type="button" value="검색" onclick="fn_friend_search()">
		<input type="reset" value="초기화">
	</form> --%>
	
	
	<table class="table table-bordered">
		<tr class="success" style="text-align:center;">
			<td><strong>친구 닉네임</strong></td>
			<td><strong>친구 신청하기</strong></td>
		</tr>
		<c:choose>
			<c:when test="${value==null}">
				<tr height="10">
					<td colspan="2">
						<p align="center">
							<strong><span style="font-size: 9pt; color: #FF0046;">검색된 닉네임이 없습니다.</span></strong>
						</p>
					</td>
				</tr>
			</c:when>
			<c:when test="${value!=null }">
				<c:forEach var="friends" items="${value}" varStatus="num">
					<c:if test="${friends.id!=sessionScope.member.id}">
					<tr style="text-align:center;">
						<td>
							<%-- <img src="${contextPath}/resources/memberimage/${friends.id}/${friends.imageFileName}" alt="Raised Image"  width="220" height="120" id="preview"
								class="img-raised rounded img-fluid"> --%>
						<span style="color: #0030CC; font-size: 13pt;"><strong>${friends.nickname}</strong></span>
						</td>
						<td><input type="button" value="친구 신청 " class="btn btn-warning" onclick="fn_friendRequest('${sessionScope.member.id}', '${friends.id}')"></td>
					</tr>
					</c:if>
				</c:forEach>
				<%-- <tr>
					<td>${value.nickname}</td>					
					<td><input type="button" value="친구 신청 " onclick="fn_friendRequest('${member.id}', '${value.id}')"></td>
				</tr> --%>
			</c:when>
		</c:choose>
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