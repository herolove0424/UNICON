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
<title>타임라인이다 이자식아</title>
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
						html += "<div><form id='replyForm"+num+"'><table align='center'><tr><td align='center' valign='top'><br>댓글내용 :    </td>";
						html += "<td><textarea name='rep_content' rows='10' cols='65' maxlength='2000' id='rep_content' placeholder='댓글을 입력.'>";
						html += "</textarea></td></tr><tr><td align='right'></td><td><input type='hidden' id='rep_parentNO' value='"+brd+"'>";
						html += "<input type='hidden' id='status' value='"+sts+"'><input type='button' value='댓글달기' onClick='ajax_addReply("+num+")'>";
						html += "<input type='reset' value='다시 입력'></td></tr></form>";
						html += "<div><table align='center'><tr align='center'><td>작성자</td><td>내용</td><td>작성일</td><td>수정</td><td>삭제</td></tr>"

						if (data.length > 0) {
							for (i = 0; i < data.length; i++) {
								/* 댓글 리스트 html */
								html += "<tr align='center'><td>"+data[i].rep_id+"</td><td><input type='text' name='rep_content' id='r_content"+i+"' value='"+data[i].rep_content+"' disabled></td>";
								html += "<td>"+data[i].rep_writeDate+"</td>";
								if (vid2 == data[i].rep_id) {
									html += "<td id='btn_mod"+i+"'><input type='button' id='modify"+i+"' value='수정' onclick='fn_enable(this.form,r_content"	+i+","+i+")'></td>";
									html += "<td><input type='button' value='삭제' onclick='ajax_delReply("+data[i].rep_boardNO+","+sts+")'></td>";
									html += "<td id='btn_save"+i+"' colspan='2' class='btn_save'><input type='button' value='저장' onClick='modify_reply("+ data[i].rep_boardNO+",r_content"+i+","+sts+","+i+")'/><input type='button' value='취소' onClick='backToTimeLine()'/></td>";
									html += "</tr></table></div>";
								} else {
									html += "</tr></table></div>";
								}
							}

						} else {
							/* 댓글 리스트 html */
							html += "<div>";
							html += "<div><table class='table'><h4><strong>등록된 댓글이 없습니다.</strong></h4>";
							html += "</table></div>";
							html += "</div>";
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
<body>
	<table>
		<c:choose>
			<c:when test="${timeLineList != null }"> <!--아마 tLineList로 되어있을꺼야 조심해.  -->
				<div align="center">
					<a href="${contextPath}/board/mainBoard.do">갈림길로 가자</a>
				</div>
				<c:forEach var="tLine" items="${timeLineList}" varStatus="tLineNum">
					<!-- PC, MOBILE, FREE CONSOLE 에 있는 친구 게시글 모아서 반복으로 뽑는 FOREACH -->
					<table id="tbl${tLineNum.count}">
						<form name="replyForm${tLineNum.count}" method="post">
							<div align="left">${tLineNum.count} 번 필드셋</div>
							<div align="center">작성자 : ${tLine.id}</div>
							<div align="center">제목 : ${tLine.title}</div>
							<div align="center">내용 : ${tLine.content}</div>
							<div align="center">작성일 : ${tLine.writeDate}</div>
							<div align="center">게시 글번호 : ${tLine.boardNO}</div>
							<div align="center">게시판 상태값 : ${tLine.status}</div>
							<input type="hidden" id="boardNO${tLineNum.count}" value="${tLine.boardNO}"> 
							<input type="hidden" id="status${tLineNum.count}" value="${tLine.status}">
							<div align="center">
								<input type="button" id="btn${tLineNum.count}" value="댓글"	onClick="btn('${tLineNum.count}','${session_id }');">
							</div>
							<div align="right">
								<a href="#">맨위로</a>
							</div>
						</form>
					</table>
					<hr>
				</c:forEach>
			</c:when>
		</c:choose>
	</table>
</body>
</html>