<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 게임 리뷰 출력 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   function game_review_select() {
      var game = document.getElementById("game");
      var board = document.getElementById("board");
      if (board.style.display == "block") {
         board.style.display = "none";
         game.style.display = "block";
      } else if (game.style.display == "none") {
         game.style.display = "block";
      } else if (game.style.display == "block") {
         game.style.display = "none";
      }
   }
</script>
<!-- 게시판 댓글 출력 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   function board_review_select() {
      var game = document.getElementById("game");
      var board = document.getElementById("board");
      if (game.style.display == "block") {
         game.style.display = "none";
         board.style.display = "block";
      } else if (board.style.display == "none") {
         board.style.display = "block";
      } else if (board.style.display == "block") {
         board.style.display = "none";
      }
   }
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   function pc_board_select() {
      var pc = document.getElementById("pc");
      var mobile = document.getElementById("mobile");
      var console = document.getElementById("console");
      var free = document.getElementById("free");
      if (mobile.style.display == "block" || console.style.display == "block"
            || free.style.display == "block") {
         mobile.style.display = "none";
         console.style.display = "none";
         free.style.display = "none";
         pc.style.display = "block";
      } else if (pc.style.display == "none") {
         pc.style.display = "block";
      } else if (pc.style.display == "block") {
         pc.style.display = "none";
      }
   }
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   function mobile_board_select() {
      var pc = document.getElementById("pc");
      var mobile = document.getElementById("mobile");
      var console = document.getElementById("console");
      var free = document.getElementById("free");
      if (pc.style.display == "block" || console.style.display == "block"
            || free.style.display == "block") {
         pc.style.display = "none";
         console.style.display = "none";
         free.style.display = "none";
         mobile.style.display = "block";
      } else if (mobile.style.display == "none") {
         mobile.style.display = "block";
      } else if (pmobilec.style.display == "block") {
         mobile.style.display = "none";
      }
   }
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   function console_board_select() {
      var pc = document.getElementById("pc");
      var mobile = document.getElementById("mobile");
      var console = document.getElementById("console");
      var free = document.getElementById("free");
      if (mobile.style.display == "block" || pc.style.display == "block"
            || free.style.display == "block") {
         mobile.style.display = "none";
         pc.style.display = "none";
         free.style.display = "none";
         console.style.display = "block";
      } else if (console.style.display == "none") {
         console.style.display = "block";
      } else if (console.style.display == "block") {
         console.style.display = "none";
      }
   }
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
   function free_board_select() {
      var pc = document.getElementById("pc");
      var mobile = document.getElementById("mobile");
      var console = document.getElementById("console");
      var free = document.getElementById("free");
      if (mobile.style.display == "block" || console.style.display == "block"
            || pc.style.display == "block") {
         mobile.style.display = "none";
         console.style.display = "none";
         pc.style.display = "none";
         free.style.display = "block";
      } else if (free.style.display == "none") {
         free.style.display = "block";
      } else if (free.style.display == "block") {
         free.style.display = "none";
      }
   }
</script>
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

