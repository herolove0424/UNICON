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
<title></title>
</head>
<body>
	
	<!-- 모든 리스트 -->
	<form>
	<table class="table table-condensed">
		<tr class="table-danger" align="center">
			<td width="10%"><strong>작성자</strong></td>	
			<td width="75%"><strong>내용</strong></td>
			<td width="10%"><strong>작성일</strong></td>
			<td width="5%"><strong>삭제</strong></td>
		</tr>
		
		<c:choose>
			<c:when test="${reviewList==null }">
				<tr class="table-light" align="center">
					<td colspan="4">등록된 리뷰가 없습니다.</td>
				</tr>
			</c:when>
			
			<c:when test="${reviewList!=null }">
				<c:forEach var="list" items="${reviewList }">
					<tr class="table-light" align="center">
						<td>${list.id }</td>
						<td><p class="text-danger">${list.content }</p></td>
						<td><fmt:formatDate value="${list.writedate }" pattern="YYYY/MM/d hh:mm:ss" /></td>
						<td><input type="button" value="X" class="btn btn-warning"  onclick="delReview('${list.review_code}')"></td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
		<!-- 페이징 -->
 		<div class="container">
             <div class="dataTables_paginate paging_simple_numbers" id="dataTable_paginate">
              	<div class="pagination justify-content-center">
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
	</form>
	
	<!-- 페이지에서 사용 -->
	<form id="actionForm" action="${contextPath }/management/gameReview.ddun" method="get">
		<input type="hidden" name="currentPageNo" value="${pagingCreator.pagingDTO.currentPageNo }"> 
		<input type="hidden" name="recordsPerPage" value="${pagingCreator.pagingDTO.recordsPerPage }">
	</form>
	
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
			<script type="text/javascript">
				$(document).ready(function(){
				          
					var actionForm = $("actionForm");
				          
					$(".paginate_button a").on("click", function(e){
						e.preventDefault();
						console.log('click');
				             
						actionForm.find("input[name='currentPageNo']").val($(this).attr("href"));
						actionForm.attr("action", "${contextPath }/management/gameReview.ddun");
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
				
				function delReview(review_code) {
					var form = document.createElement('form');
					form.method = "post";
					form.action = "${contextPath }/management/delReview.ddun";
					
					 var hiddenField = document.createElement("input");
			         hiddenField.setAttribute("type", "hidden");
			         hiddenField.setAttribute("name", "review_code");
			         hiddenField.setAttribute("value", review_code);
			         
			         var hiddenField2 = document.createElement("input");
			         hiddenField2.setAttribute("type", "hidden");
			         hiddenField2.setAttribute("name", "url");
			         hiddenField2.setAttribute("value", "/management/gameReview.ddun");
			         
			         var hiddenField3 = document.createElement("input");
			         hiddenField3.setAttribute("type", "hidden");
			         hiddenField3.setAttribute("name", "whatPage");
			         hiddenField3.setAttribute("value", "all");

			         form.appendChild(hiddenField);
			         form.appendChild(hiddenField2);
			         form.appendChild(hiddenField3);
					
					 document.body.appendChild(form);
					 form.submit();
				}
		</script>

</body>
</html>