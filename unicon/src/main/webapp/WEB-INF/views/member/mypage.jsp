<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="isLogOn" value="${param.isLogOn }" />
<c:set var="result" value="${param.result }" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
#tag {
	font-size: 15px;
}
</style>
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
.sans {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>

<title>마이페이지</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<c:choose>
	<c:when test="${result=='mod2'}">
		<script>
			window.onload = function() {
				alert("수정이 완료되었습니다.");
			}
		</script>
	</c:when>
</c:choose>
<script>
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	function delid(){
         var view = prompt("삭제를 원하시면 '삭제'라고 입력해주세요","oAo");
         var Fomcheck = document.delmember;
         switch(view){
            case "삭제":
                Fomcheck.method= "post";
                 Fomcheck.action="${contextPath}/member/removemember.do";
                 Fomcheck.submit();
                 alert("삭제가 완료되었습니다.");
            break;
         }
      }
	
</script>
</head>
<jsp:include page="../bootstrap/header.jsp" />
<body>
	<div class="main main-raised" style="margin:-60px 400px">
		<div class="section section-basic" style="padding-bottom:40px">
			<div class="container">
				<h1 class="sans" align="center">${member.nickname}님의 마이페이지!</h1>
			</div>
			<form name="delmember">
            <input type="hidden" id = "id" value="${member.id}">
			<div class="col-md-12">
				<c:choose>
					<c:when test="${empty member.imageFileName || member.imageFileName == 'null' }">
						<div class="col-sm-2">
							<label for="disabledTextInput">프로필 사진</label> <img
								src="${contextPath}/resources/img/man.png" alt="Raised Image"
								class="img-raised rounded img-fluid">
						</div>
					</c:when>
					<c:otherwise>
						<div class="col-sm-2">
							<label for="disabledTextInput">프로필 사진</label> <input
								type="hidden" name="originalFileName"
								value="${member.imageFileName}" /> <img
								src="${contextPath}/resources/memberimage/${member.id }/${member.imageFileName}"
								alt="Raised Image" id="preview"
								class="img-raised rounded img-fluid">
						</div>
					</c:otherwise>
				</c:choose>
				<br>
				<div class="form-group">
					<label>아이디</label>
					<input type="text" id="id" class="form-control" value="${member.id}" disabled>
				</div>
				<div class="form-group">
					<label>이름</label>
					<input type="text" id="name" class="form-control" value="${member.name}" disabled>
				</div>
				<div class="form-group">
					<label>생년월일</label>
					<input type="text" id="birthday" class="form-control" value="${member.birthday}" disabled>
				</div>
				<div class="form-group">
					<label>이메일</label>
					<input type="text" id="email" class="form-control" value="${member.email}" disabled>
				</div>
				<div class="form-group">
					<label>핸폰번호</label>
					<input type="text" id="phone_number1" class="form-control" value="${member.phone_number}" disabled>
				</div>
				<div class="form-group">
					<label>닉네임</label>
					<input type="text" id="nickname" class="form-control" value="${member.nickname}" disabled>
				</div>
				<div class="form-group">
					<label>성별</label>
					<input type="text" id="sex" class="form-control" value="${member.sex}" disabled>
				</div>
				<div class="form-group">
					<label>게임 장르</label>
					<c:choose>
						<c:when test="${empty member.genre1 || member.genre1 == 'null'}">
							<input type="text" id="genre" class="form-control"
								value="선택된 게임장르가 없습니다." disabled>
						</c:when>
						<c:when test="${empty member.genre2 || member.genre2 == 'null'}">
							<input type="text" id="genre" class="form-control"
								value="${member.genre1}" disabled>
						</c:when>
						<c:otherwise>
							<input type="text" name="genre" class="form-control" value="${member.genre1}, ${member.genre2}" disabled>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<label for="disabledTextInput">게임 해시태그</label>
					<c:choose>
						<c:when
							test="${empty member.hashtag1 || member.hashtag1 == 'null' }">
							<input type="text" id="hashtag" class="form-control"
								value="선택된 해시태그가 없습니다." disabled>
						</c:when>
						<c:when test="${empty member.genre2 || member.genre2 == 'null' }">
							<input type="text" id="hashtag" class="form-control"
								value="${member.hashtag1}" disabled>
						</c:when>
						<c:when
							test="${empty member.hashtag3 || member.hashtag3 == 'null' }">
							<input type="text" id="hashtag" class="form-control"
								value="${member.hashtag1},${member.hashtag2}" disabled>
						</c:when>
						<c:otherwise>
							<input type="text" name="hashtag" class="form-control"
								value="${member.hashtag1},${member.hashtag2},${member.hashtag3}"
								disabled>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<label for="disabledTextInput">플레이어 타입</label>
					<c:choose>
						<c:when
							test="${empty member.play_type || member.play_type == 'null' }">
							<input type="text" id="play_type" class="form-control"
								value="선택된 플레이어 타입이 없습니다." disabled>
						</c:when>
						<c:otherwise>
							<input type="text" name="play_type" class="form-control"
								value="${member.play_type}" disabled>
						</c:otherwise>
					</c:choose>
				</div>
				<div class="form-group">
					<label for="disabledTextInput">플랫폼</label>
					<c:choose>
						<c:when
							test="${empty member.small_category || member.small_category == 'null' }">
							<input type="text" id="선택된 small_category 없습니다."
								class="form-control" value="선택된 플랫폼이 없습니다." disabled>
						</c:when>
						<c:otherwise>
							<input type="text" name="small_category" class="form-control"
								value="${member.small_category}" disabled>
						</c:otherwise>
					</c:choose>
				</div>
				<br>
				<div class="container" align="center">
					<input type="button" class="btn btn-primary"
						onclick="location.href='${contextPath}/member/modifyForm.do'"
						value="정보수정하기"> <input type="button"
						class="btn btn-primary"
						onclick="location.href='${contextPath}/member/pwmodifyForm.do'"
						value="비밀번호변경하기"> <input type="button"
						class="btn btn-primary"
						onclick="location.href='${contextPath}/member/boardlist.do?id=${member.id}'"
						value="게시글관리"> <input type="button"
						class="btn btn-primary"
						onclick="location.href='${contextPath}/member/reply.do?id=${member.id}'"
						value="댓글관리"> <input type="button" class="btn btn-primary"
						onclick="location.href='${contextPath}/member/jjimlist.do?id=${member.id}'"
						value="찜목록"> <input type="button" class="btn btn-primary"
						onclick="location.href='${contextPath}/main.do'" value="메인으로">
						<input type="button" class="btn btn-primary" onclick="delid()" value="회원탈퇴">
				</div>
			</div>
			</form>
		</div>
	</div>
</body>
<jsp:include page="../bootstrap/footer.jsp" />
</html>