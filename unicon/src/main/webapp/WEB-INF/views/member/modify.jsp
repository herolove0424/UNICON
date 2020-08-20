<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="same" />
<%
   request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
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
<style type="text/css">
#tag {
	font-size: 15px;
}
</style>
<title>마이페이지</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
function Formcheck() {
   
   var Fomcheck = document.modify;
   var formemail = Fomcheck.email.value;
   var formphone_number = Fomcheck.phone_number.value;
   var formnickname = Fomcheck.nickname.value;   
   var formgenre = [];
   $("input:checkbox[name=genre]:checked").each(function () {
      formgenre.push($(this).val());
   });
   var formhach_tag = [];
   $("input:checkbox[name=hash_tag]:checked").each(function () {
      formhach_tag.push($(this).val());
   });
   
   var show = document.getElementById("div_recommend");
   if(same=='true'){
         alert("입력값을 확인해주세요");
   }else if (formemail.length ==0 || formemail=="") {
      alert("이메일을 입력해주세요");
   }else if (formphone_number.length ==0 || formphone_number=="") {
      alert("전화번호를 입력해주세요");
   }else if (formnickname.length ==0 || formnickname=="") {
      alert("닉네임을 입력해주세요");
   }else {
      if(show.style.display=="block") {
         if($("input:radio[name=play_type]").is(":checked") != true) {
         alert("플레이어 타입을 선택해 주세요");
         }
         else if($("input:checkbox[name=genre]").is(":checked") != true)
         {
            alert("장르를 선택해 주세요");
         }
         else if($("input:checkbox[name=hash_tag]").is(":checked") != true)
         {
         alert("해시태그를 선택해 주세요");
         }
         else if($("input:radio[name=small_category]").is(":checked") != true)
         {
            alert("플랫폼을 선택해 주세요");
         }
         else
         {            
            Fomcheck.method= "post";
            Fomcheck.action="${contextPath}/member/modima2.do";
            Fomcheck.submit();
            alert("수정이 완료되었습니다.\n다시 로그인 해주세요.");
         }
      }
      else
      {
         Fomcheck.method= "post";
         Fomcheck.action="${contextPath}/member/modima2.do";
         Fomcheck.submit();
         alert("수정이 완료되었습니다.\n다시 로그인 해주세요.");
      }
   }
}
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function email1(){
    var email = ($('#email').val)();
    $.ajax({
        url:'${contextPath}/member/overlappedemail.do',
        type:'post',
        data:{email:email},
        success:function(data){
           if($.trim(data)==0){
              if(email ==""){
                 same='true';  
              }else {
                 $("#email_div").attr('class','form-group label-floating has-success');
                  $("#email").attr('data-content','사용 가능한 E-Mail입니다');
                  $('#email').popover('show');
                  $("#email_clear").hide();
                  $("#email_done").show();
                  same='false';
              }
            }else{
               if(email == '${email5}'){
                $("#email_div").attr('class','form-group label-floating has-success');
                $("#email").attr('data-content','이메일이  일치합니다"');
                $('#email').popover('show');
                $("#email_done").hide();
                $("#email_clear").show(); 
                same='false';
               } else {
                  $("#email_div").attr('class','form-group label-floating has-danger');
                    $("#email").attr('data-content','E-Mail이 중복되었습니다');
                    $('#email').popover('show');
                    $("#email_done").hide();
                    $("#email_clear").show();            
                    same='true';
            }
            }
        },
        error:function(){
           alert("에러입니다");   
        }
    });
};
</script>
<!--전화번호 정규식 -->
<script>
$(document).on("keyup", "#phone", function() {$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") ); });
</script>
<!--전화번호 중복체크 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function phone1(){
    var phone = ($('#phone').val)();
      var phone_number = phone.replace(/-/g,"");
    $.ajax({
        url:'${contextPath}/member/overlappedphone.do',
        type:'post',
        data:{phone_number:phone_number},
        success:function(data){
           if($.trim(data)==0){
              if(phone_number ==""){
                 $('#chkMsgpho').html(" ");
                 same='true';
              }else{
                 $("#phone_div").attr('class','form-group label-floating has-success');
                  $("#phone").attr('data-content','사용 가능한 번호입니다');
                  $('#phone').popover('show');
                  $("#phone_clear").hide();
                  $("#phone_done").show();
                  same='false';
              }
            }else{
               if(phone_number == '${phone5}'){
                $("#phone_div").attr('class','form-group label-floating has-success');
                $("#phone").attr('data-content','번호가 일치합니다');
                $('#phone').popover('show');
                $("#phone_done").hide();
                $("#phone_clear").show();
                same='false';
               }else {
                   $("#phone_div").attr('class','form-group label-floating has-danger');
                     $("#phone").attr('data-content','번호가 중복되었습니다');
                     $('#phone').popover('show');
                     $("#phone_done").hide();
                     $("#phone_clear").show();
                     same='true';
               }
            }
        },
        error:function(){
           alert("에러입니다");   
        }
    });
};
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function checkNickname(){
    var nickname = ($('#nickname').val)();
    $.ajax({
        url:'${contextPath}/member/overlappednick.do',
        type:'post',
        data:{nickname:nickname},
        success:function(data){
           if($.trim(data)==0){
              if(nickname ==""){
                 $('#chkMsgnic').html(" ");
                 same='true';
              }else if(nickname.length < 2 || nickname.length > 12){
                 $("#nickname_div").attr('class','form-group label-floating has-danger');
                  $("#nickname").attr('data-content','2~12자리로 입력하세요');
                  $('#nickname').popover('show');
                  $("#nickname_done").hide();
                  $("#nickname_clear").show();
                  same='true';
              }else{
                   $("#nickname_div").attr('class','form-group label-floating has-success');
                   $("#nickname").attr('data-content','사용가능한 닉네임 입니다');
                   $('#nickname').popover('show');
                   $("#nickname_clear").hide();
                   $("#nickname_done").show();
                   same='false';
              }
            }else{ 
               if(nickname =='${nickname5}') {
          
                $("#nickname_div").attr('class','form-group label-floating has-success');
                $("#nickname").attr('data-content','닉네임이 일치합니다');
                $('#nickname').popover('show');
                $("#nickname_clear").hide();
                $("#nickname_done").show();               
                same='false';
                } else {
                   $("#nickname_div").attr('class','form-group label-floating has-success');
                    $("#nickname").attr('data-content','사용 가능한 닉네임입니다.');
                    $('#nickname').popover('show');
                    $("#nickname_clear").hide();
                    $("#nickname_done").show();               
                    same='false';
                }
           }
        },
        error:function(){
           alert("에러입니다");   
        }
    });
};
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
 function readURL(input) {
    document.getElementById("fileName").value = input.value.replace("C:\\fakepath\\", "");    
         if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
               $('#preview').attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
         }
 }
</script>
<!-- 게임 추천 버튼 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function game_type_select() {
   var show = document.getElementById("div_recommend");
   if(show.style.display=="none") {
      $("input:radio[name=play_type]").attr("checked",false);
      $("input:checkbox[name=genre]").attr("checked",false);   
      $("input:checkbox[name=hash_tag]").attr("checked",false);
      $("input:radio[name=small_category]").attr("checked",false);
      show.style.display ="block";
   }
   else
   {
      show.style.display="none";
   }
}
</script>
<!-- 장르 체크박스 제한 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
var maxcheck = 2;
var check = 0;
var genre = document.getElementByName("genre");

function countcheck(genre) {
   if(genre.checked) {
      check += 1; 
   }
   else
   {
      check -= 1;
   }
   
   if(check > maxcheck) {
      alert("장르는 2개까지 선택이 가능합니다.")
      genre.checked = false;
      check -= 1;
   }
}
</script>
<!-- 해쉬태그 체크박스 제한 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
var maxcheck2 = 3;
var check2 = 0;
var hash_tag = document.getElementById("#hash_tag");

function countcheck2(hash_tag) {
   if(hash_tag.checked) {
      check2 += 1; 
   }
   else
   {
      check2 -= 1;
   }
   
   if(check2 > maxcheck2) {
      alert("해쉬태그는 3개까지 선택이 가능합니다.")
      hash_tag.checked = false;
      check2 -= 1;
   }
}
</script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>

   <div class="main main-raised">
      <div class="section section-basic">
               <form name="modify" enctype="multipart/form-data">
               <div class="container">
                     <h1 class="sans" align="center">${member.nickname}님의 마이페이지 수정</h1>
                  </div>
                  <div class="col-md-12">
                     <c:choose>
                        <c:when
                           test="${empty member.imageFileName || member.imageFileName == 'null' }">
                           <div class="col-sm-2">
                              <label for="disabledTextInput">프로필 사진</label> <img
                                 src="${contextPath}/resources/img/man.png" alt="Raised Image"
                                 class="img-raised rounded img-fluid" id="preview"> <input
                                 type="file" name="i_imageFileName" id="i_imageFileName"
                                 onchange="readURL(this);" />
                           </div>
                        </c:when>
                        <c:otherwise>
                           <div class="col-sm-2">
                              <label for="disabledTextInput">프로필 사진</label> <input
                                 type="hidden" name="originalFileName"
                                 value="${member.imageFileName}" /> <img
                                 src="${contextPath}/resources/memberimage/${member.id }/${member.imageFileName}"
                                 alt="Raised Image" id="preview"
                                 class="img-raised rounded img-fluid"> <input
                                 type="file" name="i_imageFileName" id="i_imageFileName"
                                 onchange="readURL(this);" />
                           </div>
                        </c:otherwise>
                     </c:choose>
                     <input type="hidden" name="fileName" id="fileName" />

                     <div class="col-md-12">
                        <div class="form-group">
                           <label for="id">아이디</label> <input type="text" name="id"
                              id="id" class="form-control" value="${member.id}" readonly>
                        </div>
                        <div class="form-group">
                           <label for="disabledTextInput">이름</label> <input type="text"
                              id="name" class="form-control" value="${member.name}" readonly>
                        </div>
                        <div class="form-group">
                           <label for="disabledTextInput">생년</label> <input type="text"
                              id="birthday" class="form-control" value="${member.birthday}"
                              readonly>
                        </div>
                        <div class="form-group" id="email_div">
                           <label for="email">E-Mail</label> <input type="text"
                              class="form-control" id="email" name="email"
                              value="${member.email}" oninput="email1()"
                              data-container="body" data-toggle="popover"
                              data-placement="right" data-content="">
                           <div id="email_done" style="display: none">
                              <span class="form-control-feedback"> <i
                                 class="material-icons">done</i>
                              </span>
                           </div>
                           <div id="email_clear" style="display: none">
                              <span class="form-control-feedback"> <i
                                 class="material-icons">clear</i>
                              </span>
                           </div>
                        </div>
                        <div class="form-group" id="phone_div">
                           <label for="phone">Phone</label> <input type="text"
                              class="form-control" id="phone_number" name="phone_number"
                              value="${member.phone_number}" oninput="phone1()"
                              data-container="body" data-toggle="popover"
                              data-placement="right" data-content="" maxlength="13">
                           <div id="phone_done" style="display: none">
                              <span class="form-control-feedback"> <i
                                 class="material-icons">done</i>
                              </span>
                           </div>
                           <div id="phone_clear" style="display: none">
                              <span class="form-control-feedback"> <i
                                 class="material-icons">clear</i>
                              </span>
                           </div>
                        </div>
                        <div class="form-group" id="nickname_div">
                           <label for="nickname">NickName</label> <input type="text"
                              class="form-control" id="nickname" name="nickname"
                              value="${member.nickname}" oninput="checkNickname()"
                              data-container="body" data-toggle="popover"
                              data-placement="right" data-content="">
                           <div id="nickname_done" style="display: none">
                              <span class="form-control-feedback"> <i
                                 class="material-icons">done</i>
                              </span>
                           </div>
                           <div id="nickname_clear" style="display: none">
                              <span class="form-control-feedback"> <i
                                 class="material-icons">clear</i>
                              </span>
                           </div>
                        </div>
                        <div class="form-group">
                           <label for="disabledTextInput">성별</label> <input type="text"
                              id="sex" class="form-control" value="${member.sex}" readonly>
                        </div>
                        <div class="form-group" align="center">
                        <label>Game Recommend</label>
                        <input type="button" class="btn btn-primary" value="Open"
                        id="recommend" onclick="game_type_select()"
                        style="width:98%">   
                     </div>
                     <div class="form-group" id="div_recommend" style="display:none">
                        <label>Play Type</label>   
                           <div class="form-group">                  
                              <div class="form-check form-check-inline">
                                 <label class="form-check-label">
                                    <input class="form-check-input" type="radio" 
                                    name="play_type" value="싱글">Single
                                    <span class="circle">
                                          <span class="check"></span>
                                    </span>
                                 </label>
                              </div>
                              <div class="form-check form-check-inline">
                                 <label class="form-check-label">
                                    <input class="form-check-input" type="radio" 
                                    name="play_type" value="멀티">Multi
                                    <span class="circle">
                                          <span class="check"></span>
                                    </span>
                                 </label>
                              </div>
                        </div>
                        <label>Genre</label>
                        <div class="form-group">                        
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="FPS" onclick="countcheck(this)">FPS
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="RPG" onclick="countcheck(this)">RPG
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="스포츠" onclick="countcheck(this)">스포츠
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="전략" onclick="countcheck(this)">전략
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="레이싱" onclick="countcheck(this)">레이싱
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="액션" onclick="countcheck(this)">액션
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="호러" onclick="countcheck(this)">호러
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="육성" onclick="countcheck(this)">육성
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="AOS" onclick="countcheck(this)">AOS
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="genre" value="MMORPG" onclick="countcheck(this)">MMORPG
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                        </div>
                        <label>Hash tag</label>
                        <div class="form-group">                        
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                                 <input class="form-check-input" type="checkbox" 
                                 name="hash_tag" value="경쟁" onclick="countcheck2(this)">경쟁
                                 <span class="form-check-sign">
                                       <span class="check"></span>
                                 </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="어드벤처" onclick="countcheck2(this)">어드벤처
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="액션" onclick="countcheck2(this)">액션
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="캐쥬얼" onclick="countcheck2(this)">캐쥬얼
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="전략" onclick="countcheck2(this)">전략
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="공포" onclick="countcheck2(this)">공포
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="귀여운" onclick="countcheck2(this)">귀여운
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="오픈 월드" onclick="countcheck2(this)">오픈 월드
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="생존" onclick="countcheck2(this)">생존
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="PVP" onclick="countcheck2(this)">PVP
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="전쟁" onclick="countcheck2(this)">전쟁
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="협동" onclick="countcheck2(this)">협동
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="파괴" onclick="countcheck2(this)">파괴
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="칼싸움" onclick="countcheck2(this)">칼싸움
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="힐링" onclick="countcheck2(this)">힐링
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="어두운" onclick="countcheck2(this)">어두운
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="닌자" onclick="countcheck2(this)">닌자
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="FPS" onclick="countcheck2(this)">FPS
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="스포츠" onclick="countcheck2(this)">스포츠
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="레이싱" onclick="countcheck2(this)">레이싱
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="폭력" onclick="countcheck2(this)">폭력
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="1인칭" onclick="countcheck2(this)">1인칭
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="탐험" onclick="countcheck2(this)">탐험
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                              <input class="form-check-input" type="checkbox" 
                              name="hash_tag" value="격투" onclick="countcheck2(this)">격투
                              <span class="form-check-sign">
                                    <span class="check"></span>
                              </span>
                              </label>
                           </div>
                        </div>
                        <label>Platform</label>   
                        <div class="form-group">                  
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                                 <input class="form-check-input" type="radio" 
                                 name="small_category" value="PC">PC
                                 <span class="circle">
                                       <span class="check"></span>
                                 </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                                 <input class="form-check-input" type="radio" 
                                 name="small_category" value="MOBILE">Mobile
                                 <span class="circle">
                                       <span class="check"></span>
                                 </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                                 <input class="form-check-input" type="radio" 
                                 name="small_category" value="SWITCH">Switch
                                 <span class="circle">
                                       <span class="check"></span>
                                 </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                                 <input class="form-check-input" type="radio" 
                                 name="small_category" value="XBOX">Xbox
                                 <span class="circle">
                                       <span class="check"></span>
                                 </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                                 <input class="form-check-input" type="radio" 
                                 name="small_category" value="PS4">PS4
                                 <span class="circle">
                                       <span class="check"></span>
                                 </span>
                              </label>
                           </div>
                        </div>
                     </div>
                        <div class="form-group" align="center">
                           <input type="button" onclick="Formcheck()"
                              class="btn btn-primary" value="수정완료" style="width: 49%">
                           <input type="reset" class="btn btn-primary" value="다시입력"
                              style="width: 49%">
                              <input type="button" class="btn btn-primary" onclick="location.href='${contextPath}/member/mypage.do'" value="취소">
                        </div>
                     </div>
                  </div>
               </form>
            </div>
         </div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />

<!--   Core JS Files   -->
<script src="${contextPath}/resources/js/core/jquery.min.js"
   type="text/javascript"></script>
<script src="${contextPath}/resources/js/core/popper.min.js"
   type="text/javascript"></script>
<script
   src="${contextPath}/resources/js/core/bootstrap-material-design.min.js"
   type="text/javascript"></script>
<script src="${contextPath}/resources/js/plugins/moment.min.js"></script>

<!--   Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
<script
   src="${contextPath}/resources/js/plugins/bootstrap-datetimepicker.js"
   type="text/javascript"></script>

<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
<script src="${contextPath}/resources/js/plugins/nouislider.min.js"
   type="text/javascript"></script>

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>

<!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
<script src="${contextPath}/resources/js/material-kit.js?v=2.0.4"
   type="text/javascript"></script>

</html>