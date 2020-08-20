<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
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
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<script>
   //   페이지 로딩 시 댓글 목록 출력
   $(document).ready(function() {
      reviewlist();      
   });
   
   //   댓글 입력 기능
   function fn_insertReview() {
      if(${member.id == null}) {
         alert("로그인 후 댓글 입력이 가능합니다.");
         return;
      }
      else  
      {
         //   알림창 출력 후 확인 / 취소 선택      
         if(confirm("댓글 등록 후 수정이 불가능 합니다.\n등록하시겠습니까?") == true) {
        	 if(document.frmInsertReview.score.value=="") {
                 alert("별점을 설정해주세요.");
                 return;
             }
            //   확인 선택시 댓글 입력
            alert("등록되었습니다.");
            //   frmInsertReview의 내부 값 입력
            var insertData = $('[name=frmInsertReview]').serialize();
            //   insertReview 함수 호출
             insertReview(insertData);
            //   페이지 새로고침
             location.reload();
         }
         //   취소 선택시 돌아가기   
         else
         {
            return;
         }
      }
   }
   
   //   댓글 입력 기능
   function insertReview(insertData){
      $.ajax({
         url : "${contextPath}/review/insertReview.do",
         type : 'post',
         data : insertData,
         success : function(data){
            alert("성공");
         }
      });      
   }
   
   //   댓글 목록 출력
   function reviewlist() {
      $.ajax({
         type:'get',
         url:"${contextPath}/review/reviewlist.do?game_code=${info_VO.game_code}",         
         success:function(result) {
            $("#reviewlist").html(result);
         }
      });
   }
   
   //   새로고침 기능
   function refresh() {
      location.reload();
   }
   
   function jjimclick(){
      if(${member.id == null}) {
         alert("로그인 후 사용 가능한 서비스입니다.");
         return;
      }
      else {
         $.ajax({
              url:'${contextPath}/member/jjim.do',
              type:'post',
              data:$('#gameview').serialize(),
              success:function(data){
                 
              },
              error:function(){
                 alert("에러입니다");   
              }
          });
      }
       
   }
   
   function div_control(value) {
	   var status = value;
	   var content = document.getElementById("content");
	   var movie = document.getElementById("movie");
	   var image = document.getElementById("image");
	   
	   if(status == "content") {
		   movie.style.display = "none";
		   image.style.display = "none";
		   content.style.display = "block";
	   }
	   else if(status == "movie") {
		   image.style.display = "none";
		   content.style.display = "none";
		   movie.style.display = "block";
	   }
	   else if(status == "image") {
		   content.style.display = "none";
		   movie.style.display = "none";
		   image.style.display = "block";
	   }
   }   
