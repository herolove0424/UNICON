<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" 
   isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
	rel="stylesheet" />

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>
   function fn_data(id) {
      var values = document.getElementsByName("game_code").length;      
      var codelist = new Array();
      var j = 0;
      
      for(var i=0; i<values; i++) {
         if(document.getElementsByName("game_code")[i].checked == true) {
            var votes = document.getElementsByName("game_code")[i].value;
            if(votes != null) {
               codelist[j] = votes;
               j = j + 1;
            }
         }
      }
      
      if(1 <= codelist.length && codelist.length <= 3) {
         var votesdata = {"codelist":codelist, "id":id};
         fn_votes(votesdata);
         alert("투표를 완료했습니다.");
         opener.parent.location.reload();
         window.close();
      }
      else
      {
         alert("게임을 최소 1개부터 최대 3개까지 선택해 주셔야 합니다.");
      }      
   }
   
   function fn_votes(votesdata) {
      jQuery.ajaxSettings.traditional = true;
      $.ajax({
         url : "${contextPath}/info/gamevotes.do",
         type : 'post',         
         data : votesdata
      });
   }
</script>
<meta charset="UTF-8">
<title>게임 투표 목록</title>
</head>
<body>
	<div class="main main-raised">
	<div class="section section-basic">
			<div class="container">
   <table class="table" align="center">
      <tr height="10" align="center" bgcolor="#333333">
         <td colspan="4"><h2 style="color:white">게임 투표 목록</h2></td>
      </tr>
      <c:choose>
         <c:when test="${gamevoteslist == null}">
            <tr height="10">
               <td colspan="4">
                  <p align="center">
                     <strong><span style="font-size: 9pt;">등록된 글이 없습니다.</span></strong>
                  </p>
               </td>
            </tr>
         </c:when>
      </c:choose>
      <c:forEach var="game" items="${gamevoteslist}" varStatus="status">
         <tr align="left">
            <td>
               <input type="checkbox" name="game_code" value="${game.game_code}">
            </td>
            <td>${game.game_name}</td>
            <td>
               장르 : ${game.genre}<br>
               플랫폼 : ${game.small_category}<br>
               배급사 : ${game.share_company}<br>
            </td>
            <td>
               <img src="${contextPath}/resources/image/logo/${game.game_code}.jpg" style="width:300px;"/>
            </td>
         </tr>
      </c:forEach>
   </table>
   <div align="center">
      <input type="button" value="투표" class="btn btn-default btn-round" onclick="fn_data('${member.id}')">&nbsp;&nbsp;
      <input type="button" value="취소" class="btn btn-default btn-round" onclick="window.close()">
   </div>
   </div>
   </div>
   </div>
</body>
</html>