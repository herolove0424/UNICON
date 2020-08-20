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
<title>게임 관리</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	          
		var actionForm = $("actionForm");
	          
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			console.log('click');
	             
			actionForm.find("input[name='currentPageNo']").val($(this).attr("href"));
			actionForm.attr("action", "${contextPath }/board/selectBoardPaging");
			actionForm.submit();
		});
	});
	      		
	$(document).ready(function(){
	      	      
		var actionForm = $("#actionForm");
		
		$(".page-link").on("click", function(e) {
		         	//클릭한 페이지번호의 <a>태그가 원래의 동작을 못하도록 함
			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='currentPageNo']").val($(this).attr("href"));
			actionForm.submit(); //form을 보냄
		});
	});
	
	function writeGameInfo() {
		var form = document.createElement("form");
		form.method="post";
		form.action="${contextPath }/management/game_RegisteForm.ddun";
		document.body.appendChild(form);
		form.submit();
	}
	
	function reset() {
		$("#searchType").val("");
		$("#searchKeyword").val("");
	}
	
	
</script>
</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content" >
	<table class="table table-hover">
		<thead>
		<tr class="table-primary" align="center">
			<td><strong>게임 코드</strong></td>
			<td><strong>게임 이름</strong></td>
			<td><strong>대분류</strong></td>
			<td><strong>소분류</strong></td>
			<td><strong>발매일</strong></td>
		</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${all_Gamelist==null }">
				<tr>
					<td colspan="5">등록된 글이 없습니다.</td>
				</tr>
			</c:when>
			
			<c:when test="${all_Gamelist!=null }">
				<c:forEach var="list" items="${all_Gamelist }">
					<tr class="table-light" align="center">
<!-- 					<tr style="background-color: white;" align="center"> -->
						<td>${list.game_code }</td>
						<td><strong><a href="${contextPath }/management/viwe_Detail.ddun?
						game_code=${list.game_code}&currentPageNo=${pagingCreator.pagingDTO.currentPageNo}
						&recordsPerPage=${pagingCreator.pagingDTO.recordsPerPage}
						&searchType=${pagingCreator.pagingDTO.searchType }&searchKeyword=${pagingCreator.pagingDTO.searchKeyword }" style="color: black;">${list.game_name }</a></strong></td>
						<td>${list.big_category }</td>
						<td>${list.small_category }</td>
						<td><fmt:formatDate value="${list.release_date }" pattern="YYYY/MM/d"/></td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
		</tbody>
	</table>
	
		<!-- 검색 기능 사용 -->
              	<div class="form-group">
              	<form name="searchForm" action="${contextPath }/management/gamelist.ddun" method="get">
	              	<select name="searchType" id="searchType" class="form-control" style="width: 15%; float:left; ">
	              		<!-- <option value="null" selected="selected" disabled="disabled" > -->
	              		<option value="ALL" selected="selected" ${param.searchType eq "ALL" ? "selected" :""}> --전체--
	              		<option value="PC" ${param.searchType eq "PC" ? "selected" :""}> PC
	              		<option value="MOBILE" ${param.searchType eq "MOBILE" ? "selected" :""}> MOBILE
	              		<option value="CONSOLE" ${param.searchType eq "CONSOLE" ? "selected" :""}> CONSOLE
	              		<option value="SWITCH" ${param.searchType eq "SWITCH" ? "selected" :""}> SWITCH
	              		<option value="PS4" ${param.searchType eq "PS4" ? "selected" :""}> PS4
	              		<option value="XBOX" ${param.searchType eq "XBOX" ? "selected" :""}> XBOX
	              	</select>
	              	<input type="hidden" name="currentPageNo" value="1">
	              	<input type="hidden" name="recordsPerPage" value="10">
	              	<input type="text" value="${param.searchKeyword }" name="searchKeyword" id="searchKeyword" size="20" class="form-control form-control-lg" style="width: 40%; float:left;">
	              	&nbsp;&nbsp;
	              	<input type="submit" value="검색" class="btn btn-warning btn-fill" style="width: 2.2cm;">
	              	<input type="button" value="글쓰기" class="btn btn-warning btn-fill" onclick="writeGameInfo()">
    			</form>
              	</div>
              	
			<div class="container" align="center" style="clear: both;">
              <div class="pagination justify-content-center">
              	<div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
              		<div class="pagination">
              			<c:if test="${pagingCreator.isPrev}">
                       		<span class="paginate_button page-item previous" id="dataTable_previous">
                          	<a href="${pagingCreator.startPageNo - pagingCreator.pageNoCnt}" aria-controls="dataTable" class="page-link">Previous</a>
                     		</span>
                  		</c:if>   
                    
                    	<c:forEach  var="displayPagingNo"
                             begin="${pagingCreator.startPageNo}"
                             end="${pagingCreator.endPageNo }">   
                      		<span class="paginate_button page-item ${pagingCreator.pagingDTO.currentPageNo == displayPagingNo ? 'active' : '' }">
                       <!-- <li class="paginate_button"> -->
                          	<a href="${displayPagingNo}" aria-controls="dataTable" class="page-link">${displayPagingNo}</a>
                      	 	</span>
                    	</c:forEach>
                       
                    	<c:if test="${pagingCreator.isNext}">
                       		<span class="paginate_button page-item next" id="dataTable_next">
                          	<a href="${pagingCreator.endPageNo + 1 }" aria-controls="dataTable" class="page-link">Next</a>
                       		</span>
                    	</c:if>   
              		</div>
              	</div>
              </div>
              </div>
            
              	<!-- 페이지에서 사용 -->
              	<form id="actionForm" action="${contextPath }/management/gamelist.ddun" method="get">
              		<input type="hidden" name="currentPageNo" value="${pagingCreator.pagingDTO.currentPageNo }">
              		<input type="hidden" name="recordsPerPage" value="${pagingCreator.pagingDTO.recordsPerPage }">
              		<input type="hidden" name="searchType" value="${pagingCreator.pagingDTO.searchType }">
              		<input type="hidden" name="searchKeyword" value="${pagingCreator.pagingDTO.searchKeyword }">
              	</form>
              	<br>
              
              
              
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