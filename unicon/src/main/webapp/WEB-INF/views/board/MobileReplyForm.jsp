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
<title>Insert title here</title>
</head>
<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
   rel="stylesheet" />

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
   href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<script>
function backToList(obj){
    obj.action="${contextPath}/board/Mobile_Board_AllList.do";
    obj.submit();
 }

 /* 댓글 등록하기(Ajax) */
 function fn_MobileReply(id) {
	 
	 if(id == null || id.length == "") {
		 alert("로그인 해주세요~")
		 location.href="${contextPath}/member/loginForm.do";
	 } else {
		 var form=document.frmMobileReply;
	     form.method="post";
	     form.action="${contextPath}/board/MobileAddReply.do";
	     form.submit();
	 }
	 
 }
 
 
 
</script>
<body>
<div class="container">
      <form name="frmMobileReply" method="post"
         action="${contextPath}/board/MobileAddReply.do">
         <table class="table">
            <tr align="center">
               <td colspan="3" style="vertical-align:middle;">
                  <input type="text" name="rep_content" style="width:80%; height:50px"
                  id="rep_content" placeholder="댓글을 입력해라">
                  <input type="hidden" name="rep_parentNO" value="${boardNO}">
                  <input class="btn btn-default btn-round" type="submit" value="답글 입력"
                  style="width:19%; height:50px"/>
               </td>
            </tr>
         </table>
      </form>
   </div>
</body>
</html>