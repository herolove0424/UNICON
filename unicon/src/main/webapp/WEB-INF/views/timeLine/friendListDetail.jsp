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
<title>My Friend Detail</title>
<title>TimeLine Friend List</title>
<style>
	.btn_save {
		display: none;
	}
	
	 body {padding-top: 60px;}
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
//친구 삭제
function fn_friendDelete(id_1, id_2) {
	if (confirm("정말 삭제하시겠습니까??") == true){    //확인
		$.ajax({
			url : "${contextPath}/timeLine/friendDelete.do",
			type : 'post',
			data : {"id_1" : id_1, "id_2" : id_2}
		});
		alert("삭제되었습니다.");
		location.reload();
	}else{   
	    return;
	}
}
</script>

</head>
<jsp:include page="../bootstrap/timelineheader.jsp"></jsp:include>
<body>
<div class="col-md-10">
    <div class="jumbotron" style="background-color: white;">
    <div style="background-color: white;">
    	<label><h3>내 친구 목록</h3></label>
    	<hr>
    	<table class="table table-condensed">
  					<tr class="danger" align="center">
  						<td colspan="2"><strong>닉네임</strong></td>
  						<td><strong>친구 삭제</strong></td>
		     		</tr>
  					<c:choose>
						<c:when test="${empty friendList}">
							<tr>
								<td colspan="3">
								<p align="center">
									<strong><span style="font-size: 9pt;">친구가 없습니다.</span></strong>
								</p>
								</td>
							</tr>
						</c:when>
					</c:choose>
  						<c:forEach var="friend" items="${friendList}">
							<tr align="center">
								<%-- <td><img src="${contextPath}/resources/memberimage/${friends.id }/${friends.imageFileName}" alt="Raised Image"  width="220" height="120" id="preview"
								class="img-raised rounded img-fluid"></td> --%>
								 <c:if test="${empty friend.imageFileName || friend.imageFileName == 'null' }">
								<td><img src="${contextPath}/resources/img/man.png"  width="100" height="60" id="preview"
								class="img-raised rounded img-fluid"></td>
								</c:if>
								<c:if test="${not empty friend.imageFileName || friend.imageFileName != null }">
								<td><img src="${contextPath}/resources/memberimage/${friends.id }/${friends.imageFileName}" width="110" height="60" id="preview"
								class="img-raised rounded img-fluid"></td>
								</c:if> 
								<td style="text-align:center; padding-top:35px;"><a style="font-weight: bold; color: black;" href="${contextPath}/board/myWall.do?id_2=${friend.id_2}">${friend.nickname}</a></td>					
								<td style="padding-top:25px;"><input type="button" class="btn btn-danger"  value="친구 삭제" onclick="fn_friendDelete('${member.id}','${friend.id_2}')"></td>
							</tr>
						</c:forEach>
  				</table>
    	
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