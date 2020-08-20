<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#tag {
   font-size: 15px;
}
</style>
<meta charset="UTF-8">
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
<script>
function fn_loginCheck(id) {
	var idValue=id;
    if(${member.id == null}) {
       alert("로그인 후 이용해 주세요.");
       location.href='${contextPath}/member/loginForm.do';
    }
    else {
       location.href="${contextPath}/info/recommendlist.do?id="+idValue;
    }
}
</script>
<title>게임 목록</title>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
   <div class="main main-raised">
      <div class="section section-basic">
         <div class="container">
         <h1 class="title" align="center">Game List</h1>
            <div class="container" align="center">
               <nav class="navbar navbar-expand-lg bg-white" style="width: 22%">
                  <div class="container" align="center">
                     <form class="form-inline ml-auto" name="frmGameSearch" action="${contextPath}/info/gamesearch.do">
                        <div class="form-group">
                           <input type="text" class="form-control" placeholder="Search"
                           name="searchValue" value="${searchValue}"/>
                           <c:choose>
                              <c:when test="${small_category==null}">
                                 <input type="hidden" name="small_category" value="all">
                              </c:when>
                              <c:when test="${small_category != null}">
                                 <input type="hidden" name="small_category" value="${small_category}">
                              </c:when>
                           </c:choose>
                        </div>
                        <button type="submit" class="btn btn-white btn-just-icon btn-round">
                           <i class="material-icons">search</i>
                        </button>
                     </form>
                  </div>
               </nav>
            </div>
            <div class="container">
               <ul class="nav justify-content-center">
                  <li class="nav-item"><a class="nav-link active"
                     href="${contextPath}/info/gamelist.do">ALL</a></li>
                  <li class="nav-item"><a class="nav-link active"
                     href="${contextPath}/info/gamelist.do?small_category=PC">PC</a></li>
                  <li class="nav-item"><a class="nav-link active"
                     href="${contextPath}/info/gamelist.do?small_category=MOBILE">Mobile</a>
                  </li>
                  <li class="nav-item"><a class="nav-link active"
                     href="${contextPath}/info/gamelist.do?small_category=XBOX">Xbox</a>
                  </li>
                  <li class="nav-item"><a class="nav-link active"
                     href="${contextPath}/info/gamelist.do?small_category=PS4">PS4</a>
                  </li>
                  <li class="nav-item"><a class="nav-link active"
                     href="${contextPath}/info/gamelist.do?small_category=SWITCH">Nintendo</a>
                  </li>
               </ul>
            </div>
            <div class="container" align="center">
               <button class="btn btn-primary btn-round" style="width: 20%"
                  onclick="location.href='${contextPath}/info/gamerank.do'">
                  <i class="material-icons">trending_up</i>&nbsp;&nbsp;&nbsp;&nbsp;인기
                  게임 리스트
               </button>
               &nbsp;
               <button class="btn btn-primary btn-round" style="width: 20%"
                  onclick="fn_loginCheck('${member.id}')">
                  <i class="material-icons">favorite</i>&nbsp;&nbsp;&nbsp;&nbsp;추천
                  게임 리스트
               </button>
            </div>
            <br>
            <div class="container">
               <table class="table" style="align-content:center;">
                  <thead>
                     <tr align="center">
                        <td>#</td>
                        <td>게임명</td>
                        <td>게임 기본 정보</td>
                        <td>해시태그</td>
                        <td></td>
                     </tr>
                  </thead>
                  <tbody>
                     <c:choose>
                        <c:when test="${gamelist == null}">
                           <tr height="10">
                              <td colspan="5">
                                 <p align="center">
                                    <strong>
                                       <span style="font-size: 9pt;">등록된 글이 없습니다.</span>
                                    </strong>
                                 </p>
                              </td>
                           </tr>
                        </c:when>
                     </c:choose>
                  </tbody>
                  <c:forEach var="game" items="${gamelist}" varStatus="status">
                     <tbody>
                        <tr align="left">
                           <td align="center" style="vertical-align:middle;">
                              ${status.count}
                           </td>
                           <td align="center" style="vertical-align:middle;">
                              <a href="${contextPath}/info/gameview.do?game_code=${game.game_code}">${game.game_name}</a>                              
                           </td>
                           <td align="center" style="vertical-align:middle;">
                              장르 : ${game.genre}<br>
                              플랫폼 : ${game.small_category}<br>
                              배급사 : ${game.share_company}<br>
                           </td>
                           <td align="center" style="vertical-align:middle;">
                              <div class="container">
                                 <a href="${contextPath}/info/gamesearch.do?searchValue=${game.hash_tag}&small_category=all">#${game.hash_tag}</a><br>
                                 <a href="${contextPath}/info/gamesearch.do?searchValue=${game.hash_tag2}&small_category=all">#${game.hash_tag2}</a><br>
                                 <a href="${contextPath}/info/gamesearch.do?searchValue=${game.hash_tag3}&small_category=all">#${game.hash_tag3}</a>
                              </div>
                           </td>
                           <c:forEach var="logo" items="${logolist}">
                              <c:if test="${logo.game_code == game.game_code}">
                                 <td>
                                    <img src="${contextPath}/info/download.do?imagefilename=${logo.imagefilename}&game_code=${game.game_code}" style="width:100px; height:100px;"/>
                                 </td>
                              </c:if>
                           </c:forEach>
                        </tr>
                     </tbody>
                  </c:forEach>
               </table>
            </div>
         </div>
      </div>
   </div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>