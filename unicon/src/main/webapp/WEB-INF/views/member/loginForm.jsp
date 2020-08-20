<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="isLogOn" value="${param.isLogOn}" />
<c:set var="id" value="${param.id}" />
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

<title>로그인 페이지</title>

<!--20200728 김도경 추가  -->
<c:choose>
	<c:when test="${result=='addMem'}">
		<script>
			window.onload = function() {
				alert("회원가입 성공");
			}
		</script>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${isLogOn=='false'}">
		<script type="text/javascript">
			window.onload = function() {
				alert("아이디 또는 비밀번호가 틀립니다. 다시 로그인 해주세요.");
			}
		</script>
	</c:when>
</c:choose>
<c:choose>
	<c:when test="${message!=null}">
		<script>
			window.onload = function() {
				alert("비밀번호 변경 성공");
				window.close();
				self.close();
				close();
			}
		</script>
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${id!=null}">
		<script>
			window.onload = function() {
				alert("회원가입이 완료되었습니다.");
				window.close();
				self.close();
				close();
			}
		</script>
	</c:when>

</c:choose>

<script>
	function popup() {
		var url = "${contextPath}/member/idfindForm.do";
		var name = "popup test";
		var option = "width = 700, height = 500, top = 100, left = 200, location = no"
		window.open(url, name, option);
	}
</script>
<script>
	function popuppw() {
		var url = "${contextPath}/member/pwfindForm.do";
		var name = "popup test";
		var option = "width = 700, height = 500, top = 100, left = 200, location = no"
		window.open(url, name, option);
	}
</script>
<script>
	function onEnterSubmit(){
	
		var keyCode = window.event.keyCode;
		if(keyCode==13) loginProcess(login);
	}
</script>
</head>
<body>
	<div class="section section-signup page-header">
		<div class="container">
			<div class="row">
				<div class="col-lg-4 col-md-6 mx-auto">
					<div class="card card-login">
						<form class="form" name="login">
							<div class="card-header card-header-default text-center">
								<h4 class="card-title">Login</h4>
							</div>
							<div class="card-body">
								<div class="input-group">
									<div class="input-group-prepend">
										<span class="input-group-text">
											<i class="material-icons">perm_identity</i>
										</span>
									</div>
									<input type="text" name="id" class="form-control" placeholder="id" autocomplete="">
								</div>
								<div class="input-group">
									<div class="input-group-prepend">
										<span class="input-group-text">
											<i class="material-icons">lock_outline</i>
										</span>
									</div>
									<input type="password" name="password" class="form-control" placeholder="Password" autocomplete="" onkeydown='javascript:onEnterSubmit()'>
								</div>
							</div>
							<br>
							<div class="footer text-center">
								<input type="button" class="btn btn-default col-md-4" value="로그인" onclick="loginProcess(this.form);"/>
								<input type="reset" class="btn btn-default col-md-4" value="초기화"/><br>
								<input type="button" class="btn btn-default col-md-8" value="아이디 찾기" onclick="javascript:popup()"/><br>
								<input type="button" class="btn btn-default col-md-8" value="비밀번호 찾기" onclick="javascript:popuppw()"/><br>
								<input type="button" class="btn btn-default col-md-8" value="회원가입" onclick="location.href='${contextPath}/member/memForm.do'"/>							
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <!-- <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button> -->
	        <h4 class="modal-title" align="center">
	        <strong>비밀번호 변경</strong>
	        </h4>
	        
	      </div>
	      <div class="modal-body">
	        <p><input type="password" id="modPassword" name="modPassword" class="form-control"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" onClick="changingPw('${contextPath }/management/changePrimaryPw.go');">Save changes</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>

<jsp:include page="../bootstrap/footer.jsp" />

<!-- Core JS Files -->
<script src="${contextPath}/resources/js/core/jquery.min.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/js/core/popper.min.js"
	type="text/javascript"></script>
<script
	src="${contextPath}/resources/js/core/bootstrap-material-design.min.js"
	type="text/javascript"></script>
<script src="${contextPath}/resources/js/plugins/moment.min.js"></script>

<!-- Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
<script
	src="${contextPath}/resources/js/plugins/bootstrap-datetimepicker.js"
	type="text/javascript"></script>

<!-- Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
<script src="${contextPath}/resources/js/plugins/nouislider.min.js"
	type="text/javascript"></script>

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>

<!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
<script src="${contextPath}/resources/js/material-kit.js?v=2.0.4"
	type="text/javascript"></script>
<link rel="stylesheet" href="jquery.nouislider.min.css">

<!--20200728 김도경 추가  -->
<!-- <script src="https://code.jquery.com/jquery-latest.min.js"></script> -->
<script type="text/javascript">
	function loginProcess(obj) {
		var valueByPw = $('input[name=password]').val();
		/* console.log("비밀번호 반환: " + valueByPw) */
		if (valueByPw == 'gmUniconTemp') {
			/* $("#managerModal").show(); */
			$('#myModal').modal("show");
		} else {
			obj.method = "post";
			obj.action = "${contextPath}/member/login.do";
			obj.submit();
		}
	}

	function closeModal() {
		$('.searchModal').hide();
	};

	function changingPw(url) {
		var valueById = $('input[name=id]').val();
		var valueByPw = $('input[name=modPassword]').val();

		if (valueByPw == 'gmUniconTemp') {
			alert("초기 비밀번호로는 비밀번호를 변경할 수 없습니다");
			$("#modPassword").val("");
		} else {
			if (confirm("비밀번호를 변경하시겠습니까?")) {
				/* console.log("비밀번호 변경"); */

				var form = document.createElement("form");
				form.setAttribute("method", "post");
				form.setAttribute("action", url);

				var valueByPwInput = document.createElement("input");
				valueByPwInput.setAttribute("type", "hidden");
				valueByPwInput.setAttribute("name", "valueByPw");
				valueByPwInput.setAttribute("value", valueByPw);

				var valueByIdInput = document.createElement("input");
				valueByIdInput.setAttribute("type", "hidden");
				valueByIdInput.setAttribute("name", "valueById");
				valueByIdInput.setAttribute("value", valueById);

				form.appendChild(valueByPwInput);
				form.appendChild(valueByIdInput);

				document.body.appendChild(form);

				form.submit();

				closeModal();
			} else {
				$("#modPassword").val("");
			}

		}

	}
</script>
</html>