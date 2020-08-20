<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%> 

<head>
   <meta charset="UTF-8">
   <title>글보기</title>
   <style>
     #tr_file_upload{
       display:none;
     }
     #tr_btn_modify{
       display:none;
     }
     .dropbtn {
         /*  background-color: #3498DB; */
          color: black;
          /* padding: 16px; */
          font-size: 16px;
          border: none;
          cursor: pointer;
        }
        
        .dropbtn:hover, .dropbtn:focus {
          /* background-color: #2980B9; */
          color: red;
        }
        
        .dropdown {
          position: relative;
          display: inline-block;
        }
        
        .dropdown-content {
          display: none;
          position: absolute;
          background-color: #f1f1f1;
          min-width: 160px;
          overflow: auto;
          box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
          z-index: 1;
        }
        
        .dropdown-content a {
          color: black;
          padding: 12px 16px;
          text-decoration: none;
          display: block;
        }
        
        .dropdown a:hover {background-color: #ddd;}
        
        .show {display: block;}
   
   </style>
<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
	rel="stylesheet" />
<link href="${contextPath}/resources/css/modern-business.css"
	rel="stylesheet">

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
	ref="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
<script type="text/javascript" >
     function backToList(obj){
	    obj.action="${contextPath}/board/Free_Board_AllList.do";
	    obj.submit();
     }
	 
	 function FreeDel(boardNO) {
		 var chk = confirm("정말 삭제 할꺼니?");
		 if(chk) {
			 location.href='FreeDeleteArticle.do?boardNO=' + boardNO;
		 }
	 }
	 
	//드롭박스 기능
	 window.onclick = function(event) {
	  if (!event.target.matches('.dropbtn')) {
	    var dropdowns = document.getElementsByClassName("dropdown-content");
	    var i;
	    for (i = 0; i < dropdowns.length; i++) {
	      var openDropdown = dropdowns[i];
	      if (openDropdown.classList.contains('show')) {
	        openDropdown.classList.remove('show');
	      }
	    }
	  }
	}
	 var id;
		var sessionID;
		function layerNickName(){
			id=document.getElementById("hiddenid").value;
		    var html="";
			
			$.ajax({
				url:'${contextPath}/board/getSessionId.do',
				type:'post',
				data:$("#fn_Confirm").serialize(),
				success:function(data){
					 if(data==""||data.length==0||data==null){
						console.log("로그인안함");
						alert("로그인 후 이용해주세요");
					}else if(id==data){
						alert("본인입니다.");
					}else{
						html += "<div class='dropdown'>";
					    html += "<div id='myDropdown' class='dropdown-content'>";
					    html += "<a href='' onclick='popupFriend()'>친구신청</a>";
					    html += "<a href='' onclick='popup()'>메세지보내기</a>";
					    html += "</div>";
					    html += "</div>";
					
					    $("#nickNameDrop").html(html);
					    layerNickNameFunction();
					}
			        
				},
				error:function(data){
						alert("오류가 발생했습니다.");
		        }
			});
			
		    
		}

	function layerNickNameFunction() {
	  document.getElementById("myDropdown").classList.toggle("show");
	}
	
     
     function popup(){
		 var url = "${contextPath}/message/messageform.do?id="+id;
	     var name = "메세지 전송";
	     var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	     window.open(url, name, option);
	 }
     
     function popupFriend() {
		 var url = "${contextPath}/timeLine/requestPop.do?id_2="+id;
	     var name = "메세지 전송";
	     var option = "width = 500, height = 300, top = 100, left = 200, location = no"
	     window.open(url, name, option);
	}
	
 </script>
 <script>
 	$(document).ready(function() {
		//여기 아래 부분
		$('#summernote').summernote({
			  height: 300,                 // 에디터 높이
			  minHeight: null,             // 최소 높이
			  maxHeight: null,             // 최대 높이
			  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			  lang: "ko-KR",					// 한글 설정
			  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		});
	});
 </script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
 <div class="main main-raised">
      <div class="section section-basic">
         <div class="container">         
            <div class="container" align="center">
               <div style="float:left;">         
                  <h2 class="title" align="left">Notice Content</h2>
                  <h6 align="left">글번호</h6>
                  </div>
                  <form name="frmArticle" method="post" action="${contextPath}" enctype="multipart/form-data">
                  <div class="container" align="center">
                     <table class="table">
                        <tr style="margin-top:-10px; margin-bottom:-10px;">
                           <td style="vertical-align:middle;">
                              ${board.title}
                           </td>
                           <td align="right">
                              <h6>작성자 : <div class="dropdown">
    	<input type="hidden" id="hiddenid" value="${board.id}" name="writer"  disabled />
    	<span onclick="layerNickName();" style="cursor:pointer" class="dropbtn">&nbsp;${board.id}</span>
	</div>
	<div id="nickNameDrop"></div></h6>
                              <h6>작성 일자 : ${board.writeDate}</h6>
                              <h6>조회수 : ${board.viewCount}</h6>
                           </td>
                        </tr>
                        <tr style="width:100%; height:500px">
                           <td colspan="2" style="vertical-align:middle;">
                              ${board.content}
                           </td>
                        </tr>
                        <tr align="right">
                           <td colspan="2">
                              <c:if test="${member.id == board.id }">
                                    <input class="btn btn-default btn-round" type=button value="수정하기"
                                    onClick="location.href='FreeUpdateArticle1.do?boardNO=${board.boardNO}'">
                                    <input class="btn btn-default btn-round" type=button value="삭제하기" onClick="FreeDel(${board.boardNO})">
                              </c:if>
                              <input class="btn btn-default btn-round" type=button value="리스트로 돌아가기" onClick="backToList(this.form)">
                           </td>
                        </tr>
                     </table>
                  </div>
               </form>
					 <jsp:include page="FreeReplyForm.jsp"></jsp:include>
 <jsp:include page="Free_Board_ReplyList.jsp"></jsp:include>
				</div>
	</div>
	</div>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>