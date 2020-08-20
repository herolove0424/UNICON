<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

<%
   request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>권한 생성</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
		$(function() {
			$("#submitWithClose").click(function() {
				$.ajax({
					url:'${contextPath}/management/confirmPassword.ddun',
					type:'post',
					data:$("#fn_Confirm").serialize(),
					success:function(data){
						 if(data=="success"){
							console.log("권한이 정상적으로 설정되었습니다.");
							alert("success");
							/* 	showHtml(data,1); */
						} 
						
				        
				        opener.parent.location='${contextPath}/management/authorMain.ddun';
				        opener.parent.location.reload();
				        closePopup();
				        //authorService.getAuthorList();
				        
					},
					error:function(data){
						if(data=="no-match"){
							console.log("비밀번호 불일치");
							alert("정보가 일치하지 않습니다.");
						}else{
							console.log("오류 발생");
							alert("오류가 발생했습니다.");
						}
			            
				        
				        opener.parent.location='${contextPath}/management/authorMain.ddun';
				        opener.parent.location.reload();
				        closePopup();
			        }
				});
			});
		});
	
	
</script>

<script type="text/javascript">
	function closePopup() {
		var popwidth='400';
		var popheight='300';
		var leftPos = '800';
		var topPos='300';
		var winName='권한 생성';
		var features = 'left='+ leftPos+', top='+ topPos;
	    features  += ',location=no, directories=no, menubar=no, scrollbars=auto';
	    features  += ',width='+ popwidth+ ',height='+ popheight;
	    
	    var reqUrl='${contextPath}/management/confirm_Form.ddun';
		
	    var new_popup= window.open(reqUrl,winName,features);
	    //opener.parent.location.reload();
	    new_popup.close(); 
	}

</script>


</head>
<body>
	<br>
	<br>
	<div style="text-align: center; top: 50%;">
	<form name="fn_Confirm" id="fn_Confirm" method="post" style="margin:auto; align-content: center; top: 50%;">
<%-- 	<form name="fn_Confirm" method="post" action="${contextPath }/management/confirmPassword" style="margin:auto; align-content: center; top: 50%;"> --%>
		<strong>비밀번호</strong> <br>
		<input type="password" name="inputPw" class="form-control" placeholder="현재 접속중인 계정의 비밀번호를 입력하세요"><br>
		<br>
		<input type="hidden" name="id" value="${mem_Id}">
		<input type="hidden" name="name" value="${mem_Name }" >
		<input type="hidden" name="phone_number" value="${mem_Ph }">
		<input type="hidden" name="grade" value="${mem_Gr }">
		<input type="button" class="btn btn-default btn-round" id="submitWithClose" value="확인">
	</form>
	</div>

</body>
</html>