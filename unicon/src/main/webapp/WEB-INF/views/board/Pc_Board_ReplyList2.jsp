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
<head>
<meta charset="UTF-8">
<title>답글 창</title>
<style>
     .tr_btn_save{
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
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

.dropdown a:hover {
	background-color: #ddd;
}

.show {
	display: block;
}
</style>

<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
	rel="stylesheet" />

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">

<script>
	function fn_enable(obj,rep_contentId,count){
		 document.getElementById("content").style.display="none";
		 document.getElementById("content_modify").style.display="block";
		 document.getElementById("tr_btn_save"+count).style.display="block";
		 document.getElementById("tr_btn_mod"+count).style.display="none";  
	}
	/* 댓글 수정 */
	function fn_modify_reply(rep_boardNO, rep_contentId,rep_parentNO){
		 var form=document.createElement("form");
		 form.setAttribute("method","post");
		 form.setAttribute("action","${contextPath}/board/updateReply.do");
		 
		 var v_rep_boardNO=document.createElement("input");
		 v_rep_boardNO.setAttribute("type","hidden");
		 v_rep_boardNO.setAttribute("name","rep_boardNO");
		 v_rep_boardNO.setAttribute("value",rep_boardNO);
		 
		 var r_content=$("#"+rep_contentId).val();
		 
		 
		 v_rep_content=document.createElement("input");
		 v_rep_content.setAttribute("type","hidden");
		 v_rep_content.setAttribute("name","rep_content");
		 v_rep_content.setAttribute("value",r_content);
		 
		 
		 v_rep_parentNO=document.createElement("input");
		 v_rep_parentNO.setAttribute("type","hidden");
		 v_rep_parentNO.setAttribute("name","rep_parentNO");
		 v_rep_parentNO.setAttribute("value",rep_parentNO);
		 
		 form.appendChild(v_rep_boardNO);
		 form.appendChild(v_rep_content);
		 form.appendChild(v_rep_parentNO);
		 document.body.appendChild(form);
		 
		 form.submit();
	 }
	
	/* 버튼 display 껏다 켯다 */
	function fn_addReply(boardNO) {
		var reply = document.getElementById("d_reply"+boardNO);
		var btn = document.getElementById("reply_btn"+boardNO);
		
		if(reply.style.display == "none"){
			reply.style.display = "block";
			btn.value = "취소";
		} else {
			reply.style.display = "none";
			btn.value = "대댓글 등록";
		}
	}
	
	
	/* 대댓글 AJAX 구문  */
	function fn_insertReply(boardNO, parentNO) {
		var rep_content = document.getElementById("d_reply_content" + boardNO).value;
		var daedatNO = document.getElementById("daedatNO" + boardNO).value;
		
		$.ajax({
			url : '${contextPath}/board/addReply.do',
			type : 'post',
			data : {"rep_boardNO" : boardNO, "rep_content" : rep_content, "rep_parentNO" : parentNO, "daedatNO" : daedatNO},
			success:function(data){
				alert("성공");
				location.reload();
			}
		});
	}
	
	/* 댓글 삭제 */
    function remove(rep_boardNO,rep_parentNO) {
		 var chk = confirm("정말 삭제 할꺼니?");
		 if(chk) {
			 alert("댓글이 삭제되었습니다.")
			 location.href='deleteReply.do?rep_boardNO=' + rep_boardNO + "&rep_parentNO=" + rep_parentNO;
		 } else {
			 return false;
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
	var i2;
	function layerNickNameReply(i) {
		id = document.getElementById("replyhiddenid"+i).value;
		i2=i;
		var html = "";
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
				    html += "<div id='myDropdown"+i+"' class='dropdown-content'>";
				    html += "<a href='' onclick='popupFriend()'>친구신청</a>";
				    html += "<a href='' onclick='popup()'>메세지보내기</a>";
				    html += "</div>";
				    html += "</div>";
				
				    $("#nickNameDropReply"+i).html(html);
				    layerNickNameFunction(i2);
				}
		        
			},
			error:function(data){
					alert("오류가 발생했습니다.");
	        }
		});
	}

	function layerNickNameFunction(num) {
		document.getElementById("myDropdown"+num).classList.toggle("show");
	}

	function popup(){
		 var url = "${contextPath}/message/messageform.do?id="+id;
	     var name = "메세지 전송";
	     var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	     window.open(url, name, option);
	 }
    
    function popupFriend() {
   	 if(id==sessionID){
   		 alert("본인에게 친구신청을 하실 수 없습니다.");
   	 }else{
		 var url = "${contextPath}/timeLine/requestPop.do?id_2="+id;
	     var name = "메세지 전송";
	     var option = "width = 500, height = 300, top = 100, left = 200, location = no"
	     window.open(url, name, option);
   	 }
	}
	
