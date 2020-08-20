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
<title>메세지 보기</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function delDetailMessage(messagenum) {
		var form=document.createElement("form");
        form.method="post";
		form.action="${contextPath }/message/delSendDetailMessage.do";
		
		var hiddenField = document.createElement("input");
	    hiddenField.setAttribute("type", "hidden");
	    hiddenField.setAttribute("name", "messagenum");
	    hiddenField.setAttribute("value", messagenum);
	     
	    form.appendChild(hiddenField);
		
		document.body.appendChild(form);
		form.submit();
	}
</script>
</head>
<body>
	<div class="container" align="right">
		<br>
		<h3 class="sans" align="left">쪽지 상세내용</h3>
		<table class="table">
			<tr align="center">
				<td align="left" style="vertical-align:middle;">
					${detailList.title}
				</td>
				<td align="right" style="vertical-align:middle;">										
					받은 사람: ${detailList.id}<br>
					보낸 시간: ${detailList.sendday}<br>
				</td>
			</tr>
			<tr>
				<td colspan="2">	
					${detailList.content}
				</td>
			</tr>
		</table>
		<hr>
		<input class="btn btn-default btn-round" type="button" value="삭제"
		onclick="delDetailMessage(${detailList.messagenum})">
	</div>
</body>
</html>