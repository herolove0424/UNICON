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
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<!-- CSS Files -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.0/minty/bootstrap.min.css">
<title>활동 관리</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function deleteMemberActBoard(id,status,boardNO) {
		var form = document.createElement("form");
			location.href="deleteMemberActBoard.ddun?boardNO="+boardNO+"&id="
			+id+"&status="+status;
	}
</script>
</head>
	<jsp:include page="../bootstrap/managerSerchSidebar.jsp"></jsp:include>
<body>
	<table class="table table-hover">
	<thead>
		<tr align="center">
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">날짜</th>
			<th scope="col">조회수</th>
			<th scope="col">삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:choose>
			<c:when test="${memberActList==null}">
				<tr>
					<td colspan="5">등록한 글이 없습니다.</td>
				</tr>
			</c:when>
			<c:when test="${memberActList!=null }">
				<c:forEach var="list" items="${memberActList }" varStatus="num">
					<tr align="center">
						<td scope="row">${num.count }</td>
						<td scope="row">
						<a href="${contextPath }/management/searchMembersBoard.ddun?id=${list.id}&boardNO=${list.boardNO}&title=${list.title}&status=${list.status}"
							target="_blank">${list.title }</a></td>
						<%-- <td scope="row">${list.writeDate }</td> --%>
						<td scope="row"><fmt:formatDate value="${list.writeDate }" pattern="YYYY/MM/d HH:mm:ss"/></td>
						<td scope="row">${list.viewCount }</td>
						<td scope="row"><input type="button" value="X" class="btn btn-warning" onclick="deleteMemberActBoard('${list.id}','${list.status}','${list.boardNO}')"></td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
		</tbody>
		
	</table>
	
	<div class="col-sm-12 col-md-7" >
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
              <form id="actionForm" action="${contextPath }/management/memberActivity.ddun" method="get">
              		<input type="hidden" name="currentPageNo" value="${pagingCreator.pagingDTO.currentPageNo }">
              		<input type="hidden" name="recordsPerPage" value="${pagingCreator.pagingDTO.recordsPerPage }">
              		<input type="hidden" name="id" value="${id }">
              	</form>
              	
   <script src="https://code.jquery.com/jquery-latest.min.js"></script>  	
   <script type="text/javascript">
   
			$(document).ready(function(){
			    
				var actionForm = $("actionForm");
			          
				$(".paginate_button a").on("click", function(e){
					e.preventDefault();
					console.log('click');
			             
					actionForm.find("input[name='currentPageNo']").val($(this).attr("href"));
					actionForm.attr("action", "${contextPath }/management/memberActivity.ddun");
					
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
</script>
              
      
</body>
</html>