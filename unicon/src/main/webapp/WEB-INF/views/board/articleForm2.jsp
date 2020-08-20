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
	<!-- include libraries(jQuery, bootstrap) -->
	
	<title>글쓰기창</title>
<!-- Bootstrap core CSS -->
<%-- <link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
	rel="stylesheet" /> --%>
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> -->
	<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
		<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	
	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet"> 
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>
	
	<script type="text/javascript">
		function backToList(obj) {
			obj.action = "${contextPath}/board/mainBoard.do";
			obj.submit();
		}
	</script>
	<!-- 썸머노트 스크립트 -->
	<script type="text/javascript">
			$(document).ready(function() {
				  $('#summernote').summernote({
			 	    	placeholder: 'PC게시판에 등록할 내용을 작성해주세요',
				        minHeight: 620,
				        maxHeight: null,
				        focus: true, 
				        lang : 'ko-KR',
				        callbacks: {
				        	uploadSummernoteImageFile : uploadSummernoteImageFile
				        }
				  });
				});
			
			function uploadSummernoteImageFile(files) {
				
				var data = new FormData();
				data.append("");
				
				for (var i = 0; i < files.length; i++) {
					data.append("files[" + i + "]", files[i]);
				}
				
				$.ajax({
					data: data,
					type: "POST",
					url: "/uploadSummernoteImageFile",
					cache: false,
					contentType: false,
					processData: false,
					success: function (d) {
						if (!d.result) {
							
						} else {
							for(var i = 0; i < d.data.length; i++) {
								$('#summernote').summernote('insertImage', d.data[i]);
							}
						}
					}
					
				});
				return false;
			}
			
			function pcAddArticle() {
				var title = document.getElementById("title").value;
				if(title == null || title.length =="") {
					alert("제목을 입력해주세요");
				} else {
					var form = document.articleForm;
					form.method='post',
					form.action='${contextPath}/board/addArticle.do',
					form.enctype="multipart/form-data",
					form.submit();
					
				}
			}
	</script>
	<title>새글 쓰기창</title>
</head>
<jsp:include page="../bootstrap/boardTotal.jsp" flush="true" />
<body>
	<div class="main main-raised">
		<div class="section section-basic">
			<div class="container">
				<div class="container" align="center">
					<div class="form-group">
					<!-- <h1 style="text-align: center">새 글 쓰기</h1> -->
					<br>
					<form name="articleForm">

						<table class="table" style="margin: auto;">
							<tr align="center">
								
								<td><input type="text" size="67"
									maxlength="500" id="title" class="form-control"  name="title" placeholder="제목" /></td>
							</tr>
							<tr align="center">
								<td><textarea id="summernote" class="form-control"  name="content" style="font-size: large; height: 620pt;" ></textarea></td>
							</tr>
							<tr>
								<td align="right">
								<input type="button" class="btn btn-primary btn-sm" style="font-size: medium;" value="글쓰기" onClick="pcAddArticle()" /> 
								<input type="button" class="btn btn-default btn-sm" style="font-size: medium;" value="목록보기" onClick="backToList(this.form)" /></td>
							</tr>
						</table>
					</form>
				</div>
				</div>
			</div>
		</div>
	</div>
	 <%-- <jsp:include page="../bootstrap/footer.jsp" /> --%>
</body>
</html>