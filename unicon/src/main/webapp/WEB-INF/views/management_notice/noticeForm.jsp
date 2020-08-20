<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
   request.setCharacterEncoding("UTF-8");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<link href="${contextPath}/resources/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
 <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">
<title>공지사항 작성</title>
	<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet"> -->
	<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
		<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	
	<!-- include summernote css/js-->
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet"> 
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

	<script type="text/javascript">
			$(document).ready(function() {
				  $('#summernote').summernote({
			 	    	placeholder: '공지사항',
				        minHeight: null,
				        maxHeight: null,
				        focus: true, 
				        lang : 'ko-KR',
				        callbacks: {
				        	uploadSummernoteImageFileOnNotice : uploadSummernoteImageFileOnNotice
				        }
				  });
				});
			
			function uploadSummernoteImageFileOnNotice(files) {
				
				var data = new FormData();
				data.append("");
				
				for (var i = 0; i < files.length; i++) {
					data.append("files[" + i + "]", files[i]);
				}
				
				$.ajax({
					data: data,
					type: "POST",
					url: "${contextPath}/management/uploadSummernoteImageFileOnNotice",
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
			
			function registerNotice() {
				var notice=document.noticeForm;
				var title=notice.title.value;
				var content=notice.content.value;
				
				if(title==null||title.length==0){
					alert("제목을 입력해주세요");
				}else if(content==null||content.length==0){
					alert("내용을 입력해주세요");
				}else{
					notice.encoding="multipart/form-data";
					notice.method="post";
					notice.action="${contextPath }/management/noticeAdd.ddun";
					notice.submit();
				}
			}
			
			function resetFunction() {
				var form = document.createElement("form");
		        form.setAttribute("charset", "UTF-8");
		        form.setAttribute("method", "get");  //Post 방식
		        form.setAttribute("action", "${contextPath}/management/notice.ddun"); //요청 보낼 주소
		        document.body.appendChild(form);

		        form.submit();
			}
			
	</script>

</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content" align="center">
	<h2 align="left"><strong>New NOTICE</strong></h2>	
	<form name="noticeForm" enctype="multipart/form-data">
<%-- 	<form name="noticeForm" method="post" action="${contextPath}/management/noticeAdd.ddun" enctype="multipart/form-data"> --%>
	<input type="hidden" size="20" name="id" value="${manager_Id }"/>
	  <table class="table">
			<tr>
				<td><select name="exposal" class="form-control">
					<option value="1">사용
					<option value="0">숨김
				</select></td>
				<td colspan="2"><input type="text" class="form-control" name="title"/></td>
			</tr>	
			<tr>
				<td colspan="2"><textarea id="summernote" name="content" class="form-control"></textarea></td>
			</tr>			
			<tr align="center">
				<td colspan="2">
					<input type="button" value="글쓰기" class="btn btn-primary btn-fill" onclick="registerNotice()"/>
					<input type="button" value="목록보기" class="btn btn-default btn-fill" onClick = "resetFunction()"/>
				</td>
			</tr>			
		</table>
			
	</form>
	</div>
		
	</div>
	</div>
</body>

</html>