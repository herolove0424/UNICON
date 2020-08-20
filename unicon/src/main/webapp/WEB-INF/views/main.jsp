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
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" charset="utf-8"></script>
<script>
   $(document).ready(function() {
      pc_click();
      pc_board_click();
   });

   function pc_click() {
      $.ajax({
         type : 'get',
         url : "${contextPath}/info/popularlist.do?big_category=pc",
         success : function(result) {
            $("#pc_popularlist").html(result);
         }
      });
   }

   function mobile_click() {
      $.ajax({
         type : 'get',
         url : "${contextPath}/info/popularlist.do?big_category=mobile",
         success : function(result) {
            $("#mobile_popularlist").html(result);
         }
      });
   }

   function console_click() {
      $.ajax({
         type : 'get',
         url : "${contextPath}/info/popularlist.do?big_category=console",
         success : function(result) {
            $("#console_popularlist").html(result);
         }
      });
   }
   
   function pc_board_click() {
      $.ajax({
         type : 'get',
         url : "${contextPath}/board/pc_board.do",
         success : function(result) {
            $("#pc_board_list").html(result);
         }
      });
   }
   
   function mobile_board_click() {
      $.ajax({
         type : 'get',
         url : "${contextPath}/board/mobile_board.do",
         success : function(result) {
            $("#mobile_board_list").html(result);
         }
      });
   }
   
   function console_board_click() {
      $.ajax({
         type : 'get',
         url : "${contextPath}/board/console_board.do",
         success : function(result) {
            $("#console_board_list").html(result);
         }
      });
   }
   
   function free_board_click() {
      $.ajax({
         type : 'get',
         url : "${contextPath}/board/free_board.do",
         success : function(result) {
            $("#free_board_list").html(result);
         }
      });
   }
</script>
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
<style type="text/css">
.sans {
   font-family: 'Noto Sans KR', sans-serif;
}
</style>
<title>메인 페이지</title>
</head>
<jsp:include page="bootstrap/header.jsp" />
<body>
   <div id="carouselExampleIndicators" class="carousel slide"
      data-ride="carousel">
      <ol class="carousel-indicators">
         <li data-target="#carouselExampleIndicators" data-slide-to="0"
            class="active"></li>
         <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
         <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
         <!-- Slide One - Set the background image for this slide in the line below -->
         <div class="carousel-item active"
            style="background-image: url('${contextPath}/resources/img/uniconMain.png')">
            <div class="carousel-caption d-none d-md-block">
               <!-- <h3>First Slide</h3>
               <p>This is a description for the first slide.</p> -->
            </div>
         </div>
         <!-- Slide Two - Set the background image for this slide in the line below -->
         <div class="carousel-item"
            style="background-image: url('${contextPath}/resources/img/BATTLEGROUNDS.jpg')">
            <div class="carousel-caption d-none d-md-block">
               <h3>BATTLE GROUNDS</h3>
               <p>WINNER WINNER CHICKEN DINNER!</p>
            </div>
         </div>
         <!-- Slide Three - Set the background image for this slide in the line below -->
         <div class="carousel-item"
            style="background-image: url('${contextPath}/resources/img/Fifa_online4_1.png')">
            <div class="carousel-caption d-none d-md-block">
               <h3>FIFA</h3>
               <!-- <p>This is a description for the third slide.</p> -->
            </div>
         </div>
      </div>
      <a class="carousel-control-prev" href="#carouselExampleIndicators"
         role="button" data-slide="prev"> <span
         class="carousel-control-prev-icon" aria-hidden="true"></span> <span
         class="sr-only">Previous</span>
      </a> <a class="carousel-control-next" href="#carouselExampleIndicators"
         role="button" data-slide="next"> <span
         class="carousel-control-next-icon" aria-hidden="true"></span> <span
         class="sr-only">Next</span>
      </a>
   </div>
   <div class="container">
      <div id="nav-tabs">
         <div class="row">
            <div class="col-md-6">
               <h3 class="sans">
                  <b>실시간 인기 게임</b>
               </h3>
               <div class="card card-nav-tabs" style="margin-top:40px">
                  <div class="card-header card-header-success">
                     <div class="nav-tabs-navigation">
                        <div class="nav-tabs-wrapper">
                           <ul class="nav nav-tabs" data-tabs="tabs">
                              <li class="nav-item"><a class="nav-link active"
                                 href="#PC" data-toggle="tab" onclick="pc_click()"> <i
                                    class="material-icons">computer</i>PC
                              </a></li>
                              <li class="nav-item"><a class="nav-link" href="#Mobile"
                                 data-toggle="tab" onclick="mobile_click()"> <i
                                    class="material-icons">smartphone</i>Mobile
                              </a></li>
                              <li class="nav-item"><a class="nav-link" href="#Console"
                                 data-toggle="tab" onclick="console_click()"> <i
                                    class="material-icons">gamepad</i>Console
                              </a></li>
                           </ul>
                        </div>

                     </div>
                  </div>
                  <div class="card-body ">
                     <div class="tab-content text-center">
                        <div class="tab-pane active" id="PC">
                           <div id="pc_popularlist">
                              <jsp:include page="info/popularlist.jsp" />
                           </div>
                        </div>
                        <div class="tab-pane" id="Mobile">
                           <div id="mobile_popularlist">
                              <jsp:include page="info/popularlist.jsp" />
                           </div>
                        </div>
                        <div class="tab-pane" id="Console">
                           <div id="console_popularlist">
                              <jsp:include page="info/popularlist.jsp" />
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-6">
               <h3 class="sans">
                  <b>인기 게시글</b>
               </h3>
               <div class="card card-nav-tabs" style="margin-top:40px">
                  <div class="card-header card-header-success">
                     <div class="nav-tabs-navigation">
                        <div class="nav-tabs-wrapper">
                           <ul class="nav nav-tabs" data-tabs="tabs">
                              <li class="nav-item">
                                 <a class="nav-link active"
                                 href="#PC_board" data-toggle="tab" onclick="pc_board_click()">
                                    <i class="material-icons">computer</i>PC
                                 </a>
                              </li>
                              <li class="nav-item">
                                 <a class="nav-link" href="#Mobile_board"
                                 data-toggle="tab" onclick="mobile_board_click()">
                                    <i class="material-icons">smartphone</i>Mobile
                                 </a>
                              </li>
                              <li class="nav-item">
                                 <a class="nav-link" href="#Console_board"
                                 data-toggle="tab" onclick="console_board_click()">
                                    <i class="material-icons">gamepad</i>Console
                                 </a>
                              </li>
                              <li class="nav-item">
                                 <a class="nav-link" href="#Free_board"
                                 data-toggle="tab" onclick="free_board_click()">
                                    <i class="material-icons">comment</i>Free
                                 </a>
                              </li>
                           </ul>
                        </div>
                     </div>
                  </div>
                  <div class="card-body ">
                     <div class="tab-content text-center">
                        <div class="tab-pane active" id="PC_board">
                           <div id="pc_board_list">
                              <jsp:include page="board/pc_board.jsp" />
                           </div>
                        </div>
                        <div class="tab-pane" id="Mobile_board">
                           <div id="mobile_board_list">
                              <jsp:include page="board/mobile_board.jsp" />
                           </div>
                        </div>
                        <div class="tab-pane" id="Console_board">
                           <div id="console_board_list">
                              <jsp:include page="board/console_board.jsp"/>
                           </div>
                        </div>
                        <div class="tab-pane" id="Free_board">
                           <div id="free_board_list">
                              <jsp:include page="board/free_board.jsp" />
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</body>
<jsp:include page="bootstrap/footer.jsp" />
</html>