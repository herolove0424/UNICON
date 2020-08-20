<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 메세지</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function delMessages() {
		var checkArr = [];
		var values = $('input:checkbox[name=delCheck]:checked').length;
		console.log(values);
		if (values == 0) {
			alert("쪽지를 선택해주세요");
		} else {
			$("input[name=delCheck]:checked").each(function() {
				checkArr.push($(this).val());
			});

			$.ajax({
				url : "<c:url value='/message/delMessages.do' />",
				type : 'get',
				data : {
					valueArrTest : checkArr
				},
				success : function(data) {
					if (data == "success") {
						console.log("메세지 삭제 완료");
						location.href = location.href;
					}

				},
				error : function(data) {
					if (data == "error") {
						console.log("메세지 삭제 실패");
						location.href = location.href;
					}

				}

			});
		}

	}

	function replyMessage() {
		var values = $('input:checkbox[name=delCheck]:checked').length;
		//console.log("눌렀다네");
		if (values >= 2) {
			alert("1개의 쪽지를 선택해주세요");
		} else if (values == 0) {
			alert("쪽지를 선택해주세요");
		} else {
			//var value = $('input:checkbox[name=delCheck]:checked').val;
			//console.log("값?"+value);
			for (var i = 0; i < values; i++) {
				if (document.getElementsByName("delCheck")[i].checked == true) {
					var checkedValue = document.getElementsByName("delCheck")[i].value;
					//alert(checkedValue);

					var form = document.createElement("form");
					form.method = "post";
					form.action = "${contextPath }/message/replyMessage.do";

					var hiddenField = document.createElement("input");
					hiddenField.setAttribute("type", "hidden");
					hiddenField.setAttribute("name", "messagenum");
					hiddenField.setAttribute("value", checkedValue);

					form.appendChild(hiddenField);

					document.body.appendChild(form);
					form.submit();
				}
			}
		}
	}
</script>
</head>
<body>
	<div class="container" align="right">
		<br>
		<h3 class="sans" align="left">받은 쪽지함</h3>
		<form id="fn_Message_Form" name="fn_Message_Form" method="get"
			action="${contextPath }/message/delMessages.do">
			<table class="table">
				<tr align="center">
					<td>#</td>
					<td>보낸 사람</td>
					<td>내용</td>
					<td>날짜</td>
				</tr>
				<c:choose>					
					<c:when test="${messageList!=null}">
						<c:forEach var="list" items="${messageList}" varStatus="num">
							<c:if test="${list.readyn==1}">
								<tr align="center">
									<td>
										<input type="checkbox" name='delCheck' value="${list.messagenum }">
									</td>
									<td style="color: blue;">${list.send_id}</td>
									<td style="color: blue;">
										<a href="${contextPath }/message/detailMessage.do?messagenum=${list.messagenum}">${list.title }</a>
									</td>
									<td style="color: blue;">${list.sendday}</td>
								</tr>
							</c:if>
						</c:forEach>
						<c:forEach var="list" items="${messageList}" varStatus="num">
							<c:if test="${list.readyn==0}">
								<tr align="center">
									<td><input type="checkbox" name='delCheck'
										value="${list.messagenum }"></td>
									<td style="color: gray;">${list.send_id }</td>
									<td style="color: gray;"><a
										href="${contextPath }/message/detailMessage.do?messagenum=${list.messagenum}">${list.title }</a></td>
									<td style="color: gray;">${list.sendday }</td>
								</tr>
							</c:if>
						</c:forEach>
					</c:when>
				</c:choose>
			</table>
		</form>
		<button class="btn btn-default btn-round" type="button"
			onclick="delMessages()">
			<i class="material-icons">clear</i>&nbsp;&nbsp;삭제
		</button>
		<button class="btn btn-default btn-round" type="button"
			onclick="replyMessage()">
			<i class="material-icons">redo</i>&nbsp;&nbsp;답장
		</button>
	</div>
</body>
</html>