<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="same1" value="true" />
<c:set var="same2" value="true" />
<c:set var="same3" value="true" />
<c:set var="same4" value="true" />
<c:set var="same5" value="true" />

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

<!-- <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->

<!--아이디 중복체크 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function Formcheck() {   
   var Fomcheck = document.fomch;
   var formid = Fomcheck.id.value;
   var formpassword = Fomcheck.password.value;
   var formpassword_check = Fomcheck.password_check.value;
   var formname = Fomcheck.name.value;
   var formbirthday = Fomcheck.birthday.value;
   var formemail = Fomcheck.email.value;
   var formphone_number = Fomcheck.phone.value;
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
   
   if(same1 == 'true' || same2 == 'true' || same3 == 'true' || same4 == 'true' || same5 == 'true'){
      alert("입력값을 확인해주세요");
   }else if(formid.length ==0 || formid=="") {
      alert("ID를 입력해주세요");
      /* formid.focus();
      return false; */
   }
   else if (formpassword.length ==0 || formpassword=="")
   {
      alert("비밀번호를 입력해주세요");
      /* formpassword.focus();
      return false; */
   }
   else if (formpassword =='gmUniconTemp')
   {
      alert("비밀번호를 사용할 수 없습니다. 다른 비밀번호를 이용해 주세요.");
      /* formpassword.focus();
      return false; */
   }
   else if(formpassword_check.length ==0 || formpassword_check!=formpassword)
   {
      alert("비밀번호가 일치하지 않습니다.");
      /* formpassword_check.focus();
      return false; */
   }
   else if(formname.length ==0 || formname=="")
   {
      alert("이름을 입력해주세요");
      formname.focus();
      return false;
   }
   else if(formbirthday.length ==0 || formbirthday=="")
   {
      alert("생년월일을 입력해주세요");
      /* formbirthday.focus();
      return false; */
   }
   else if(formemail.length ==0 || formemail=="")
   {
      alert("이메일을 입력해주세요");
      /* formemail.focus();
      return false; */
   }
   else if(formphone_number.length ==0 || formphone_number=="")
   {
      alert("전화번호를 입력해주세요");
      /* formphone_number2.focus();
      return false; */
   }
   else if(formnickname.length ==0 || formnickname=="")
   {
      alert("닉네임을 입력해주세요");
      /* formnickname.focus();
      return false; */
   }   
   else
   {
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
            Fomcheck.action="${contextPath}/member/addMember.do";
            Fomcheck.submit();
         }
      }
      else
      {
         Fomcheck.method= "post";
         Fomcheck.action="${contextPath}/member/addMember.do";
         Fomcheck.submit();
      }
   }
}
</script>
<script>
<!--아이디 중복체크 -->
function checkId(){
   var id = ($('#id').val)();
      $.ajax({
         url:'${contextPath}/member/overlapped.do',
         type:'post',
         data:{id:id},
         success:function(data){
         if($.trim(data)==1){
            $("#id_check").attr('class','form-group label-floating has-danger');
            $("#id").attr('data-content','중복된 ID입니다');
            $('#id').popover('show');
            $("#id_done").hide();
            $("#id_clear").show();
            same1='true';
         }else {
         if(id==""){
            $('#chkMsg').html(" ");
            same='true';
         }else if(id.length < 4 || id.length > 12){
            $("#id_check").attr('class','form-group label-floating has-danger');                  
            $("#id").attr('data-content','4~12자리 이내로 입력하세요');
            $('#id').popover('show');
            $("#id_done").hide();
            $("#id_clear").show();
            same1='true';
         }else{
            $("#id_check").attr('class','form-group label-floating has-success');
            $("#id").attr('data-content','사용 가능한 ID입니다');
            $('#id').popover('show');
            $("#id_clear").hide();
            $("#id_done").show();
            same1='false';
         }
         }
            
      },
      error:function(){
         alert("에러입니다");   
      }
   });
};   
</script>
<!-- <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->
<!--닉네임 중복체크 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function checkNickname(){
   var nickname = ($('#nickname').val)();
   $.ajax({
      url:'${contextPath}/member/overlappednick.do',
      type:'post',
      data:{nickname:nickname},
      success:function(data){
         if($.trim(data)==1){
            //   $('#chkMsgnic').html("닉네임이 중복되었습니다");
            //   $('#chkMsgnic').css("color","red");
            $("#nickname_div").attr('class','form-group label-floating has-danger');
            $("#nickname").attr('data-content','중복된 ID입니다');
            $('#nickname').popover('show');
            $("#nickname_done").hide();
            $("#nickname_clear").show();
            same2='true';
         }else{
            if(nickname ==""){
               $('#chkMsgnic').html(" ");
            }else if(nickname.length < 2 || nickname.length > 12){
               //   $('#chkMsgnic').html("2~12자리로 입력해주세요");
               //   $('#chkMsgnic').css("color","black");
               $("#nickname_div").attr('class','form-group label-floating has-danger');
               $("#nickname").attr('data-content','2~12자리로 입력하세요');
               $('#nickname').popover('show');
               $("#nickname_done").hide();
               $("#nickname_clear").show();
               same2='true';
            }else{
               //   $('#chkMsgnic').html("사용가능한 닉네임 입니다.");
               //   $('#chkMsgnic').css("color","green");
               $("#nickname_div").attr('class','form-group label-floating has-success');
               $("#nickname").attr('data-content','사용 가능한 닉네임입니다.');
               $('#nickname').popover('show');
               $("#nickname_clear").hide();
               $("#nickname_done").show();               
               same2='false';
            }
         }
      },
      error:function(){
         alert("에러입니다");   
      }
   });
};
</script>
<!--이메일 중복체크 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function email1(){
   var email = ($('#email').val)();
      $.ajax({
      url:'${contextPath}/member/overlappedemail.do',
      type:'post',
      data:{email:email},
      success:function(data){
         if($.trim(data)==1){
            if(email == ""){
               // $('#chkMsgemail').html(" ");
               same3='true';
            }else{
               //   $('#chkMsgemail').html("이메일이 중복되었습니다");
               //   $('#chkMsgemail').css("color","red");
               $("#email_div").attr('class','form-group label-floating has-danger');
               $("#email").attr('data-content','E-Mail이 중복되었습니다');
               $('#email').popover('show');
               $("#email_done").hide();
               $("#email_clear").show();            
               same3="true";   
            }            
         }else{
            //   $('#chkMsgemail').html("사용가능한 이메일 입니다.");
            //   $('#chkMsgemail').css("color","green");
            $("#email_div").attr('class','form-group label-floating has-success');
            $("#email").attr('data-content','사용 가능한 E-Mail입니다');
            $('#email').popover('show');
            $("#email_clear").hide();
            $("#email_done").show();
            same3='false';
         }
      },
      error:function(){
         alert("에러입니다");   
      }
   });
};
function selEmail(email){
   if(email != "직접입력") {
      document.getElementById("email_add2").value = email;
      document.getElementById("email_add2").readOnly = true;
   } else {
      document.getElementById("email_add2").readOnly = false;
      document.getElementById("email_add2").value = value;
      document.getElementById("email_add2").focus();
   }
}
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
         if($.trim(data)==1){
           //   $('#chkMsgpho').html("전화번호가 중복되었습니다");
             //   $('#chkMsgpho').css("color","red");
             $("#phone_div").attr('class','form-group label-floating has-danger');
             $("#phone").attr('data-content','번호가 중복되었습니다');
             $('#phone').popover('show');
             $("#phone_done").hide();
             $("#phone_clear").show();
             same4='true';
         }else{
            if(phone_number ==""){
                 $('#chkMsgpho').html(" ");
                 same='true';
              }else if(phone.length !=13){
                    $("#phone_div").attr('class','form-group label-floating has-danger');                  
                    $("#phone").attr('data-content','11자리 전체 입력하세요');
                    $('#phone').popover('show');
                    $("#phone_done").hide();
                    $("#phone_clear").show();
                    same4='true';
              }else{
                 //   $('#chkMsgpho').html("사용가능한 전화번호 입니다.");
                 //   $('#chkMsgpho').css("color","green");
                 $("#phone_div").attr('class','form-group label-floating has-success');
                 $("#phone").attr('data-content','사용 가능한 번호입니다');
                 $('#phone').popover('show');
                 $("#phone_clear").hide();
                 $("#phone_done").show();
                 same4='false';
              }
         }     
      },
      error:function(){
         alert("에러입니다");   
      }
   });
};
</script>
<!--비밀번호 확인체크 -->
<script>
$(function(){
   $('#password').keyup(function(){
      $('#pwcheck').html('');
      $('#pw').html('');
      
      var pw = $('#password').val(); 
      if(pw.length < 8 || pw.length > 20){
         //   $('#pw').html("8자리 ~ 20자리 이내로 입력해주세요.");
         //   $('#pw').attr('color','f82a2aa3');
         $("#pw_div").attr('class','form-group label-floating has-danger');
         $("#password").attr('data-content','8~20자리 이내로 입력하세요');
         $("#password").popover('show');
         $("#pw_done").hide();
         $("#pw_clear").show();
         same5 = 'true';
      }else{
         $("#pw_div").attr('class','form-group label-floating has-success');
         $("#password").popover('hide');
         $("#pw_clear").hide();
         $("#pw_done").show();  
         same5 = 'false';
      }
   });
   
   $('#password_check').keyup(function(){
      if($('#password').val() != $('#password_check').val()){
         //   $('#pwcheck').html('비밀번호 일치하지 않음<br><br>');
         //   $('#pwcheck').attr('color', '#f82a2aa3');
         $("#pw_check_div").attr('class','form-group label-floating has-danger');
         $("#password_check").attr('data-content','비밀번호가 일치하지 않습니다');
         $("#password_check").popover('show');
         $("#pw_check_done").hide();
         $("#pw_check_clear").show();
      }else{
         //   $('#pwcheck').html('비밀번호 일치함<br><br>');
         //   $('#pwcheck').attr('color', '#199894b3');
         $("#pw_check_div").attr('class','form-group label-floating has-success');
         $("#password_check").attr('data-content','비밀번호가 일치합니다');
         $("#password_check").popover('show');
         $("#pw_check_clear").hide();
         $("#pw_check_done").show();
      }
   });
});
</script>
<!-- 이메일 발송 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function email_send(){
   var email1 = ($('#email').val)();
   var email3 = '@';
   var email2 = ($('#email_add2').val)();
   var email = email1 + email3 + email2;
   $.ajax({
      url:'${contextPath}/member/email.do',
      type:'post',
        data:{email:email},
      success:function(data){
         alert("성공입니다.");
      },
      error:function(){
         alert("에러입니다");   
      }
   });
}
</script>
<!-- 이메일 인증 처리 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
function email_check() {
   var email_check_number = ($('#email_check_number').val)();
   sendbtn = document.getElementById('email_send');
   sendbtn = document.getElementById('email_send');
   $.ajax({
      url:'${contextPath}/member/email_check.do',
      type:'post',
      data:{email_check_number:email_check_number},
      success:function(data){
         if(data=="true") {
            alert("인증이 완료되었습니다.");
         } else if(data=="false") {
            alert("인증번호를 잘못 입력하셨습니다.")
         }
      },
      error:function(){
         alert("에러입니다.");
      }
   });
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
   }else{
      show.style.display="none";
   }
}
</script>
<!-- 장르 체크박스 제한 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
var maxcheck = 2;
var check = 0;
var genre = document.getElementById("#genre");

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
<title>회원가입 창</title>
</head>
<body>
   <div class="section section-signup page-header">
      <div class="container">
         <div class="row">
            <div class="card card-login">
               <form name="fomch">
                  <div class="card-header card-header-default text-center">
                     <h4 class="card-title">Join</h4>
                  </div>
                  <div class="col-md-12">
                     <div class="form-group" id="id_check">
                        <label for="id">ID</label>
                        <input type="text"
                        class="form-control" id="id" name="id" placeholder="ID"
                        oninput="checkId()" data-container="body" data-toggle="popover"
                        data-placement="right" data-content="">
                        <div id="id_done" style="display: none">
                           <span class="form-control-feedback">
                              <i class="material-icons">done</i>
                           </span>
                        </div>
                        <div id="id_clear" style="display: none">
                           <span class="form-control-feedback">
                              <i class="material-icons">clear</i>
                           </span>
                        </div>
                     </div>
                     <div class="form-group" id="pw_div">
                        <label for="password">Password</label>
                        <input type="password"
                        class="form-control col-md-12" id="password" name="password"
                        placeholder="Password" data-container="body"
                        data-toggle="popover" data-placement="right" data-content="">
                        <div id="pw_done" style="display: none">
                           <span class="form-control-feedback">
                              <i class="material-icons">done</i>
                           </span>
                        </div>
                        <div id="pw_clear" style="display: none">
                           <span class="form-control-feedback">
                              <i class="material-icons">clear</i>
                           </span>
                        </div>
                     </div>
                     <div class="form-group" id="pw_check_div">
                        <label for="password_check">Password Check</label>
                        <input type="password" class="form-control" id="password_check"
                        name="password_check" placeholder="Password Check"
                        data-container="body" data-toggle="popover"
                        data-placement="right" data-content="">
                        <div id="pw_check_done" style="display: none">
                           <span class="form-control-feedback">
                              <i class="material-icons">done</i>
                           </span>
                        </div>
                        <div id="pw_check_clear" style="display: none">
                           <span class="form-control-feedback">
                              <i class="material-icons">clear</i>
                           </span>
                        </div>
                     </div>
                     <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Name">
                     </div>
                     <div class="form-group">
                        <label for="birthday">BirthDay</label>
                        <input type="text"
                        class="form-control" id="birthday" name="birthday"
                                placeholder="YYMMDD" maxlength="6">
                     </div>
                     <div class="form-group" id="email_div">
                        <label for="email">E-Mail</label>
                        <input type="text" class="form-control" id="email" name="email"
                        placeholder="google@gmail.com" oninput="email1()"
                        data-container="body" data-toggle="popover"
                        data-placement="right" data-content="">
                        <div id="email_done" style="display: none">
                           <span class="form-control-feedback">
                              <i class="material-icons">done</i>
                           </span>
                        </div>
                        <div id="email_clear" style="display: none">
                           <span class="form-control-feedback"> <i
                              class="material-icons">clear</i>
                           </span>
                        </div>
                     </div>
                     <div class="form-group" id="phone_div">
                        <label for="phone">Phone</label>
                        <input type="text" class="form-control" id="phone" name="phone"
                        placeholder="(-)없이 입력" oninput="phone1()"
                        data-container="body" data-toggle="popover"
                        data-placement="right" data-content="" maxlength="13">
                        <div id="phone_done" style="display:none">
                           <span class="form-control-feedback">
                              <i class="material-icons">done</i>
                           </span>
                        </div>
                        <div id="phone_clear" style="display:none">
                           <span class="form-control-feedback">
                              <i class="material-icons">clear</i>
                           </span>
                        </div>
                     </div>
                     <div class="form-group" id="nickname_div">
                        <label for="nickname">NickName</label>
                        <input type="text"
                        class="form-control" id="nickname" name="nickname"
                        placeholder="NickName" oninput="checkNickname()"
                        data-container="body" data-toggle="popover"
                        data-placement="right" data-content="">
                        <div id="nickname_done" style="display:none">
                           <span class="form-control-feedback">
                              <i class="material-icons">done</i>
                           </span>
                        </div>
                        <div id="nickname_clear" style="display:none">
                           <span class="form-control-feedback">
                              <i class="material-icons">clear</i>
                           </span>
                        </div>
                     </div>
                     <div class="form-group">
                        <label>Gender</label>
                        <div class="form-group">
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                                 <input class="form-check-input" type="radio" name="sex"
                                 id="sex" value="남" checked="checked"> Man
                                 <span class="circle">
                                       <span class="check"></span>
                                 </span>
                              </label>
                           </div>
                           <div class="form-check form-check-inline">
                              <label class="form-check-label">
                                 <input class="form-check-input" type="radio" name="sex"
                                 id="sex" value="여"> Woman
                                 <span class="circle">
                                       <span class="check"></span>
                                 </span>
                              </label>
                           </div>
                        </div>
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
                        <input type="button" onclick="Formcheck()" class="btn btn-primary"
                        value="회원 가입" style="width:49%">
                        <input type="reset" class="btn btn-primary"
                        value="초기화" style="width:49%">
                     </div>
                  </div>
               </form>
            </div>
         </div>
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