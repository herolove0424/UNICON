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
<title>공지 수정</title>
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->
	
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="//code.jquery.com/jquery-3.2.1.min.js"></script> 
<!-- 	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>  -->
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
				  $("#summernote").summernote('code', '${noticeModDetail.content}');
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
			
			function registerModNotice() {
				var form=document.noticeModF;
				form.encoding="multipart/form-data";
		        form.method="post";
				form.action="${contextPath }/management/modNotice.ddun";
				form.submit();
			}
			
			function cancleModNotice(boardno,searchType,currentPageNo,recordsPerPage,searchKeyword) {
				location.href="noticeView.ddun?boardno="+boardno+"&searchType="
   				+searchType+"&currentPageNo="+currentPageNo+"&recordsPerPage="+recordsPerPage+"&searchKeyword="+searchKeyword;
			}
			
	</script>

</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content" align="center">
	<h2 align="left"><strong>NOTICE</strong></h2>
	<form name="noticeModF" enctype="multipart/form-data">
<!-- 	<form name="noticeModF" method="post" action="액션을 수정해주세요" enctype="multipart/form-data"> -->
	  <table class="table">
			<tr>
				<td>
				<select name="exposal" class="form-control" style="height: 1.2cm; font-size: large;">
					<option style="font-size: large;" value="1" ${param.exposal eq "1" ? "selected" :""}>사용
					<option style="font-size: large;" value="0" ${param.exposal eq "0" ? "selected" :""}>숨김
				</select>
				</td>
			</tr>
			<tr>
				<td>
				<input type="text" name="title" class="form-control" style="font-size: large;" value="${noticeModDetail.title }"/>
				</td>
			</tr>			
			<tr>
				<td><textarea id="summernote" name="content" class="form-control" style="font-size: large;"></textarea></td>
			</tr>			
			<tr>
				<td>
					<input type="button" class="btn btn-primary btn-fill" value="등록" style="font-size: medium;" onclick="registerModNotice()"/>
					<input type="button" class="btn btn-default btn-fill" value="돌아가기" style="font-size: medium;"
						onclick="cancleModNotice('${noticeModDetail.boardno }',
						'${for_Back_List_Function[2] }','${for_Back_List_Function[0]}','${for_Back_List_Function[1]}',
						'${for_Back_List_Function[3]}')">
					<!-- <input type="button" value="목록보기" onClick = "backToList(this.form)"/> -->
				</td>
			</tr>			
		</table>
		<input type="hidden" name="boardno" value="${noticeModDetail.boardno }">
		<input type="hidden" name="searchType" value="${for_Back_List_Function[2] }">
		<input type="hidden" name="currentPageNo" value="${for_Back_List_Function[0]}">
		<input type="hidden" name="recordsPerPage" value="${for_Back_List_Function[1]}">
		<input type="hidden" name="searchKeyword" value="${for_Back_List_Function[3]}">
	</form>
	
	</div>
		
	</div>
	</div>
</body>
 <%-- <script src="//code.jquery.com/jquery-3.2.1.min.js"></script> 
 <script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
 <script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
 <script src="${contextPath}/resources/js/bootstrap-switch.js"></script>
<!--  Chartist Plugin  -->
 <script src="${contextPath}/resources/js/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${contextPath}/resources/js/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
 <script
	src="${contextPath}/resources/js/light-bootstrap-dashboard.js?v=2.0.0 "
	type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
 <script src="${contextPath}/resources/js/demo.js"></script>  --%>
</html>