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
		obj.action = "${contextPath}/board/ConsoleViewArticle.do?boardNO=" + $
		{
			board.boardNO
		}
		;
		obj.submit();
	}

	function fn_modify_Console_article(obj) {
		var title = document.getElementById("title").value;
		if (title == null || title.length == "") {
			alert("제목을 입력해 주세요~")
		} else {
			obj.action = "${contextPath}/board/ConsoleUpdateArticle2.do";
			obj.submit();
		}
	}
</script>
<!-- 썸머노트 스크립트 -->
<script type="text/javascript">
	$(document).ready(function() {
		$('#summernote').summernote({
			placeholder : '게시글 내용을 작성해주세요',
			minHeight : 620,
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
			url : "/ConsoleUploadSummernoteImageFile",
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
					<h2 style="text-align: center">글 수정하기</h2>
					<form name="frmConsoleMod" method="post"
						action="${contextPath}/board/ConsoleUpdateArticle2.do"
						enctype="multipart/form-data">

						<table class="table">
							<input type="hidden" name="boardNO" value="${board.boardNO}">
							<tr>
								<td><select name="platform" class="form-control" style="font-size: small;">
										<option value="xbox" style="font-size: small;"
											${board.platform eq "xbox" ? "selected" :""}>XBOX</option>
										<option value="ps4" style="font-size: small;"
											${board.platform eq "ps4" ? "selected" :""}>PS4</option>
										<option value="switch" style="font-size: small;"
											${board.platform eq "switch" ? "selected" :""}>SWITCH</option>
								</select></td>
							</tr>
							<tr>
								<td><input type="text" class="form-control" style="font-size: small;" id="title" name="title" value="${board.title}" /></td>
							</tr>
							<tr>
								<td><textarea id="summernote" name="content" class="form-control"></textarea></td>
							</tr>
						</table>
						<input type=button value="수정반영하기" class="btn btn-primary btn-sm" style="font-size: medium;"
							onClick="fn_modify_Console_article(frmConsoleMod)"> <input
							type=button value="취소" class="btn btn-default btn-sm" style="font-size: medium;" onClick="backToList(frmConsoleMod)">
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>