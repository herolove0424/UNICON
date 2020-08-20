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
<title>리뷰 관리</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content">
	<button type="button" onclick="all_Review()" class="btn btn-warning" style="float: left;" >전체</button>	
	<button type="button" onclick="today_Review()" class="btn btn-danger" style="float: left;">금일 등록 확인</button>
	<button type="button" onclick="searchDayReview()" class="btn btn-secondary" style="float: left;">날짜 별 검색</button>
	<!-- 날짜검색 폼 띄우기 -->
	    <form id="searchDays" name="searchDays" class="form-inline">
	        <div id="searchDay" class="form-group">
	        </div>
	    </form>
	<br>
	<jsp:include page="${whatPage }" flush="false"></jsp:include>

	<!-- 날짜검색 리스트 -->
	<!-- <div class="searchedDays">
	    <form id="searchedDays" name="searchedDays" method="post">
	        <div id="searchedDays">
	        </div>
	    </form>
	</div> -->
	
	
	
	
	<!-- 스크립트 사용 -->
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
			<script type="text/javascript">
			

				function all_Review() {
					var form = document.createElement('form');
					form.method = "get";
					form.action = "${contextPath }/management/gameReview.ddun";
					document.body.appendChild(form);
					form.submit();
				}

				function today_Review() {
					var form = document.createElement('form');
					form.method = "get";
					form.action = "${contextPath }/management/todayReview.ddun";
					document.body.appendChild(form);
					form.submit();

				}

				function searchDayReview() {
					var html = "";
					html += "<input type='date' name='startDay' value='${startDay}' class='form-control' id='startDay'>&nbsp;";
					html += "<input type='date' name='endDay' value='${endDay}' class='form-control' id='endDay'>";
					html += "<input type='button' value='검색'class='form-control' onclick='startEndSearch()'>";

					$("#searchDay").html(html);
				}

				function startEndSearch() {
					var form = document.searchDays;
					
					var hiddenField = document.createElement("input");
				     hiddenField.setAttribute("type", "hidden");
				     hiddenField.setAttribute("name", "currentPageNo");
				     hiddenField.setAttribute("value", "1");
				     
				     var hiddenField2 = document.createElement("input");
				     hiddenField2.setAttribute("type", "hidden");
				     hiddenField2.setAttribute("name", "recordsPerPage");
				     hiddenField2.setAttribute("value", "10");
				     
				     form.appendChild(hiddenField);
				     form.appendChild(hiddenField2);
					
					form.method = "get";
					form.action = "${contextPath }/management/searchDayReview.ddun";
					form.submit();

				}
			</script>
			
		</div>
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