<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<%
	request.setCharacterEncoding("UTF-8");
%>  
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>담벼락 새글쓰기창</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		
	</script>
<script type="text/javascript">
	
	function backToList(obj, addWallID) {
		obj.action = "${contextPath}/board/myWall.do?id_2=" + addWallID;
		obj.submit();
	}	
	
	function addWallArticle() {
		var form = document.articleForm;
		var title = document.getElementById("title").value;
		var content = document.getElementById("content").value;
		if(title == null || title.length =="") {
			alert("제목을 입력해주세요");
		} else if(content == null || content.length == "" ) {
			alert("내용을 입력해주세요");
		} else {
			form.method='get',
			form.action='${contextPath}/board/addWallArticle.do',
			form.submit();
		}
	}
</script>
<title>새글 쓰기창</title>
</head>
<jsp:include page="../bootstrap/timelineheader.jsp"></jsp:include>
<body>
<div class="col-md-10">
    <div class="jumbotron" style="background-color: white;">
    <div style="background-color: white;">	
	<form name="articleForm">
		
		<table class="table table-hover">
			<tr>
				<td align="center">글제목: </td>
				<td align="left"><input class='form-control' type="text" style="width:90%" maxlength="500" id="title" name="title" placeholder="제목을 입력해주세요."/></td>
			</tr>			
			<tr>
				<td style="vertical-align: middle;" align="center">글내용: </td>
				<td align="center"><textarea class='form-control' id="content" name="content" rows="13" cols="30" placeholder="나만의 일기장!!"></textarea></td>
			</tr>			
			<tr>
				<td align="right"></td>
				<td align="right">
					<input type="button" class="btn btn-primary" value="글쓰기" onClick="addWallArticle()"/>
					<input type="button" class="btn btn-default" value="목록보기" onClick = "backToList(this.form,'${addWallID}')"/>
				</td>
			</tr>			
		</table>
	</form>
	</div>
	</div>
    </div>
</body>
</html>