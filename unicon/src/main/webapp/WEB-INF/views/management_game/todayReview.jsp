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
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
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
     hiddenField2.setAttribute("value", "/management/todayReview.ddun");
     
     var hiddenField3 = document.createElement("input");
     hiddenField3.setAttribute("type", "hidden");
     hiddenField3.setAttribute("name", "whatPage");
     hiddenField3.setAttribute("value", "today");

     form.appendChild(hiddenField);
     form.appendChild(hiddenField2);
     form.appendChild(hiddenField3);
	
	 document.body.appendChild(form);
	 form.submit();
}
</script>
</head>
<body>

	<!-- 오늘 리스트 -->
	<form>
	<table class="table table-condensed">
		<tr class="table-danger" align="center">
			<td width="10%"><strong>작성자</strong></td>	
			<td width="75%"><strong>내용</strong></td>
			<td width="10%"><strong>작성일</strong></td>
			<td width="5%"><strong>삭제</strong></td>
		</tr>
		
		<c:choose>
			<c:when test="${todayList==null }">
				<tr class="table-light" align="center">
					<td colspan="4">오늘 등록된 리뷰가 없습니다.</td>
				</tr>
			</c:when>
			
			<c:when test="${todayList!=null }">
				<c:forEach var="list" items="${todayList }">
					<tr class="table-light" align="center">
						<td>${list.id }</td>
						<td><p class="text-danger">${list.content }</p></td>
						<td><fmt:formatDate value="${list.writedate }" pattern="YYYY/MM/d hh:mm:ss" /></td>
						<td><input type="button" value="X" class="btn btn-warning" onclick="delReview('${list.review_code}')"></td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	</form>

</body>
</html>