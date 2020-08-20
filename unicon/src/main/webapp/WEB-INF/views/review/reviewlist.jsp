<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<style>
th, td {
	border-bottom:1px solid #444444;
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
<script type="text/javascript" charset="UTF-8"></script>
<script>
	//   댓글 추천수 증가
	function fn_goodsUp(reviewData) {
		$.ajax({
			url : "${contextPath}/review/goodsUp.do",
			type : 'post',
			data : reviewData
		});
	}

	//   댓글 ID 검사
	function fn_goods(review_code, id) {
		if (id == "") {
			alert("로그인 후 댓글 추천이 가능합니다.");
			return;
		} else {
			$.ajax({
				url : "${contextPath}/review/idCheck.do",
				type : 'post',
				data : {
					"review_code" : review_code,
					"id" : id
				},
				success : function(data) {
					//   count값이 1일 경우 이미 동일한 아이디로 추천함.
					if (data.count > 0) {
						alert("이미 추천하셨습니다.");
					}
					//   count값이 0일 경우 추천 가능
					else {
						var reviewData = {
							"review_code" : review_code,
							"id" : id
						};
						fn_goodsUp(reviewData);
						alert("추천 완료");
						location.reload();
					}
				}
			});
		}
	}

	//   댓글 삭제 기능
	function fn_reviewDelete(review_code, id) {
		$.ajax({
			url : "${contextPath}/review/reviewDelete.do",
			type : 'post',
			data : {
				"review_code" : review_code,
				"id" : id
			}
		});
		alert("댓글이 삭제되었습니다.");
		location.reload();
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
	function layerNickName(i) {
		id = document.getElementById("hiddenid"+i).value;
		var html = "";
		html += "<div class='dropdown'>";
		html += "<div id='myDropdown' class='dropdown-content'>";
		html += "<a href='#home'>친구신청</a>";
		html += "<a href='' onclick='popup()'>메세지보내기</a>";
		/* html += "<a href='#contact'>신고하기</a>"; */
		html += "</div>";
		html += "</div>";

		$("#nickNameDrop").html(html);
		layerNickNameFunction();
	}

	function layerNickNameFunction() {
		document.getElementById("myDropdown").classList.toggle("show");
	}

	function NickName(vid) {
		var id = "";
		id += vid;
		return id;
	}

	function popup() {
		var member_id = "<%=(String)session.getAttribute("memberforBoard")%>"
   	 if(member_id=="" || member_id.length==0){
   		 alert("로그인 후 이용하실 수 있는 기능합니다.");
   	 }else{
		 var url = "${contextPath}/message/messageform.do?id="+id; 
	     var name = "메세지 전송";
	     var option = "width = 500, height = 500, top = 100, left = 200, location = no"
	     window.open(url, name, option);
   	 }
	 }

</script>
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
<title></title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" charset="utf-8"></script>
</head>
<body>
	<table class="table" style="vertical-align:middle;">
		<c:forEach var="reviewlist" items="${reviewlist}" varStatus="status">
			<tr>
				<td><div class="dropdown">
			    	<input type="hidden" id="hiddenid${status.count }" value="${reviewlist.id}" name="writer"  disabled />
			    	<span onclick="layerNickName(${status.count });" style="cursor:pointer" class="dropbtn">&nbsp;${reviewlist.id}</span>
				</div>
				<div id="nickNameDrop"></div>
					<c:choose>
						<c:when test="${reviewlist.score ==1}">
							<i class="fa fa-star"></i>
							<i class="fa fa-star-o"></i>
							<i class="fa fa-star-o"></i>
							<i class="fa fa-star-o"></i>
							<i class="fa fa-star-o"></i>
						</c:when>
						<c:when test="${reviewlist.score ==2}">
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star-o"></i>
							<i class="fa fa-star-o"></i>
							<i class="fa fa-star-o"></i>
						</c:when>
						<c:when test="${reviewlist.score ==3}">
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star-o"></i>
							<i class="fa fa-star-o"></i>
						</c:when>
						<c:when test="${reviewlist.score ==4}">
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star-o"></i>
						</c:when>
						<c:when test="${reviewlist.score ==5}">
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
							<i class="fa fa-star"></i>
						</c:when>
					</c:choose>
					<fmt:formatDate pattern="yyyy-MM-dd HH:MM" value="${reviewlist.writedate}"/>
						<c:if test="${reviewlist.id eq member.id}">
						<a href='javascript:void(0);'
							onclick="fn_reviewDelete('${reviewlist.review_code}','${member.id}');"
							style="color: gray">삭제</a>
					</c:if>
					<br>
					<div style="float:left; margin-top:15px">${reviewlist.content}</div>
					<button class="btn btn-default" type="button" style="float:right;"
						onclick="fn_goods('${reviewlist.review_code}','${member.id}')">
						<i class="fa fa-thumbs-up"></i>&nbsp;&nbsp;&nbsp;&nbsp;${reviewlist.goods_count}
					</button>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>