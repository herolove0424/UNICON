<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 변경</title>
</head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function fn_change() {
		
		var frmChange = document.change;
		var id = frmChange.id.value;
		var email = frmChange.email.value;
		
		$.ajax({
			url : "${contextPath}/member/changeEmail.do",
			type : 'post',
			data : {"id" : id, "email" : email},
			success : function(data){
				alert("이메일 변경되었습니다. 재전송을 눌러주세요.");
				window.close();
			}
		});	
		
	}
</script>
<body>
<h3>이메일 입력</h3>
      <form name="change">
         <table style="align:center">
            <tr>
               <td>아이디 : </td>
               <td>${id}</td>
            </tr>
            <tr>
            	<td>이메일 : </td>
            	<td><input type="text" name="email" id="email"/></td>
            </tr>
         </table>
         <input type="hidden" name ="id" id="id" value="${id}">
         <br>
         <div align="center">
         <input type="button" value="확인" onclick="fn_change();">
         </div> 
      </form>
</body>
</html>