</script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
<title>게임 상세 정보</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" charset="utf-8"></script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
	<div class="main main-raised">
		<div class="section section-basic">
			<form name="gameview" id="gameview">
				<div class="container">
					<input type="hidden" name="jjim" value="${jjim}"> <input
						type="hidden" name="game_name" value="${info_VO.game_name}">
					<input type="hidden" name="small_category"
						value="${info_VO.small_category}"> <input type="hidden"
						name="game_code" value="${info_VO.game_code}"> <input
						type="hidden" name="id" value="${member.id}">
					<h1>${info_VO.game_name}</h1>
					<h4>
						<a
							href="${contextPath}/info/gamesearch.do?searchValue=${info_VO.hash_tag}&small_category=all">#${info_VO.hash_tag}</a>&nbsp;
						<a
							href="${contextPath}/info/gamesearch.do?searchValue=${info_VO.hash_tag2}&small_category=all">#${info_VO.hash_tag2}</a>&nbsp;
						<a
							href="${contextPath}/info/gamesearch.do?searchValue=${info_VO.hash_tag3}&small_category=all">#${info_VO.hash_tag3}</a>
					</h4>
					<c:if test="${member.id==null}">
						<button class="btn btn-default btn-round" onclick="jjimclick()">
							<i class="fa fa-heart-o" style="font-size: 20px; color: green"></i>
						</button>
					</c:if>
					<c:if test="${jjim==1}">
						<button class="btn btn-default btn-round" onclick="jjimclick()">
							<i class="fa fa-heart" style="font-size: 20px; color: green"></i>
						</button>
					</c:if>
					<c:if test="${jjim ==0}">
						<button class="btn btn-default btn-round" onclick="jjimclick()">
							<i class="fa fa-heart-o" style="font-size: 20px; color: #A6A6A6"></i>
						</button>
					</c:if>
				</div>
				<c:set var="category" value="${info_VO.small_category}" />
				<c:if test="${category eq'MOBILE'}">
					<div class="container">
					<a href="${info_VO.link_1}">공식 사이트</a>&nbsp;&nbsp;&nbsp;<a href="${info_VO.link_3}">Android</a>&nbsp;&nbsp;&nbsp;<a href="${info_VO.link_4}">apple</a><br>
					플랫폼 : ${info_VO.small_category}<br> 장르 : ${info_VO.genre}<br>
					제작사 : <a href="${info_VO.link_3}">${info_VO.menufacture}</a><br>
					배급사 : ${info_VO.share_company}<br> 출시일자 :
					<fmt:formatDate value='${info_VO.release_date}'
						pattern='YYYY-MM-dd' />
					<br>
				</div>
				</c:if>
				
				<c:if test="${category ne'MOBILE'}">
				<div class="container">
					<a href="${info_VO.link_1}">공식 사이트</a><br>
					플랫폼 : ${info_VO.small_category}<br> 장르 : ${info_VO.genre}<br>
					제작사 : <a href="${info_VO.link_3}">${info_VO.menufacture}</a><br>
					배급사 : ${info_VO.share_company}<br> 출시일자 :
					<fmt:formatDate value='${info_VO.release_date}'
						pattern='YYYY-MM-dd' />
					<br>
				</div>
				
				</c:if>
				
				<div class="container" align="center">
					<button class="btn btn-default btn-round" style="width: 32%"
						onclick="div_control('content')">
						<i class="material-icons">list</i>&nbsp;상세 설명
					</button>
					<button type="button" class="btn btn-default btn-round"
						style="width: 32%" onclick="div_control('movie')">
						<i class="material-icons">videocam</i>&nbsp;공식 영상
					</button>
					<button type="button" class="btn btn-default btn-round"
						style="width: 32%" onclick="div_control('image')">
						<i class="material-icons">photo_camera</i>&nbsp;스틸컷 이미지
					</button>
				</div>
				<div class="container" id="content" style="display:block;"
					align="center">
					<h3>상세 설명</h3>
					${info_VO.content}
				</div>
				<div class="container" id="movie" style="display: none"
					align="center">
					<h3>공식 영상</h3>
					${info_VO.link_2}
				</div>
				<div class="container" id="image" style="display: none"
					align="center">
					<h3>스틸컷 이미지</h3>
					<div class="row">
						<div class="col-md-8 mr-auto ml-auto">
							<!-- Carousel Card -->
							<div class="card card-raised card-carousel">
								<div id="carouselExampleIndicators" class="carousel slide"
									data-ride="carousel" data-interval="3000">
									<ol class="carousel-indicators">
										<li data-target="#carouselExampleIndicators" data-slide-to="0"
											class="active"></li>
										<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
										<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
										<li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
									</ol>
									<div class="carousel-inner">
										<div class="carousel-item active">
											<img class="d-block w-100" src="${contextPath}/resources/game/${info_VO.game_code}/${logo.imagefilename}"
												alt="${info_VO.game_name }로고">
											<div class="carousel-caption d-none d-md-block">
											</div>
										</div>
										<c:forEach items="${image}" var="image">
										<div class="carousel-item">
											<img class="d-block w-100" src="${contextPath}/resources/game/${info_VO.game_code}/${image.imagefilename}"
												alt="${info_VO.game_name }">
											<div class="carousel-caption d-none d-md-block">
											</div>
										</div>
										</c:forEach>
									</div>
									<a class="carousel-control-prev"
										href="#carouselExampleIndicators" role="button"
										data-slide="prev"> <i class="material-icons">keyboard_arrow_left</i>
										<span class="sr-only">Previous</span>
									</a> <a class="carousel-control-next"
										href="#carouselExampleIndicators" role="button"
										data-slide="next"> <i class="material-icons">keyboard_arrow_right</i>
										<span class="sr-only">Next</span>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
			<form name="frmInsertReview">
				<div class="container" style="margin-top: 35px;" align="center">
					<select name="score" id="score"
						style="width: 15%; height: 50px; text-align-last: center;">
						<option value=''>----별점----</option>
						<option value=1>★</option>
						<option value=2>★★</option>
						<option value=3>★★★</option>
						<option value=4>★★★★</option>
						<option value=5>★★★★★</option>
					</select> <input type="hidden" name="game_code" value="${info_VO.game_code}">
					<input type="text" id="content" name="content"
						style="width: 65%; height: 50px"> <input type="hidden"
						name="id" value="${member.id}"> <input type="button"
						class="btn btn-default btn-round" id="insertReviewBtn"
						style="width: 15%; height: 50px" value="댓글 등록"
						onclick="fn_insertReview()">
				</div>
			</form>
			<jsp:include page="../review/reviewlist.jsp" />
			<div class="container">
				<div id="reviewlist" align="center"></div>
			</div>
		</div>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html> --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<head>
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
<script type="text/javascript"
   src="http://code.jquery.com/jquery-latest.js"></script>
