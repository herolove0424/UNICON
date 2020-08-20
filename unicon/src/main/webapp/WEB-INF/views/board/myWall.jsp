<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	request.setCharacterEncoding("UTF-8");
	String session_id = (String) session.getAttribute("session_id");
	System.out.println("세션아이디:" + session_id);
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>담벼락 페이지</title>
</head>
<style>
	.btn_save {
		display: none;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	function getWallReplyList(Num, vid) {
		var num = String(Num);
		var vid2 = String(vid);
		var brd = document.getElementById("boardNO" + num).value;
		
		$.ajax({
			url : '${contextPath}/board/getWallReplyList.do',
			type : 'get',
			dataType:"json",
			data : {"rep_parentNO" : brd},
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success : function(data){
				
				var html = "";
				
				/* 댓글 입력하기 폼*/
				html += "<div><form id='replyForm"+num+"'><table align='center'><tr>";
				html += "<td colspan=2><textarea name='rep_content' rows='3' cols='120' maxlength='2000' id='rep_content' class='form-control' placeholder='댓글을 입력.'>";
				html += "</textarea></td></tr><tr><td></td><td style='text-align:right;'><input type='hidden' id='rep_parentNO' value='"+brd+"'>";
				html += "<input type='button' value='댓글달기' class='btn btn-primary btn-xs' onClick='ajax_addWallReply("+num+")'>";
				html += "<input type='reset' class='btn btn-default btn-xs' value='다시 입력'></td></tr></form>";
				html += "<div><table class='table table-bordered'><tr class='success'><td>작성자</td><td>내용</td><td>작성일</td><td>수정</td><td>삭제</td></tr>"
				
				
				if(data.length>0) {

					for(i=0; i<data.length; i++) {

						/* 댓글 리스트 html */
						html += "<tr><td text-align='center'>" + data[i].rep_id + "</td><td text-align='center'><span id='blockCon"+i+"' style='display:block'>"+data[i].rep_content+"</span><input type='text' class='form-control' name='rep_content' id='r_content"+i+"' value='"+data[i].rep_content+"' style='display:none' disabled></td>";
						html += "<td text-align='center'>" + data[i].rep_writeDate + "</td>";
						if(vid2 == data[i].rep_id){
							html += "<td id='btn_mod"+i+"' text-align='center'><input type='button' id='modify"+i+"' value='수정' onclick='fn_enable("+i+")'></td>";
							html += "<td id='btn_save"+i+"' colspan='2' class='btn_save' text-align='center'><input type='button' value='저장' onClick='modify_reply("+ data[i].rep_boardNO+",r_content"+i+","+i+")'/><input type='button' value='취소' onClick='backToList()'/></td>";
							html += "<td><input type='button' value='삭제' onclick='ajax_delWallReply("+data[i].rep_boardNO+")'></td>";
							html += "</tr>";
						} else {
							html += "<td></td><td></td></tr>"; 
						}
					}
					html +="</table></div><div style='text-align:center;'><a href='#'>맨위로</a></div>";
				} else {
					 /* 댓글 리스트 html */
					 html += "<div>";
		             html += "<div><table class='table'><h4><strong>등록된 댓글이 없습니다.</strong></h4>";
		             html += "</table></div>";
		             html += "</div><div style='text-align:center;'><a href='#'>맨위로</a></div>";
				}    
				$("#table" + num).html(html);
			},
			error : function(request,status,error){
				 
			 }
		});
	}
	
	/* input box(댓글) 열고 닫기 */
	function fn_enable(count) {
		document.getElementById("r_content" + count).disabled = false;
		document.getElementById("btn_save" + count).style.display = "block";
		document.getElementById("btn_mod" + count).style.display = "none";
		document.getElementById("blockCon" + count).style.display = "none";
		document.getElementById("r_content" + count).style.display = "block";
	}
	
	/* 댓글저장버튼 함수 */
	function modify_reply(rep_boardNO, rep_contentId, count) {
		var r_content = $("#" + "r_content" + count).val();
		
			$.ajax({
				type : 'post',
				url : '${contextPath}/board/updateWallReply.do',
				data : {"rep_boardNO" : rep_boardNO, "rep_content" : r_content},
				success : function(data) {
				if (data == "success") {
					alert("댓글을 수정했습니다");
					location.reload();
					} else {
						return false;
					}
				}
			});
		}
	/* ajax 댓글 삭제 */
function ajax_delWallReply(rep_boardNO) {
		
		$.ajax({
			type:'get',
			url:'${contextPath}/board/ajaxDelWallReply.do',
			data:{"rep_boardNO" : rep_boardNO},
			success:function(data){
				if(data=="success") {
					var chk = confirm("댓글을 삭제하시겠습니까?");
					if(chk) {
						alert("댓글을 삭제했습니다");
						location.reload();
					} else {
						return false;
					}			
				} else {
					return false;
				}
			}
		});
	}
	
/* 댓글 추가 */
function ajax_addWallReply(num) {
	
	var formName = "#"+"articleForm"+num;
	
	var rep_parentNO = document.getElementById("rep_parentNO").value;
	var rep_content = document.getElementById("rep_content").value;
	
	$.ajax({
		type:'get',
		url:'${contextPath}/board/ajaxAddWallReply.do',
		data: {"rep_parentNO" : rep_parentNO, "rep_content" : rep_content},
		success:function(data){
			if(data=="success") {
				var chk = confirm("댓글을 입력하시겠습니까??");
				
				if(chk){
					alert("댓글을 입력했습니다");
					location.reload();
				}else {
					return false;
				}	
			} else {
				return false;
			}
		}
	});
}  

	/* 게시글 삭제 */
	function removeArticle(boardNO) {
		
		$.ajax({
			type:'get',
			url:'${contextPath}/board/removeArticle.do',
			data:{"boardNO" : boardNO},
			success:function(data){
				if(data=="success") {
					var chk = confirm("게시글을 삭제하시겠습니까?");
					if(chk) {
						alert("게시글을 삭제했습니다");
						location.reload();
					} else {
						return false;
					}			
				} else {
					return false;
				}
			}
		});
		
	}
	
	/* 담벼락으로 돌아가기 */
	function backToMyWall(obj) {
		obj.action = "${contextPath}/board/myWall.do";
		obj.submit();
	}
	
	/* input box(게시글) 열고 닫기 */
	function fn_enabled(count) {
		document.getElementById("content" + count).disabled = false;
		document.getElementById("article_save" + count).style.display = "block";
		document.getElementById("article_mod" + count).style.display = "none";
	}
	
	/* 게시글 수정하기 */
	function fn_modWallArticle(boardNO, count) {
		var content = $("#"+"content"+count).val();
		
		if (content == null || content.length == "") {
			alert("수정할 내용을 입력해 주세요.");
		}
		
		$.ajax({
			type : 'post',
			url : '${contextPath}/board/updateWallArticle.do',
			data : {"boardNO" : boardNO, "content" : content},
			success : function(data) {
			if (data == "success") {
				alert("게시글을 수정했습니다");
				location.reload();
				} else {
					return false;
				}
			}
		});
	}
	
	/* 댓글 수정 취소 버튼 */
	function backToList() {
		location.reload();
	}
</script>
<jsp:include page="../bootstrap/timelineheader.jsp"></jsp:include>
<body>
<div class="col-md-10">
    <div class="jumbotron" style="background-color: white;">
    <div style="background-color: white;">
	<table>
		<c:choose>
			<c:when test="${myWallList == null}">
					<div><strong>등록된 글이 없어용~~</strong></div>
			</c:when>
			<c:when test="${myWallList != null }">
			<c:if test="${MyID == WallID}">
				<div align="right">
					<a class="btn btn-success" href="${contextPath}/board/addWallArticleForm.do">새 글쓰기</a>
				</div>
			</c:if>	
				<c:forEach var="wall" items="${myWallList}" varStatus="wallNum">
					<!-- PC, MOBILE, FREE CONSOLE 에 있는 친구 게시글 모아서 반복으로 뽑는 FOREACH -->
						<table>
							<form name="articleForm${wallNum.count}" method="post">
								<table class="table">
									<tr>
										<td class="success" style="text-align:center;"> 제목 </td>
										<td> ${wall.title} </td>
									</tr>
									<tr>
										<td class="success" style="text-align:center; vertical-align: middle;"> 내용 </td>
										<td> 
											<input type="text" id="content${wallNum.count}" style="height:100px; width:200px;" value="${wall.content}" disabled/> 
										</td>
									</tr>
									<tr>
										<td class="success" style="text-align:center;"> 작성일 </td>
										<td> ${wall.writeDate} </td>
									</tr>
									<input type="hidden" id="boardNO${wallNum.count}" value="${wall.boardNO}">
									<c:if test="${MyID == WallID}">
									<tr>
										<td><input type="button" class="btn btn-danger" value="게시글 삭제" onClick="removeArticle(${wall.boardNO})"/></td>
										<td><input type="button" class="btn btn-default" id="article_mod${wallNum.count}" value="수정하기" onClick="fn_enabled(${wallNum.count})"/></td>
										<td colspan=2 id="article_save${wallNum.count}" style="display: none;">
											<input type="button" class="btn btn-primary"  value="저장" onClick="fn_modWallArticle('${wall.boardNO}',${wallNum.count})"/>
											<input type="button" class="btn btn-default" value="취소" onClick="backToMyWall(this.form)"/>
										</td>
									</tr>
									</c:if>	
								</table>
									<div style="text-align:center; padding-left:785px;">
										<input type="button" class="btn btn-primary btn-xs" id="btn${wallNum.count}" value="댓글 입력&보기" onClick="getWallReplyList('${wallNum.count}','${session_id}')">
									</div>
							</form>
						</table>
						<div  id="table${wallNum.count}" align="center">
						</div>
						<hr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
	</div>
	</div>
    </div>
  </div>
</div> 
 <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="${contextPath}/resources/js/bootstrap.min.js"></script>
    <!-- <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script> -->
</body>
</html>