<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
%>    
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.0/pulse/bootstrap.min.css" integrity="sha384-t87SWLASAVDfD3SOypT7WDQZv9X6r0mq1lMEc6m1/+tAVfCXosegm1BvaIiQm3zB" crossorigin="anonymous">
  <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css"> 
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="${contextPath}/resources/css/demo.css" rel="stylesheet" />
<title>공지 게시판</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function resetFunction() {
		var form = document.createElement("form");
        form.setAttribute("charset", "UTF-8");
        form.setAttribute("method", "get");  //Post 방식
        form.setAttribute("action", "${contextPath}/management/notice.ddun"); //요청 보낼 주소
        document.body.appendChild(form);

        form.submit();
	}
	
$(document).ready(function(){
		
		var noticeListForm = $("noticeListForm");
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			console.log('click');
			
			noticeListForm.find("input[name='currentPageNo']").val($(this).attr("href"));
			noticeListForm.attr("action", "${contextPath}/management/notice.ddun");
			noticeListForm.submit();
		});
	});
	
$(document).ready(function(){
	
		var noticeListForm = $("#noticeListForm");
	
		$(".page-link").on("click", function(e) {
			//클릭한 페이지번호의 <a>태그가 원래의 동작을 못하도록 함
			e.preventDefault();
			console.log('click');
			noticeListForm.find("input[name='currentPageNo']").val($(this).attr("href"));
			noticeListForm.submit(); //form을 보냄
		});
	});
</script>

</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content">
		<table class="table table-hover">
			<tr class="table-info"> 
			<!-- <tr style="background-color: #A991D4;"> -->
			<!-- <tr class="table-secondary">  -->
				<td><strong>게시글 번호</strong></td>
				<td><strong>공지 제목</strong></td>
				<td><strong>사용여부</strong></td>
				<td><strong>작성자</strong></td>
				<td><strong>조회수</strong></td>
				<td><strong>작성일</strong></td>
			</tr>
<!-- notice.xml orderby 수정 -->
			<c:choose>
				<c:when test="${noticeList==null }">
					<tr class="table-light">
						<td colspan="5">등록된 글이 없습니다.</td>
					</tr>
				</c:when>
				<c:when test="${noticeList!=null }">
					<c:forEach var="list" items="${noticeList }">
						<tr class="table-light">
							<td>${list.boardno }</td>
							<td><a
								href="${contextPath }/management/noticeView.ddun?
						boardno=${list.boardno}&currentPageNo=${pagingCreatorDTO.pagingDTO.currentPageNo}
						&recordsPerPage=${pagingCreatorDTO.pagingDTO.recordsPerPage}
						&searchType=${pagingCreatorDTO.pagingDTO.searchType }&searchKeyword=${pagingCreatorDTO.pagingDTO.searchKeyword }" style="color: #212529;">${list.title }</a></td>
							<c:if test="${list.exposal==1 }">
								<td>사용</td>
							</c:if>

							<c:if test="${list.exposal==0 }">
								<td>미사용</td>
							</c:if>

							<td>${list.id }</td>
							<td>${list.viewcount }</td>
							<td><fmt:formatDate value="${list.writedate }"
									pattern="YYYY-MM-dd HH:mm:ss" /></td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		
				<form id="searchForm" action="${contextPath}/management/notice.ddun" method="get" class="form-inline" >
					<select name='searchType' class="form-control">
						<option value=null selected="seleted" ${param.searchType eq "null" ? "selected" :""}>--

						<option value="T" ${param.searchType eq "T" ? "selected" :""}>제목
						
						<option value="C" ${param.searchType eq "C" ? "selected" :""}>내용
						
						<option value="I" ${param.searchType eq "I" ? "selected" :""}>글쓴이
						
						<option value="TC" ${param.searchType eq "TC" ? "selected" :""}>제목+내용
						
						<option value="TI" ${param.searchType eq "TI" ? "selected" :""}>제목+글쓴이
						
						<option value="TCI" ${param.searchType eq "TCI" ? "selected" :""}>제목+내용+글쓴이
						
					</select>&nbsp;
					<input type='hidden' name='currentPageNo' value="${pagingCreatorDTO.pagingDTO.currentPageNo}"> 
					<input type='hidden' name='recordsPerPage' value="${pagingCreatorDTO.pagingDTO.recordsPerPage}"> 
					<input type='text' size="40" name='searchKeyword' class="form-control" value="${param.searchKeyword}"> &nbsp;
					<input type='submit' value="검색" class="btn btn-warning btn-fill btn-sm" style="font-size: medium;"> &nbsp;
					<input type="button" value="처음으로" onclick="resetFunction()" class="btn btn-warning btn-fill btn-sm"  style="font-size: medium;"> &nbsp;
					<input type="button" value="글쓰기" onclick="location.href='noticeForm.ddun'" class="btn btn-warning btn-fill btn-sm"  style="font-size: medium;">&nbsp;
				</form>
		
		<br>
		<div class="col-sm-12 col-md-7">
			<div class="dataTables_paginate paging_simple_numbers"
				id="dataTable_paginate">
				<div class="pagination">
					<c:if test="${pagingCreatorDTO.isPrev}">
						<li class="paginate_button page-item previous"
							id="dataTable_previous"><a
							href="${pagingCreatorDTO.startPageNo - pagingCreatorDTO.pageNoCnt}"
							aria-controls="dataTable" class="page-link">Previous</a></li>
					</c:if>

					<c:forEach var="displayPagingNo"
						begin="${pagingCreatorDTO.startPageNo}"
						end="${pagingCreatorDTO.endPageNo }">
						<li
							class="paginate_button page-item ${pagingCreatorDTO.pagingDTO.currentPageNo == displayPagingNo ? 'active' : '' }">
							<a href="${displayPagingNo}" aria-controls="dataTable"
							class="page-link">${displayPagingNo}</a>
						</li>
					</c:forEach>

					<c:if test="${pagingCreatorDTO.isNext}">
						<li class="paginate_button page-item next" id="dataTable_next">
							<a href="${pagingCreatorDTO.endPageNo + 1 }"
							aria-controls="dataTable" class="page-link">Next</a>
						</li>
					</c:if>
				</div>
			</div>
		</div>

		

		<form id="noticeListForm"
			action="${contextPath}/management/notice.ddun" method='get'>
			<input type='hidden' name='currentPageNo'
				value="${pagingCreatorDTO.pagingDTO.currentPageNo}"> <input
				type='hidden' name='recordsPerPage'
				value="${pagingCreatorDTO.pagingDTO.recordsPerPage}"> <input
				type='hidden' name='searchKeyword'
				value="${pagingCreatorDTO.pagingDTO.searchKeyword}"> <input
				type='hidden' name='searchType'
				value="${pagingCreatorDTO.pagingDTO.searchType}">
		</form>

	</div>
	</div>
	</div>

</body>
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