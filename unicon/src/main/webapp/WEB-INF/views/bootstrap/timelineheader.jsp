<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
  <!-- Bootstrap -->
<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <style>
  body {padding-top: 60px;}
  
  .nickNameFont{
  	font-family:"nickNamefont","serif";
  }
     @font-face{
      font-family: 'nickNamefont';
      src:url("${contextPath}/resources/fonts/HMKMRHD.TTF");
   }
  </style>
<script type="text/javascript">
	function fn_friend_search() {
		var nick_name = friend_search.friend_nickname.value;
	
		if(nick_name==null||nick_name.length==""){
			alert("검색어를 입력해주세요");
		}else{
			friend_search.method="post";
			friend_search.action="${contextPath}/timeLine/nicknameSearch.do";
			friend_search.submit();
		}
	}
</script>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">  
      <!-- 상단메뉴의 이름 -->
      <a class="navbar-brand" href="${contextPath}/main.do">MAIN</a>
      <!-- 상단 메뉴가 좁아지면서 햄버거 버튼됨 -->
      <div class="navbar-header">
        <button class="navbar-toggle collapsed"
                data-toggle="collapse" data-target="#target" >
          <span class="sr-only">Toggle Navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
      </div>
      <!--펼쳐진 상단 메뉴 -->
      <div class="collapse navbar-collapse" id="target">
        <ul class="nav navbar-nav">
        <!-- 상단메뉴의 드롭다운메뉴 -->
         <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">
          	<i class="nc-icon nc-planet"></i>
            <span class="glyphicon glyphicon-volume-up" aria-hidden="true"></span>
            <span class="notification">${sessionScope.dropboxNotice }</span>
            <span class="caret"></span>
          </a>
          <ul class="dropdown-menu">
            <li><a href="${contextPath }/board/friendRequest.do">Friend Request <span style="color: red;">${sessionScope.countFriendAccept }</span></a></li>
            <li><a href="${contextPath}/message/lookMessage.do" target="_blank">Message <span style="color: red;">${sessionScope.remainMessage }</span></a></li>
            <!-- <li class="divider"></li>
            <li><a href="#">Motion</a></li> -->
          </ul>
        </li> 
        <!-- 상단메뉴의 드롭다운메뉴의 끝 -->
        <!-- <li><a href="">            </a></li>
        <li><a href="">            </a></li>
        <li><a href="">            </a></li>
        <li><a href="">            </a></li> -->
        </ul>
        <ul class="nav navbar-nav navbar-right">
          <!-- <li><a href="#">검색</a></li> -->
          <li>
			 <form class="navbar-form navbar-right" name="friend_search" method="post">
			 	<input type="text" class="form-control" name="friend_nickname" size="20" value="${searchValue}" placeholder="유저 닉네임 검색">
				<input type="button" class="btn btn-default btn-sm" value="검색" onclick="fn_friend_search()">	
			 </form>	
		  </li>
          <!-- <li><a href="#">API</a></li> -->
        </ul>
        <!-- 폼태그를 이용한 서칭창 -->
        <!-- <form class="navbar-form navbar-right">
          <input type="text" class="form-control"  placeholder="유저 검색"/>
        </form> -->
        <!-- 폼태그를 이용한 서칭창 끝-->
      </div>
      <!--펼쳐진 상단 메뉴끝 -->
      </div>
  </div>
 <div class="container-fluid">
  <div class="row">
  <div class="col-md-2">
<!-- 사이드 바 메뉴-->
<div class="panel panel-info">
  <div class="panel-heading" style="background-color: #3A5663; border-color: #3A5663;">
    <!-- 패널 타이틀1 -->
  <h3 class="panel-title" style="border-color: #FFFFFF;">
  <!-- 아이콘 붙이기 -->
  <!-- <i class="glyphicon glyphicon-user"></i> -->
    <span style="color:white;">MY PAGE</span>
  </h3>
</div>
<!-- 사이드바 메뉴목록1 -->
<ul class="list-group">
	<li class="list-group-item" style="height:190px;">
		<c:choose>
			<c:when
				test="${empty member.imageFileName || member.imageFileName == 'null' }">
				<div style="padding-left: 50px;">
					<img src="${contextPath}/resources/img/man.png" alt="Raised Image" width="160" height="150"
						class="img-raised rounded img-fluid">
				</div>
					<h4 style="text-align:center; padding-bottom:50px; font-style: italic;">  ${member.nickname} 님  </h4>	
				</c:when>
				<c:otherwise>
					<div class="col-sm-2">
							<input type="hidden" name="originalFileName"
								value="${member.imageFileName}" />
							<img src="${contextPath}/resources/memberimage/${member.id }/${member.imageFileName}" alt="Raised Image"  width="220" height="120" id="preview"
								class="img-raised rounded img-fluid">
					</div>
					<div style="padding-top:130px;"><h4 style="text-align:center; padding-bottom:50px; font-weight: bold; color:#92B3B7;" >  ${member.nickname} 님  </h4></div>
				</c:otherwise>
		</c:choose>
	</li>
</ul>
</div>

<!-- 패널 타이틀2 -->
<div class="panel panel-info">
  <div class="panel-heading" style="background-color: #3A5663; border-color: #3A5663;">
    <!-- <i class="glyphicon glyphicon-send"></i> -->
  	<h3 class="panel-title"><span style="color:white;">FAST MOVE</span></h3>
</div>
<!-- 사이드바 메뉴목록2 -->
<ul class="list-group">
  <li class="list-group-item"><a href="${contextPath}/board/myWall.do?id_2=${session_id}"><span style="font-weight: bold; color:darkblue;">담벼락</span></a></li>
  <li class="list-group-item"><a href="${contextPath}/board/timeLine.do"><span style="font-weight: bold; color:darkblue;">타임라인</span></a></li>
  
</ul>
</div>     
	<div class="panel panel-info">
	<div class="panel-heading" style="background-color: #3A5663; border-color: #3A5663;">
	  <h3 class="panel-title"><span style="color:white;">FRIEND LIST</span></h3>
	</div>
	    <ul class="list-group">
	      <li class="list-group-item">
  			<p style="text-align:left;">
  				<span style="font-weight:bold;">followers</span>&nbsp;&nbsp;&nbsp;
  				<span style="color: #E03FC6; font-weight:bold;">${count}</span>
  			</p>
  				<table class="table table-condensed">
  					<tr class="warning" style="text-align:center">
  						<td class="nickNameFont">닉네임</td>
		     		</tr>
  					<c:choose>
						<c:when test="${empty friendList}">
							<tr height="10">
								<td colspan="3">
								<p align="center">
									<strong><span style="font-size: 9pt;">등록된 친구가 없습니다.</span></strong>
								</p>
								</td>
							</tr>
						</c:when>
					</c:choose>
  						<c:forEach var="friend" items="${friendList}">
							<tr>
								<td style="text-align:center;"><a style="font-weight: bold;" href="${contextPath}/board/myWall.do?id_2=${friend.id_2}">${friend.nickname}</a></td>					
							</tr>
						</c:forEach>
						<tr align="right">
							<td><button class="btn btn-warning" onclick="location.href='${contextPath}/timeLine/friendListDetail.do'">Detail</button></td>
						</tr>
  				</table>
 	 	</li>
	    </ul>
	</div>
</div>  
</body>
</html>