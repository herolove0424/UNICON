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
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap" rel="stylesheet">
<style type="text/css">
.sans {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
<title>쪽지 쓰기</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function checkNull() {
		var form = document.messageBox;
		var title = form.title.value;
		var content = form.content.value;
		var id = form.id.value;
		
		if (title == null || title.length == 0) {
			alert("제목을 입력해주세요.");
		}else if (content == null || content.length == 0) {
			alert("내용을 입력해주세요.");
		}else{
			$.ajax({
				url:'${contextPath}/message/messageSend.do',
				type:'post',
				data:{'id':id,'title':title,'content':content},
				success:function(data){
					 if(data=="success"){
						console.log("메세지 전송 완료");
						alert("메세지를 전송하였습니다.");
						$("#id").val("");
						$("#title").val("");
						$("#content").val("");
						window.close();
					}
				},
				error:function(data){
					if(data=="error"){
						console.log("메세지 전송 실패");
						alert("메세지 전송 실패");
						$("#id").val("");
						$("#title").val("");
						$("#content").val("");
						window.close();
					}
			        
		        }
			});
		}
        
	}
</script>
</head>
<body>
	<div class="container" align="right">
		<form name="messageBox" id="messageBox">
		<h3 class="sans" align="left">쪽지 작성</h3>
		<table class="table">
			<tr align="center">
				<td align="left" style="vertical-align:middle;">
					제목 : <input type="text" name="title" id="title" style="size:400px">
				</td>
				<td align="right" style="vertical-align:middle;">										
					받는 사람: ${id}<br>
					<input type="hidden" name="id" id="id" value="${id}">
				</td>
			</tr>
			<tr>
				<td colspan="2">	
					<input type="text" name="content" id="content" style="text-align:left; width:100%; height:300px;">
				</td>
			</tr>
		</table>
		<hr>
		</form>
		<input class="btn btn-default btn-round" type="button" value="보내기"
		onclick="checkNull()">
	</div>
</body>
</html>