</script>
</head>
<body>
	<div class="container">
		<form name="repForm">
			<table class="table">
				<c:choose>
					<c:when test="${empty replyList}">
						<tr>
							<td align="center">
								<p>
									<b><span>등록된 답글이 없습니다.</span></b>
								</p>
							</td>
						</tr>
					</c:when>
					<c:when test="${replyList != null}">
						<c:forEach var="reply" items="${replyList}" varStatus="replyNum">
							<tr align="center">								
								<td align="left" style="vertical-align:middle;">
									<div class="container" style="margin-bottom:-20px">
										<c:if test="${reply.level > 1}">
											<c:forEach begin="2" end="${reply.level}" step="1">
												&ensp;&ensp;
											</c:forEach>
											<i class="material-icons">subdirectory_arrow_right</i>
										</c:if>
										<div class="dropdown">
				    		<input type="hidden" id="replyhiddenid${replyNum.count }" value="${reply.rep_id}" name="writer"  disabled />
				    		<span onclick="layerNickNameReply(${replyNum.count });" style="cursor:pointer" class="dropbtn">&nbsp;${reply.rep_id}</span>
							</div>
							<div id="nickNameDropReply${replyNum.count }"></div>		
										<span style="font-size:9pt;"><fmt:formatDate value="${reply.rep_writeDate }" pattern="YYYY-MM-dd HH:mm:ss" /></span>
									</div>
									<br>
									<br>
									<c:if test="${reply.level > 1}">
										<c:forEach begin="1" end="${reply.level}" step="1">
											&ensp;&ensp;&ensp;
										</c:forEach>
										${reply.rep_content}
									</c:if>
									<c:if test="${reply.level == 1}">
										<div class="container" id="content">
											${reply.rep_content}
										</div>
									</c:if>
									<div class="container" id="content_modify" style="display:none">
										<input type="text" name="rep_content" id="r_content${replyNum.count}" value="${reply.rep_content}">
									</div>
									<c:if test="${session_id == reply.rep_id}">
										<td id="tr_btn_mod${replyNum.count}" align="right" style="vertical-align:middle;">
											<input class="btn btn-default btn-round" type="button" value="수정" onClick="fn_enable(this.form,'r_content${replyNum.count}','${replyNum.count}')">
											<input class="btn btn-default btn-round" type="button" value="삭제" onClick="remove('${reply.rep_boardNO}','${board.boardNO}')">										
											<input type="hidden" name="rep_parentNO" value="${board.boardNO}">
										</td>
									</c:if>
								</td>
								<td id="tr_btn_save${replyNum.count}" class="tr_btn_save" align="right">
									<input class="btn btn-default btn-round" type="button" value="저장" onClick="fn_modify_reply('${reply.rep_boardNO}','r_content${replyNum.count}','${board.boardNO}')">
									<input class="btn btn-default btn-round" type="button" value="취소" onClick="backToList(this.form)">
								</td>
								<td align="right" style="vertical-align:middle;">
									<input class="btn btn-default btn-round" type="button" id="reply_btn${reply.rep_boardNO}" value="대댓글 등록" onClick="fn_addReply(${reply.rep_boardNO})" />
									<input type="hidden" id="daedatNO" name="rep_boardNO${replyNum.count}" value="${reply.rep_boardNO}">
								</td>
							</tr>
							<tr id="d_reply${reply.rep_boardNO}" style="display:none;" align="left">
								<td colspan="4">
									<span style="font-size:15pt;">ㄴ</span>
									<input type="hidden" id="daedatNO${reply.rep_boardNO}" value="${reply.rep_boardNO}"/>
									<input type="text" id="d_reply_content${reply.rep_boardNO}" style="height:40px"/>
									<input class="btn btn-default btn-round" type="button" value="대댓글 등록"
									onClick="fn_insertReply(${reply.rep_boardNO}, ${board.boardNO})" style="height:40px"/>
								</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>
			</table>
		</form>
	</div>
</body>
</html>