<script>
   //   페이지 로딩 시 댓글 목록 출력
   $(document).ready(function() {
      reviewlist();      
   });
   
   //   댓글 입력 기능
   function fn_insertReview() {
      if(${member.id == null}) {
         alert("로그인 후 댓글 입력이 가능합니다.");
         return;
      }
      else  
      {
         //   알림창 출력 후 확인 / 취소 선택      
         if(confirm("댓글 등록 후 수정이 불가능 합니다.\n등록하시겠습니까?") == true) {
            if(document.frmInsertReview.score.value=="") {
                 alert("별점을 설정해주세요.");
                 return;
             }
            //   확인 선택시 댓글 입력
            alert("등록되었습니다.");
            //   frmInsertReview의 내부 값 입력
            var insertData = $('[name=frmInsertReview]').serialize();
            //   insertReview 함수 호출
             insertReview(insertData);
            //   페이지 새로고침
             location.reload();
         }
         //   취소 선택시 돌아가기   
         else
         {
            return;
         }
      }
   }
   
   //   댓글 입력 기능
   function insertReview(insertData){
      $.ajax({
         url : "${contextPath}/review/insertReview.do",
         type : 'post',
         data : insertData,
         success : function(data){
            alert("성공");
         }
      });      
   }
   
   //   댓글 목록 출력
   function reviewlist() {
      $.ajax({
         type:'get',
         url:"${contextPath}/review/reviewlist.do?game_code=${info_VO.game_code}",         
         success:function(result) {
            $("#reviewlist").html(result);
         }
      });
   }
   
   //   새로고침 기능
   function refresh() {
      location.reload();
   }
   
   function jjimclick(){
      if(${member.id == null}) {
         alert("로그인 후 사용 가능한 서비스입니다.");
         return;
      }
      else {
         $.ajax({
              url:'${contextPath}/member/jjim.do',
              type:'post',
              data:$('#gameview').serialize(),
              success:function(data){
                 
              },
              error:function(){
                 alert("에러입니다");   
              }
          });
      }
       
   }
   
   function div_control(value) {
      var status = value;
      var content = document.getElementById("content");
      var movie = document.getElementById("movie");
      var image = document.getElementById("image");
      
      if(status == "content") {
         movie.style.display = "none";
         image.style.display = "none";
         content.style.display = "block";
      }
      else if(status == "movie") {
         image.style.display = "none";
         content.style.display = "none";
         movie.style.display = "block";
      }
      else if(status == "image") {
         content.style.display = "none";
         movie.style.display = "none";
         image.style.display = "block";
      }
   }   
</script>
<script type="text/javascript"
   src="http://code.jquery.com/jquery-latest.js"></script>
