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
 <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">
  
  <!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
   rel="stylesheet" />

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
   href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">

  <!-- Custom fonts for this template -->
  <link href="${contextPath}/resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="${contextPath}/resources/css/sb-admin-2.min.css" rel="stylesheet">

  <!-- Custom styles for this page -->
  <link href="${contextPath}/resources/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
  
  <!-- Bootstrap core JavaScript-->
  <script src="${contextPath}/resources/vendor/jquery/jquery.min.js"></script>
  <script src="${contextPath}/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	
	<!-- Core plugin JavaScript-->
  <script src="${contextPath}/resources/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="${contextPath}/resources/js/sb-admin-2.min.js"></script>

  <!-- Page level plugins -->
  <%-- <script src="${contextPath}/resources/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${contextPath}/resources/vendor/datatables/dataTables.bootstrap4.min.js"></script> --%>

  <!-- Page level custom scripts -->
  <%-- <script src="${contextPath}/resources/js/demo/datatables-demo.js"></script> --%>
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
   	<script  src="http://code.jquery.com/jquery-latest.min.js"></script> 
   	<script type="text/javascript" >
   	function backToList(status) {
   		if(status==3){
   			location.href='${contextPath}/board/Pc_Board_AllList.do';
   		}else if(status==1){
   			location.href='${contextPath}/board/Free_Board_AllList.do';
   		}else if(status==2){
   			location.href='${contextPath}/board/Mobile_Board_AllList.do';
   		}else if(status==4){
   			location.href='${contextPath}/board/Console_Board_AllList.do';
   		}
	}
		
   	</script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
	<div class="main main-raised">
   <div class="section section-basic">
      <div class="container">
         <div class="container" align="center">
	<h2 align="left"><strong>NOTICE</strong></h2>
	<hr>
	<br>
	<form name="noticeDetail" method="post"  action="${contextPath}"  enctype="multipart/form-data">
	
	<table>
		<tr class="notice_title">
			<td style="width: 70%; font-size: 16pt;"><strong>${noticeView.title}</strong></td>
			<td style="width: 15%;"></td>
			<td style="width: 15%; font-size: 13pt;">번호: ${noticeView.boardno }</td>
		</tr>
		<tr class="notice_sub_title">
			<td style="font-size: 16pt; color: #2678ff;">
			<img alt="" src="${contextPath}/resources/img/managerLogo.png" class="img-circle">&nbsp;<strong>관리자</strong>
			</td>
			<td style="font-size: 13pt;"><fmt:formatDate value="${noticeView.writedate }" pattern="YYYY/MM/d HH:mm"/>&nbsp;</td>
			<td style="font-size: 13pt;">조회 : ${noticeView.viewcount}</td>
		</tr>
		<tr class="notice_view_box">
			<td colspan="3" class="notice_view_box">${noticeView.content }</td>
		</tr>
	
	</table>
	<br>
	<input type="button" value="목록" class="btn btn-primary btn-round" onclick="backToList('${status}')">
		</form>
	</div>
	</div>
	</div>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp"/>
</html>