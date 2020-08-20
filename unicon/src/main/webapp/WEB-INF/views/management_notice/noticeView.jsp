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
<!-- CSS Files -->

 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.0/minty/bootstrap.min.css">
<link href="${contextPath}/resources/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" /> 
 <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"> 
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="${contextPath}/resources/css/demo.css" rel="stylesheet" />
<title>공지사항</title>

	<style type="text/css">
	.notice_title {
	    padding: 16px 20px;
    	border-top: 2px solid #000;
    	border-bottom: 1px solid #e5e5e5;
	}
	
	
	.notice_sub_title {
    margin-bottom: 1px;
    padding: 8px 20px;
    height: 50px;
    border-bottom: 1px solid #c8c8c8;
	}
	
	.notice_view_box {
    padding: 48px 20px;
    border-top: 1px solid #c8c8c8;
    border-bottom: 2px solid #666;
    font-size: 15px;
    line-height: 1.8em;
    word-break: break-all;
    color: #393939;
    color: #222;
    /* font-size: 12px; */
    line-height: 2;
	}
	
	</style>
 	<!-- <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	
	include summernote css/js
	<link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css" rel="stylesheet">
	<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script> -->
   	<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
   	<script type="text/javascript" >
   	function backToList(url,searchType,currentPageNo,recordsPerPage,searchKeyword) {
		var form=document.createElement("form");
		form.setAttribute("method","get");
		form.setAttribute("action",url);
		
		var searchTypeInput=document.createElement("input");
		searchTypeInput.setAttribute("type","hidden");
		searchTypeInput.setAttribute("name","searchType");
		searchTypeInput.setAttribute("value",searchType);
		
		var currentPageNoInput=document.createElement("input");
		currentPageNoInput.setAttribute("type","hidden");
		currentPageNoInput.setAttribute("name","currentPageNo");
		currentPageNoInput.setAttribute("value",currentPageNo);
		
		var recordsPerPageInput=document.createElement("input");
		recordsPerPageInput.setAttribute("type","hidden");
		recordsPerPageInput.setAttribute("name","recordsPerPage");
		recordsPerPageInput.setAttribute("value",recordsPerPage);
		
		var searchKeywordInput=document.createElement("input");
		searchKeywordInput.setAttribute("type","hidden");
		searchKeywordInput.setAttribute("name","searchKeyword");
		searchKeywordInput.setAttribute("value",searchKeyword);
		
		form.appendChild(searchTypeInput);
		form.appendChild(currentPageNoInput);
		form.appendChild(recordsPerPageInput);
		form.appendChild(searchKeywordInput);
		document.body.appendChild(form);
		
		form.submit();
		
	}
   	
   	function goModifyNotice(boardno,searchType,currentPageNo,recordsPerPage,searchKeyword) {
   		location.href="modNoticeF.ddun?boardno="+boardno+"&searchType="
   				+searchType+"&currentPageNo="+currentPageNo+"&recordsPerPage="+recordsPerPage+"&searchKeyword="+searchKeyword;
	}
   	
   	function goDeleteNotice(boardno) {
   		if(confirm("공지사항을 삭제하시겠습니까?")){
   			var form=document.createElement("form");
   			form.setAttribute("method","post");
   			form.setAttribute("action","${contextPath}/management/delNotice.ddun");
   			
   			var boardnoInput=document.createElement("input");
   			boardnoInput.setAttribute("type","hidden");
   			boardnoInput.setAttribute("name","boardno");
   			boardnoInput.setAttribute("value",boardno);
   			
   			form.appendChild(boardnoInput);
   			document.body.appendChild(form);
   			
   			form.submit();
   		}
   		
   		
		
		
	}
   	</script>
</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content">
		<h2 align="left"><strong>NOTICE</strong></h2>
		<hr>
		<br>
		<form name="noticeDetail" method="post" action="${contextPath}"
			enctype="multipart/form-data">

			<table>
				<tr class="notice_title">
					<td style="width: 70%; font-size: 16pt;">${noticeViewDetail.title}</td>
					<td style="width: 15%;"></td>
					<td style="width: 15%; font-size: 13pt;">번호:
						${noticeViewDetail.boardno } <c:if
							test="${noticeViewDetail.exposal==0 }">
			(미사용)
			</c:if> <c:if test="${noticeViewDetail.exposal==1 }">
			(사용)
			</c:if>
					</td>
				</tr>
				<tr class="notice_sub_title">
					<td style="font-size: 16pt; color: #2678ff;">${noticeViewDetail.id}</td>
					<td style="font-size: 13pt;"><fmt:formatDate
							value="${noticeViewDetail.writedate }" pattern="YYYY/MM/d HH:mm" />&nbsp;</td>
					<td style="font-size: 13pt;">조회 :
						${noticeViewDetail.viewcount}</td>
				</tr>
				<tr class="notice_view_box">
					<td colspan="3" class="notice_view_box">${noticeViewDetail.content }</td>
				</tr>


			</table>
			<br>
			<input type="hidden" name="boardno" value="${noticeViewDetail.boardno}"> 
			<input type="button" value="수정하기"  class="btn btn-primary btn-fill btn-sm" onclick="goModifyNotice('${noticeViewDetail.boardno}','${for_Back_List_Function[2] }','${for_Back_List_Function[0]}','${for_Back_List_Function[1]}','${for_Back_List_Function[3]}')">
			<input type="button" value="삭제하기"  class="btn btn-primary btn-fill btn-sm" onclick="goDeleteNotice('${noticeViewDetail.boardno}')"> 
			<input type="button" value="목록"  class="btn btn-default btn-fill btn-sm" onclick="backToList('${contextPath }/management/notice.ddun','${for_Back_List_Function[2] }','${for_Back_List_Function[0]}','${for_Back_List_Function[1]}','${for_Back_List_Function[3]}')">
		</form>
	</div>
	<br>
	<br>
		
	</div>
	</div>

</body>
<!--   Core JS Files   -->
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
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
<script src="${contextPath}/resources/js/demo.js"></script>
</html>