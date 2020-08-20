<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="message" value="${param.message}" />
<c:set var="same" />
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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
    $('#password').keyup(function(){
    	$('#pwcheck').html('');
    	$('#pw').html('');
    	var pw = $('#password').val();
	  
    	if(pw.length < 8 || pw.length > 20){
	    	$("#pw_div").attr('class','form-group label-floating has-danger');
			$("#password").attr('data-content','8~20자리 이내로 입력하세요');
			$("#password").popover('show');
			$("#pw_done").hide();
			$("#pw_clear").show();
	  	  	same='true';
  	 	} 
    	else {
    		$("#pw_div").attr('class','form-group label-floating has-success');
			$("#password").popover('hide');
			$("#pw_clear").hide();
			$("#pw_done").show();
    	}
    });

  $('#password_check').keyup(function(){

      if($('#password').val() != $('#password_check').val()){
    	  	$("#pw_check_div").attr('class','form-group label-floating has-danger');
			$("#password_check").attr('data-content','비밀번호가 일치하지 않습니다');
			$("#password_check").popover('show');
			$("#pw_check_done").hide();
			$("#pw_check_clear").show();
        	same='true';
      }else{
    	  	$("#pw_check_div").attr('class','form-group label-floating has-success');
			$("#password_check").popover('hide');
			$("#pw_check_clear").hide();
			$("#pw_check_done").show();
        same='false';
      }
  });
});
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function Formcheck() {
	var Fomcheck = document.fomch;
	var formpassword = Fomcheck.password.value;
	var formpassword_check = Fomcheck.password_check.value;
	if(same=='true'){
		alert("입력값을 확인해주세요");
	}
	else if (formpassword.length ==0 || formpassword==""){
		alert("비밀번호를 입력해주세요");
	}
	else if (formpassword =='gmUniconTemp'){
		alert("비밀번호를 사용할 수 없습니다. 다른 비밀번호를 이용해 주세요.");
	}else if(formpassword_check.length ==0 || formpassword_check!=formpassword)
	{
		alert("비밀번호가 일치하지 않습니다.");

	}else{
		Fomcheck.method= "post";
		Fomcheck.action="${contextPath}/member/pwmodify.do";
		Fomcheck.submit();
	}
}
</script>
<style type="text/css">
.sans {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
</head>
<body>
	<div class="col-lg-4 col-md-6 mx-auto">
		<form name="fomch">
			<div class="card card-login">
				<input type="hidden" value="${id}" id="id" name="id">
				<div class="card-header card-header-default text-center">
					<span class="sans" style="font-size: 15pt">비밀번호 변경</span>
				</div>
				<input type="hidden" value="${nickname}" id="nickname" name="nickname">
				<div class="col-md-12">
					<div class="form-group" id="pw_div">
						<label for="password">Password</label>
						<input type="password" class="form-control col-md-12" id="password" name="password"
							placeholder="Password" data-container="body" data-toggle="popover"
							data-placement="right" data-content="">
						<div id="pw_done" style="display: none">
							<span class="form-control-feedback">
								<i class="material-icons">done</i>
							</span>
						</div>
						<div id="pw_clear" style="display: none">
							<span class="form-control-feedback">
								<i class="material-icons">clear</i>
							</span>
						</div>
					</div>
					<div class="form-group" id="pw_check_div">
						<label for="password_check">Password Check</label> <input
							type="password" class="form-control" id="password_check"
							name="password_check" placeholder="Password Check"
							data-container="body" data-toggle="popover" data-placement="right"
							data-content=""><font id="pwcheck" size="2"></font>
						<div id="pw_check_done" style="display: none">
							<span class="form-control-feedback"> <i
								class="material-icons">done</i>
							</span>
						</div>
						<div id="pw_check_clear" style="display: none">
							<span class="form-control-feedback"> <i
								class="material-icons">clear</i>
							</span>
						</div>
					</div>
				</div>
				<div class="container" align="center" style="margin-bottom:20px">
					<input type="button" class="btn btn-primary" onclick="Formcheck()"
						value="비밀번호 변경" />
					<button type="reset" class="btn btn-primary">
						<i class="fa fa-refresh fa-spin fa-3x fa-fw"></i>다시 입력
					</button>
				</div>
			</div>
		</form>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>