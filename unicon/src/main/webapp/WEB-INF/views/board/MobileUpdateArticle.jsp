<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 20/06/29 새로운 거로 수정하려고 주석 처리 -->
<title>글 수정창</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- include libraries(jQuery, bootstrap) -->

<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>

<!-- include summernote css/js-->
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote.js"></script>

<script src="/resources/js/summernote/lang/summernote-ko-KR.js"></script>

<script type="text/javascript">
	function backToList(obj) {
		obj.action = "${contextPath}/board/MobileViewArticle.do?boardNO=" + $
		{
			board.boardNO
		}
		;
		obj.submit();
	}
	function fn_modify_Mobile_article(obj) {
		var title = document.getElementById("title").value;
		if (title == null || title.length == "") {
			alert("제목을 입력해 주세요~")
		} else {
			obj.action = "${contextPath}/board/MobileUpdateArticle2.do";
			obj.submit();
		}
	}
</script>
<!-- 썸머노트 스크립트 -->
<script type="text/javascript">
	$(document).ready(function() {
		$('#summernote').summernote({
			placeholder : '글을 작성해라 임마.',
			minHeight : null,
			maxHeight : null,
			focus : true,
			lang : 'ko-KR',
			callbacks : {
				uploadSummernoteImageFile : uploadSummernoteImageFile
			}
		});
		//수정글에 에디터안에 기존 내용 가져오기
		$("#summernote").summernote('code', '${board.content}');
	});

	function uploadSummernoteImageFile(files) {

		var data = new FormData();
		data.append("");

		for (var i = 0; i < files.length; i++) {
			data.append("files[" + i + "]", files[i]);
		}

		$.ajax({
			data : data,
			type : "POST",
			url : "/MobileUploadSummernoteImageFile",
			cache : false,
			contentType : false,
			processData : false,
			success : function(d) {
				if (!d.result) {

				} else {
					for (var i = 0; i < d.data.length; i++) {
						$('#summernote').summernote('insertImage', d.data[i]);
					}
				}
			}

		});
		return false;
	}
</script>

</head>
<jsp:include page="../bootstrap/boardTotal.jsp" flush="true" />
<body>
	<div class="main main-raised">
		<div class="section section-basic">
			<div class="container">
				<div class="container" align="center">
					<form name="frmMobileMod" method="post"
						action="${contextPath}/board/MobileUpdateArticle2.do"
						enctype="multipart/form-data">

						<table class="table">
							<input type="hidden" name="boardNO" value="${board.boardNO}">
							<tr>
								<td align="right">작성자:</td>
								<td colspan="2"><input type="text" class="form-control" style="font-size: small;" value="${member.id}" readonly /></td>
							</tr>
							<tr>
								<td align="right">글제목:</td>
								<td colspan="2"><input type="text" class="form-control" style="font-size: small;" id="title" name="title" value="${board.title}" /></td>
							</tr>
							<tr>
								<td align="right">글내용:</td>
								<td><textarea id="summernote"  class="form-control" name="content"></textarea></td>
							</tr>
						</table>
						<input type=button value="수정반영하기" class="btn btn-primary btn-sm" style="font-size: medium;"
							onClick="fn_modify_Mobile_article(frmMobileMod)"> <input class="btn btn-default btn-sm" style="font-size: medium;"
							type=button value="취소" onClick="backToList(frmMobileMod)">
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>