<title>댓글 관리</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" charset="utf-8"></script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
   <div class="main main-raised">
      <div class="section section-basic">
         <div class="container">
            <h1 class="title" align="center">댓글 관리 페이지</h1>
            <div class="container" align="center">
               <nav class="navbar navbar-expand-lg bg-white" style="width: 35%">
                  <div class="container" align="center">
                     <input type="button" id="game_review" class="btn btn-primary"
                        onclick="game_review_select()" value="게임 리뷰">&nbsp;&nbsp;&nbsp;
                     <input type="button" id="board_review" class="btn btn-primary"
                        onclick="board_review_select()" value="게시판 댓글">
                  </div>
               </nav>
            </div>
            <br> <br>
            <div id="game" style="display: none;">
               <div class="container" align="center">
                  <h2>게임 리뷰 관리</h2>
                  <table class="table" style="align-content: center;">
                     <thead>
                        <tr align="center">
                        <tr>
                           <td>플랫폼</td>
                           <td>게임명</td>
                           <td>내용</td>
                           <td>작성 일자</td>
                        </tr>

                     </thead>
                     <c:choose>
                        <c:when test="${reply.replylist == null}">
                           <tr height="10">
                              <td colspan="4">
                                 <p align="center">
                                    <strong><span style="font-size: 9pt;">등록된
                                          리뷰가 없습니다.</span></strong>
                                 </p>
                              </td>
                           </tr>
                        </c:when>
                     </c:choose>
                     <c:forEach var="reply" items="${reply.replylist}"
                        varStatus="status">
                        <tr align="left">
                           <td>${reply.SMALL_CATEGORY}</td>
                           <td><a
                              href="${contextPath}/info/gameview.do?game_code=${reply.GAME_CODE}">${reply.GAME_NAME}</a></td>
                           <td>${reply.CONTENT}</td>
                           <td>${reply.WRITEDATE}</td>
                        </tr>
                     </c:forEach>
                  </table>
               </div>
            </div>
            <div id="board" style="display: none;">
               <div class="container" align="center">
                  <table class="table" style="align-content: center;">
                     <div class="container" align="center">
                        <input type="button" id="pc_review" class="btn btn-primary"
                           onclick="pc_board_select()" value="PC게시판 댓글"> <input
                           type="button" id="mobile_review" class="btn btn-primary"
                           onclick="mobile_board_select()" value="모바일게시판 댓글"> <input
                           type="button" id="console_review" class="btn btn-primary"
                           onclick="console_board_select()" value="콘솔게시판 댓글"> <input
                           type="button" id="free_review" class="btn btn-primary"
                           onclick="free_board_select()" value="자유게시판 댓글">
                     </div>
                  </table>
                  <div id="pc" style="display: none;">
                     <div class="container" align="center">
                        <h2>pc게시판 댓글 관리</h2>
                        <table class="table" style="align-content: center;">
                           <thead>
                              <tr align="center">
                              <tr>
                                 <td>게시판 제목</td>
                                 <td>내용</td>
                                 <td>작성 일자</td>
                              </tr>

                           </thead>
                           <c:choose>
                              <c:when test="${pcboardReply == null}">
                                 <tr height="10">
                                    <td colspan="4">
                                       <p align="center">
                                          <strong><span style="font-size: 9pt;">등록된
                                                리뷰가 없습니다.</span></strong>
                                       </p>
                                    </td>
                                 </tr>
                              </c:when>
                           </c:choose>
                           <c:forEach var="p" items="${pcboardReply.pcboardReplylist}"
                              varStatus="status">
                              <tr align="left">
                                 <td><a
                                    href="${contextPath}/board/viewArticle2.do?boardNO=${p.REP_PARENTNO}">${p.TITLE}</td>
                                 <td>${p.REP_CONTENT}</td>
                                 <td>${p.REP_WRITEDATE}</td>
                              </tr>
                           </c:forEach>
                        </table>
                        </div>
                     </div>
                     <div id="mobile" style="display: none;">
                        <div class="container" align="center">
                           <h2>모바일게시판 댓글 관리</h2>
                           <table class="table" style="align-content: center;">
                              <thead>
                                 <tr align="center">
                                 <tr>
                                    <td>게시판 제목</td>
                                    <td>내용</td>
                                    <td>작성 일자</td>
                                 </tr>

                              </thead>
                              <c:choose>
                                 <c:when test="${mobileReply == null}">
                                    <tr height="10">
                                       <td colspan="4">
                                          <p align="center">
                                             <strong><span style="font-size: 9pt;">등록된
                                                   리뷰가 없습니다.</span></strong>
                                          </p>
                                       </td>
                                    </tr>
                                 </c:when>
                              </c:choose>
                              <c:forEach var="m" items="${mobileReply.mobileboardReplylist}"
                                 varStatus="status">
                                 <tr align="left">
                                    <td><a
                                       href="${contextPath}/board/MobileViewArticle.do?boardNO=${m.REP_PARENTNO}">${m.TITLE}</td>
                                    <td>${m.REP_CONTENT}</td>
                                    <td>${m.REP_WRITEDATE}</td>

                                 </tr>
                              </c:forEach>
                           </table>
                           </div>
                        </div>
                        <div id="console" style="display: none;">
                           <div class="container" align="center">
                              <h2>콘솔게시판 댓글 관리</h2>
                              <table class="table" style="align-content: center;">
                                 <thead>
                                    <tr align="center">
                                    <tr>
                                       <td>게시판 제목</td>
                                       <td>내용</td>
                                       <td>작성 일자</td>
                                    </tr>

                                 </thead>
                                 <c:choose>
                                    <c:when test="${consoleboardReply == null }">
                                       <tr height="10">
                                          <td colspan="4">
                                             <p align="center">
                                                <strong><span style="font-size: 9pt;">등록된
                                                      리뷰가 없습니다.</span></strong>
                                             </p>
                                          </td>
                                       </tr>
                                    </c:when>
                                 </c:choose>
                                 <c:forEach var="c"
                                    items="${consoleboardReply.consoleboardReplylist}"
                                    varStatus="status">
                                    <tr align="left">
                                       <td><a
                                          href="${contextPath}/board/ConsoleViewArticle.do?boardNO=${c.REP_PARENTNO}">${c.TITLE}</td>
                                       <td>${c.REP_CONTENT}</td>
                                       <td>${c.REP_WRITEDATE}</td>

                                    </tr>
                                 </c:forEach>
                              </table>
                              </div>
                           </div>
                           <div id="free" style="display: none;">
                              <div class="container" align="center">
                                 <h2>자유게시판 댓글 관리</h2>
                                 <table class="table" style="align-content: center;">
                                    <thead>
                                       <tr align="center">
                                       <tr>
                                          <td>게시판 제목</td>
                                          <td>내용</td>
                                          <td>작성 일자</td>
                                       </tr>

                                    </thead>
                                    <c:choose>
                                       <c:when test="${freeboardReply == null}">
                                          <tr height="10">
                                             <td colspan="4">
                                                <p align="center">
                                                   <strong><span style="font-size: 9pt;">등록된
                                                         리뷰가 없습니다.</span></strong>
                                                </p>
                                             </td>
                                          </tr>
                                       </c:when>
                                    </c:choose>
                                    <c:forEach var="f"
                                       items="${freeboardReply.freeboardReplylist}"
                                       varStatus="status">
                                       <tr align="left">
                                          <td><a
                                             href="${contextPath}/board/FreeViewArticle.do?boardNO=${f.REP_PARENTNO}">${f.TITLE}</td>
                                          <td>${f.REP_CONTENT}</td>
                                          <td>${f.REP_WRITEDATE}</td>
                                       </tr>
                                    </c:forEach>
                                 </table>
                                 </div>
                              </div>
                           </div>
                           <div class="footer text-center">
            <input type="button" class="btn btn-primary" onclick="location.href='${contextPath}/main.do'" value="메인페이지로 이동">
            <input type="button" class="btn btn-primary" onclick="location.href='${contextPath}/member/mypage.do'" value="마이페이지로 이동">
            </div>
            </div>
                        </div>
                     </div>
                  </div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>