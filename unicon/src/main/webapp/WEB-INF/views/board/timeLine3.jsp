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
 <!-- Bootstrap -->
<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<title>타임라인 페이지</title>
<style>
	.btn_save {
		display: none;
	}
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<script type="text/javascript">
	function btn(Num, vid) {
		var num = String(Num);
		var vid2 = String(vid);
		var brd = document.getElementById("boardNO" + num).value;
		var sts = document.getElementById("status" + num).value;
		
			$.ajax({
				url : '${contextPath}/board/getReplyList.do',
				type : 'get',
				dataType : "json",
				data : {
					"rep_parentNO" : brd,
					"status" : sts
				},
				contentType : "application/x-www-form-urlencoded; charset=UTF-8",
				success : function(data) {
					var html = "";
	
					/* 댓글 입력란 */
					html += "<div><form id='replyForm"+num+"'><table><tr>";
					html += "<td colspan=2><textarea name='rep_content' rows='3' cols='120' maxlength='2000' id='rep_content' class='form-control' placeholder='댓글을 입력.'>";
					html += "</textarea></td></tr><tr><td></td><td style='text-align:right;'><input type='hidden' id='rep_parentNO' value='"+brd+"'>";
					html += "<input type='hidden' id='status' value='"+sts+"'><input type='button' value='댓글달기' class='btn btn-primary btn-xs' onClick='ajax_addReply("+num+")'>";
					html += "<input type='reset' class='btn btn-default btn-xs' value='다시 입력'></td></tr></form>";
					html += "<div><table class='table table-bordered'><tr class='success'><td align='center'>작성자</td><td align='center'>내용</td><td align='center'>작성일</td><td align='center'>수정</td><td align='center'>삭제</td></tr>"
	
					if (data.length > 0) {
						for (i = 0; i < data.length; i++) {
							/* 댓글 리스트 html */
							html += "<tr><td align='center'>"+data[i].rep_id+"</td><td align='center'><span align='center' id='blockCon"+i+"' style='display:block'>"+data[i].rep_content+"</span><input align='center' type='text' class='form-control' name='rep_content' id='r_content"+i+"' value='"+data[i].rep_content+"' style='display:none' disabled></td>";
							html += "<td align='center'>"+data[i].rep_writeDate+"</td>";
							if (vid2 == data[i].rep_id) {
								html += "<td id='btn_mod"+i+"' align='center'><input type='button' id='modify"+i+"' class='btn btn-default' value='수정' onclick='fn_enable(this.form,r_content"	+i+","+i+")'></td>";
								html += "<td id='btn_save"+i+"' colspan='2' class='btn_save' align='center'><input type='button' class='btn btn-default' value='저장' onClick='modify_reply("+ data[i].rep_boardNO+",r_content"+i+","+sts+","+i+")'/><input type='button' class='btn btn-default' value='취소' onClick='backToTimeLine()'/></td>";
								html += "<td align='center'><input type='button' class='btn btn-default' value='삭제' onclick='ajax_delReply("+data[i].rep_boardNO+","+sts+")'></td>";
								html += "</tr>";
							} else {
								html += "<td align='center'><input type='button' class='btn btn-danger' value='X'></td><td align='center'><input type='button' class='btn btn-danger' value='X'></td></tr>";
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
					$("#tbl" + num).html(html);
				},
				error : function(request, status, error) {
	
				}
			});
	}
	/* input box 열고 닫기 */
	function fn_enable(obj, rep_contentId, count) {
		document.getElementById("r_content" + count).disabled = false;
		document.getElementById("btn_save" + count).style.display = "block";
		document.getElementById("btn_mod" + count).style.display = "none";
		document.getElementById("blockCon" + count).style.display = "none";
		document.getElementById("r_content" + count).style.display = "block";
	}

	/* 저장버튼 함수 */
	function modify_reply(rep_boardNO, rep_contentId, status, count) {
		var r_content = $("#" + "r_content" + count).val();
		
			$.ajax({
				type : 'post',
				url : '${contextPath}/board/timeLineUpdateReply.do',
				data : {"rep_boardNO" : rep_boardNO,"status" : status, "rep_content" : r_content},
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
	function ajax_delReply(rep_boardNO, status) {

		$.ajax({
			type : 'get',
			url : '${contextPath}/board/ajaxDelReply.do',
			data : {
				"rep_boardNO" : rep_boardNO,
				"status" : status
			},
			success : function(data) {
				if (data == "success") {
					var chk = confirm("댓글을 삭제하시겠습니까?");
					if (chk) {
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
	function ajax_addReply(num) {

		var formName = "#" + "replyForm" + num;

		var rep_parentNO = document.getElementById("rep_parentNO").value;
		var rep_content = document.getElementById("rep_content").value;
		var status = document.getElementById("status").value;

		$.ajax({
			type : 'get',
			url : '${contextPath}/board/ajaxAddReply.do',
			data : {
				"rep_parentNO" : rep_parentNO,
				"rep_content" : rep_content,
				"status" : status
			},
			success : function(data) {
				if (data == "success") {
					var chk = confirm("댓글을 입력하시겠습니까?");

					if (chk) {
						alert("댓글을 입력했습니다");
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
	
	function backToTimeLine() {
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
			<c:when test="${timeLineList != null }">
						<h3 style="text-align:center;"><strong>환영합니다 타임라인 입니다</strong></h3>
				<c:forEach var="tLine" items="${timeLineList}" varStatus="tLineNum">
					<!-- PC, MOBILE, FREE CONSOLE 에 있는 친구 게시글 모아서 반복으로 뽑는 FOREACH -->
				  <table>
					<form name="replyForm${tLineNum.count}" method="post">
							<table class="table">
								<tr>
									<td class="success" style="text-align:center;"> 작성자 </td>
									<td> ${tLine.id} </td>
								</tr>
								<tr>
									<td class="success" style="text-align:center;"> 제목 </td>
									<td> ${tLine.title} </td>
								</tr>
								<tr>
									<td class="success" style="text-align:center; vertical-align: middle;"> 내용 </td>
									<td style="text-align:center;"> ${tLine.content} </td>
								</tr>
								<tr>
									<td class="success" style="text-align:center;"> 작성일 </td>
									<td> ${tLine.writeDate} </td>
								</tr>
									<input type="hidden" id="boardNO${tLineNum.count}" value="${tLine.boardNO}">
									<input type="hidden" id="status${tLineNum.count}" value="${tLine.status}">
							</table>
							<div style="text-align:center; padding-left:785px;">
								<input type="button" class="btn btn-primary btn-xs" id="btn${tLineNum.count}" value="댓글 입력&보기" onClick="btn('${tLineNum.count}','${session_id }');">
							</div>
							<br>
							<br>

					</form>
				  </table>
					 <div id="tbl${tLineNum.count}" align="center">
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