<title>게임 상세 정보</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" charset="utf-8"></script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
   <div class="main main-raised">
      <div class="section section-basic">
         <form name="gameview" id="gameview">
            <div class="container">
               <input type="hidden" name="jjim" value="${jjim}"> <input
                  type="hidden" name="game_name" value="${info_VO.game_name}">
               <input type="hidden" name="small_category"
                  value="${info_VO.small_category}"> <input type="hidden"
                  name="game_code" value="${info_VO.game_code}"> <input
                  type="hidden" name="id" value="${member.id}">
               <h1>${info_VO.game_name}</h1>
               <h4>
                  <a
                     href="${contextPath}/info/gamesearch.do?searchValue=${info_VO.hash_tag}&small_category=all">#${info_VO.hash_tag}</a>&nbsp;
                  <a
                     href="${contextPath}/info/gamesearch.do?searchValue=${info_VO.hash_tag2}&small_category=all">#${info_VO.hash_tag2}</a>&nbsp;
                  <a
                     href="${contextPath}/info/gamesearch.do?searchValue=${info_VO.hash_tag3}&small_category=all">#${info_VO.hash_tag3}</a>
               </h4>
               <c:if test="${member.id==null}">
                  <button class="btn btn-default btn-round" onclick="jjimclick()">
                     <i class="fa fa-heart-o" style="font-size: 20px; color: green"></i>
                  </button>
               </c:if>
               <c:if test="${jjim==1}">
                  <button class="btn btn-default btn-round" onclick="jjimclick()">
                     <i class="fa fa-heart" style="font-size: 20px; color: green"></i>
                  </button>
               </c:if>
               <c:if test="${jjim ==0}">
                  <button class="btn btn-default btn-round" onclick="jjimclick()">
                     <i class="fa fa-heart-o" style="font-size: 20px; color: #A6A6A6"></i>
                  </button>
               </c:if>
            </div>
            <c:set var="category" value="${info_VO.small_category}" />
				<c:if test="${category eq'MOBILE'}">
					<div class="container">
					<a href="${info_VO.link_1}">공식 사이트</a>&nbsp;&nbsp;&nbsp;<a href="${info_VO.link_3}">Android</a>&nbsp;&nbsp;&nbsp;<a href="${info_VO.link_4}">apple</a><br>
					플랫폼 : ${info_VO.small_category}<br> 장르 : ${info_VO.genre}<br>
					제작사 : <a href="${info_VO.link_3}">${info_VO.menufacture}</a><br>
					배급사 : ${info_VO.share_company}<br> 출시일자 :
					<fmt:formatDate value='${info_VO.release_date}'
						pattern='YYYY-MM-dd' />
					<br>
				</div>
				</c:if>
				
				<c:if test="${category ne'MOBILE'}">
				<div class="container">
					<a href="${info_VO.link_1}">공식 사이트</a><br>
					플랫폼 : ${info_VO.small_category}<br> 장르 : ${info_VO.genre}<br>
					제작사 : <a href="${info_VO.link_3}">${info_VO.menufacture}</a><br>
					배급사 : ${info_VO.share_company}<br> 출시일자 :
					<fmt:formatDate value='${info_VO.release_date}'
						pattern='YYYY-MM-dd' />
					<br>
				</div>
				
				</c:if>
            <div class="container" align="center">
               <button class="btn btn-default btn-round" style="width: 32%"
                  onclick="div_control('content')">
                  <i class="material-icons">list</i>&nbsp;상세 설명
               </button>
               <button type="button" class="btn btn-default btn-round"
                  style="width: 32%" onclick="div_control('movie')">
                  <i class="material-icons">videocam</i>&nbsp;공식 영상
               </button>
               <button type="button" class="btn btn-default btn-round"
                  style="width: 32%" onclick="div_control('image')">
                  <i class="material-icons">photo_camera</i>&nbsp;스틸컷 이미지
               </button>
            </div>
            <div class="container" id="content" style="display:block;"
               align="center">
               <h3>상세 설명</h3>
               ${info_VO.content}
            </div>
            <div class="container" id="movie" style="display: none"
               align="center">
               <h3>공식 영상</h3>
               ${info_VO.link_2}
            </div>
            <div class="container" id="image" style="display:none" align="center">
               <h3>스틸컷 이미지</h3>
               <div class="row">
                  <div class="col-md-8 mr-auto ml-auto">
                     <!-- Carousel Card -->
                     <div class="card card-raised card-carousel">
                        <div id="carouselExampleIndicators" class="carousel slide"
                           data-ride="carousel" data-interval="3000" style="height:auto;">
                           <ol class="carousel-indicators">
                              <li data-target="#carouselExampleIndicators" data-slide-to="0"
                                 class="active"></li>
                              <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                              <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                              <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
                           </ol>
                           <div class="carousel-inner">
                              <div class="carousel-item active" style="height:auto;">
                                 <img class="d-block w-100" src="${contextPath}/info/download.do?imagefilename=${logo.imagefilename}&game_code=${info_VO.game_code}"
                                    alt="First slide">
                              </div>
                              <c:forEach var="image" items="${imagelist}">
                                 <div class="carousel-item" style="height:auto;">
                                    <img class="d-block w-100" src="${contextPath}/info/download.do?imagefilename=${image.imagefilename}&game_code=${info_VO.game_code}"
                                       alt="Third slide">
                                 </div>
                              </c:forEach>
                           </div>
                           <a class="carousel-control-prev"
                              href="#carouselExampleIndicators" role="button"
                              data-slide="prev"> <i class="material-icons">keyboard_arrow_left</i>
                              <span class="sr-only">Previous</span>
                           </a> <a class="carousel-control-next"
                              href="#carouselExampleIndicators" role="button"
                              data-slide="next"> <i class="material-icons">keyboard_arrow_right</i>
                              <span class="sr-only">Next</span>
                           </a>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </form>
         <form name="frmInsertReview">
            <div class="container" style="margin-top: 35px;" align="center">
               <select name="score" id="score"
                  style="width: 15%; height: 50px; text-align-last: center;">
                  <option value=''>----별점----</option>
                  <option value=1>★</option>
                  <option value=2>★★</option>
                  <option value=3>★★★</option>
                  <option value=4>★★★★</option>
                  <option value=5>★★★★★</option>
               </select> <input type="hidden" name="game_code" value="${info_VO.game_code}">
               <input type="text" id="content" name="content"
                  style="width: 65%; height: 50px"> <input type="hidden"
                  name="id" value="${member.id}"> <input type="button"
                  class="btn btn-default btn-round" id="insertReviewBtn"
                  style="width: 15%; height: 50px" value="댓글 등록"
                  onclick="fn_insertReview()">
            </div>
         </form>
         <jsp:include page="../review/reviewlist.jsp" />
         <div class="container">
            <div id="reviewlist" align="center"></div>
         </div>
      </div>
   </div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>