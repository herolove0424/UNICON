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
<link href="${contextPath}/resources/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="${contextPath}/resources/css/demo.css" rel="stylesheet" />
<title>회원 검색</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.searchBNT {
	font-weight:bold;
	text-decoration:none;
	font-family:Arial;
	box-shadow:inset #f9c20c 0px 5px 8px -1px,#ffffff 1px 5px 2px;
	o-box-shadow:inset #f9c20c 0px 5px 8px -1px,#ffffff 1px 5px 2px;
	-moz-box-shadow:inset #f9c20c 0px 5px 8px -1px,#ffffff 1px 5px 2px;
	-webkit-box-shadow:inset #f9c20c 0px 5px 8px -1px,#ffffff 1px 5px 2px;
	background:#f9c20c;
	background:-o-linear-gradient(90deg, #f9c20c, #f9c20c);
	background:-moz-linear-gradient( center top, #f9c20c 5%, #f9c20c 100% );
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #f9c20c), color-stop(1, #f9c20c) );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f9c20c', endColorstr='#f9c20c');
	background:-webkit-linear-gradient(#f9c20c, #f9c20c);
	background:-ms-linear-gradient(#f9c20c, #f9c20c);
	background:linear-gradient(#f9c20c, #f9c20c);
	text-indent:0px;
	line-height:19px;
	-moz-border-radius:14px;
	-webkit-border-radius:14px;
	border-radius:14px;
	text-align:center;
	vertical-align:middle;
	display:inline-block;
	font-size:22px;
	color:#c78034;
	width:160px;
	height:45px;
	padding:14px;
	text-shadow:#fff3db -1px -1px 0px;
	border-color:#f9c20c;
	border-width:1px;
	border-style:solid;
}

.searchBNT:active {
	box-shadow:inset #f9c20c 0px 5px 8px -1px,#ffffff 1px 0 2px;
	o-box-shadow:inset #f9c20c 0px 5px 8px -1px,#ffffff 1px 0 2px;
	-moz-box-shadow:inset #f9c20c 0px 5px 8px -1px,#ffffff 1px 0 2px;
	-webkit-box-shadow:inset #f9c20c 0px 5px 8px -1px,#ffffff 1px 0 2px;
	position:relative;
	top:5px
}

.searchBNT:hover {
	background:#f9c20c;
	background:-o-linear-gradient(90deg, #f9c20c, #f9c20c);
	background:-moz-linear-gradient( center top, #f9c20c 5%, #f9c20c 100% );
	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #f9c20c), color-stop(1, #f9c20c) );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f9c20c', endColorstr='#f9c20c');
	background:-webkit-linear-gradient(#f9c20c, #f9c20c);
	background:-ms-linear-gradient(#f9c20c, #f9c20c);
	background:linear-gradient(#f9c20c, #f9c20c);
}
</style>
<script type="text/javascript">
	function fct_Member_Search() {
		var v_Member_Search=document.member_Search;
		var v_Search_Keyword=v_Member_Search.search_Keyword.value;
		
		if(v_Search_Keyword==null||v_Search_Keyword==0){
			alert("검색어를 입력해주세요");
		}else{
			v_Member_Search.method="post";
			v_Member_Search.action="${contextPath }/management/member_Search.ddun";
			v_Member_Search.submit();
		}
	}
	
	function popup(member_ID) {
		var popwidth='1000';
		var popheight='700';
		var leftPos = 0;
		var topPos=0;
		var winName='회원 정보 상세 페이지';
		var features = 'left='+ leftPos+', top='+ topPos;
        features  += ',location=no, directories=no, menubar=no, scrollbars=auto';
        features  += ',width='+ popwidth+ ',height='+ popheight;
        
        var reqUrl='${contextPath}/management/management_Detail_Member.ddun?id='+member_ID;
		
		window.open(reqUrl,winName,features);
	}

</script>

</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content">
	<form name="member_Search" method="post">
	 <div class="form-group">
		<select name="search_Option" class="form-control" style="width: 15%; float:left; ">
			 <option value="member_Id" selected="selected"> 아이디
			 <option value="member_Name"> 이름
			 <option value="member_Phone_Number"> 휴대폰 번호
			 <option value="member_Email"> 이메일
		</select>
	</div>
	<div class="form-group">
		<input type="text" name="search_Keyword" style="width: 50%;" class="form-control">
	</div>
			<div class="form-group" style="clear: left: ;">
				<input type="button" value="SEARCH" onclick="fct_Member_Search()"
					class="searchBNT"> <input type="reset" value="RESET"
					class="searchBNT">
			</div>

		</form>
	
	<c:choose>
		<c:when test="${resultMember!=null }">
			<table class="table table-hover">
			<tr style="background-color: #fcf8e3;">
				<td><strong>아이디</strong></td>
				<td><strong>이름</strong></td>
				<td><strong>이메일</strong></td>
				<td><strong>가입일</strong></td>
			</tr>
		
			<c:forEach var="searchMember" items="${resultMember }">
 			<tr style="background: white;">
				<td><a href="javascript:popup('${searchMember.id }')">${searchMember.id }</a></td>
				<td>${searchMember.name }</td>
				<td>${searchMember.email }</td>
				<td><fmt:formatDate value="${searchMember.join_date }" pattern="YYYY/MM/d HH:mm:ss"/></td>
			</tr>
			</c:forEach>
		</table>
		</c:when>
		
		<c:otherwise>
			<div class="alert alert-danger" role="alert">
    			<strong>New User</strong> 금일 신규 가입자
			</div>
			<table class="table table-hover">
			<tr class="table-warning">
				<td><strong>아이디</strong></td>
				<td><strong>이름</strong></td>
				<td><strong>이메일</strong></td>
				<td><strong>가입일</strong></td>
			</tr>
		
			<c:forEach var="newMemberList" items="${newMemberList }">
 			<tr class="table-light">
				<td><a href="javascript:popup('${newMemberList.id }')">${newMemberList.id }</a></td>
				<td>${newMemberList.name }</td>
				<td>${newMemberList.email }</td>
				<td><fmt:formatDate value="${newMemberList.join_date }" pattern="YYYY/MM/d HH:mm:ss"/></td>
			</tr>
			</c:forEach>
		</table>
		</c:otherwise>
	</c:choose>
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