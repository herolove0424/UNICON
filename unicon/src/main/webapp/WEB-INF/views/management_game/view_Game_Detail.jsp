<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%-- <c:set var="forpaging" value="${for_Back_List_Function }"/> --%>

<%
   request.setCharacterEncoding("UTF-8");
	
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<!-- CSS Files -->

 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.0/minty/bootstrap.min.css">
<link href="${contextPath}/resources/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
 <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="${contextPath}/resources/css/demo.css" rel="stylesheet" />
<title>게임 상세 정보</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function fn_enable_Modify(obj) {
		document.getElementById("tr_btn_modyfy").style.display="block";
		
		document.getElementById("i_age").disabled=false;
		document.getElementById("i_play_type").disabled=false;
		document.getElementById("i_min_system").disabled=false;
		document.getElementById("i_recommen_system").disabled=false;
		document.getElementById("i_content").disabled=false;
		document.getElementById("i_link_1").disabled=false;
		document.getElementById("i_link_2").disabled=false;
		document.getElementById("i_link_3").disabled=false;
		document.getElementById("i_link_4").disabled=false;
		document.getElementById("i_hash_tag").disabled=false;
		document.getElementById("i_hash_tag2").disabled=false;
		document.getElementById("i_hash_tag3").disabled=false;
		
		document.getElementById("i_NewLogoName").disabled=false;
		document.getElementById("i_NewLogoName").style.display="block";
		document.getElementById("i_link_2").style.display="block";
		document.getElementById("i_link_2_2").style.display="none";
		
		document.getElementById("i_NewContentName1").disabled=false;
		document.getElementById("i_NewContentName2").disabled=false;
		document.getElementById("i_NewContentName3").disabled=false;
		
	}
	
	function fn_Modify_Game_Info(searchType,currentPageNo,recordsPerPage,searchKeyword) {
		/* obj.action="${contextPath}/management/modGameInfo.ddun";
		obj.submit(); */
		
		//var form=document.createElement("form");
		var form=document.ftmGameInfo;
		form.setAttribute("method","post");
		form.setAttribute("action","${contextPath}/management/modGameInfo.ddun");		
		
		var searchTypeInput=document.createElement("input");
		searchTypeInput.setAttribute("type","hidden");
		searchTypeInput.setAttribute("name","searchType");
		searchTypeInput.setAttribute("value",searchType);
		
		var currentPageNoInput=document.createElement("input");
		currentPageNoInput.setAttribute("type","hidden");
		currentPageNoInput.setAttribute("name","currentPageNo");
		currentPageNoInput.setAttribute("value",currentPageNo);
		
		var recordsPerPageInput=document.createElement("input");
		recordsPerPageInput.setAttribute("type","hidden");
		recordsPerPageInput.setAttribute("name","recordsPerPage");
		recordsPerPageInput.setAttribute("value",recordsPerPage);
		
		var searchKeywordInput=document.createElement("input");
		searchKeywordInput.setAttribute("type","hidden");
		searchKeywordInput.setAttribute("name","searchKeyword");
		searchKeywordInput.setAttribute("value",searchKeyword);
		
		form.appendChild(searchTypeInput);
		form.appendChild(currentPageNoInput);
		form.appendChild(recordsPerPageInput);
		form.appendChild(searchKeywordInput);
		document.body.appendChild(form);
		
		form.submit();
	}
	
	function reflesh(obj) {
		history.go(0)
	}
	
	

</script>

<script type="text/javascript">
	function readURL(input,noshow,show) {
		document.getElementById(noshow).style.display="none"; 
		document.getElementById(show).style.display="block"; 
		
		if(input.files && input.files[0]){
			var reader=new FileReader();
			reader.onload=function(e){
				$("#"+show).attr('src',e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function backToList(url,searchType,currentPageNo,recordsPerPage,searchKeyword) {
		var form=document.createElement("form");
		form.setAttribute("method","get");
		form.setAttribute("action",url);
		
		var searchTypeInput=document.createElement("input");
		searchTypeInput.setAttribute("type","hidden");
		searchTypeInput.setAttribute("name","searchType");
		searchTypeInput.setAttribute("value",searchType);
		
		var currentPageNoInput=document.createElement("input");
		currentPageNoInput.setAttribute("type","hidden");
		currentPageNoInput.setAttribute("name","currentPageNo");
		currentPageNoInput.setAttribute("value",currentPageNo);
		
		var recordsPerPageInput=document.createElement("input");
		recordsPerPageInput.setAttribute("type","hidden");
		recordsPerPageInput.setAttribute("name","recordsPerPage");
		recordsPerPageInput.setAttribute("value",recordsPerPage);
		
		var searchKeywordInput=document.createElement("input");
		searchKeywordInput.setAttribute("type","hidden");
		searchKeywordInput.setAttribute("name","searchKeyword");
		searchKeywordInput.setAttribute("value",searchKeyword);
		
		form.appendChild(searchTypeInput);
		form.appendChild(currentPageNoInput);
		form.appendChild(recordsPerPageInput);
		form.appendChild(searchKeywordInput);
		document.body.appendChild(form);
		
		form.submit();
		
	}
	
	function fn_remove_Game_Info(url,game_code) {
		var form=document.createElement("form");
		form.setAttribute("method","post");
		form.setAttribute("action",url);
		
		var game_codeInput=document.createElement("input");
		game_codeInput.setAttribute("type","hidden");
		game_codeInput.setAttribute("name","game_code");
		game_codeInput.setAttribute("value",game_code);
		
		form.appendChild(game_codeInput);
		document.body.appendChild(form);
		
		form.submit();
	}

</script>

<style type="text/css">
	#i_link_2_mody {display: none;}
</style>
</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content" align="center" style="clear: both;">
	<form name="ftmGameInfo" method="post" action="${contextPath }" enctype="multipart/form-data" >
	<table class="table table-condensed">
	
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>게임 로고</strong></span></td>
		<td>
			<input type="hidden" name="originalLogoName" value="${detail_Image_Logo_Info.imagefilename}" />
			<img id="i_logo_Image_preview" class="img-circle" alt="" src="#" width="400" height="400" style="display: none;">
			<img alt="" src="${contextPath }/management/download.ddun?
			imagefilename=${detail_Image_Logo_Info.imagefilename}&game_code=${detail_Game_Info.game_code}" id="i_logo_Image" class="img-circle" alt=""	 style="display: block;" width="443" height="500"/><br>
		</td>
		<td><input type="file" name="NewLogoName" id="i_NewLogoName"  style="display: none;" onchange="readURL(this,'i_logo_Image','i_logo_Image_preview');"></td>
	</tr>
	
	
	
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>게임 코드</strong></span></td>
		<td>
			<input type="text" id="i_game_code" value="${detail_Game_Info.game_code }" class="form-control" disabled="disabled"  />
			<input type="hidden" name="game_code" value="${detail_Game_Info.game_code }" />
		</td>
	</tr>
	
	<tr>
		<td align="center" ><span style="color: #172b4d;"><strong>게임 이름</strong></span></td>
		<td><input type="text" style="display: " value="${detail_Game_Info.game_name }" name="game_name" class="form-control" disabled /></td>
	</tr>
	
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>대분류</strong></span></td>
		<td>
			<input type="text" value="${detail_Game_Info.big_category }" name="big_category" class="form-control" disabled />
		</td>
	</tr>
	
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>게임 스타일</strong></span></td>
		<td>
			
			<select id="i_play_type" name="play_type" disabled="disabled" class="form-control">
					<option value="null" ${detail_Game_Info.play_type eq "null" ? "selected" :""}>미정
					<option value="싱글" ${detail_Game_Info.play_type eq "싱글" ? "selected" :""}>싱글
					<option value="멀티" ${detail_Game_Info.play_type eq "멀티" ? "selected" :""}>멀티
			</select>
			
		</td>
	</tr>
	
	<tr>
		<td width="20%" align="center" ><span style="color: #172b4d;"><strong>소분류</strong></span></td>
		<td>
			<input type="text" value="${detail_Game_Info.small_category }" name="small_category" class="form-control" disabled />
		</td>
	</tr>
	
	<tr>
		<td width="20%" align="center" ><span style="color: #172b4d;"><strong>장르</strong></span></td>
		<td>
			<input type="text" value="${detail_Game_Info.genre }" name="genre" class="form-control" disabled />
		</td>
	</tr>
	
	<tr>
		<td width="20%" align="center" ><span style="color: #172b4d;"><strong>발매일</strong></span></td>
		<td>
			<input type="text" value="${detail_Game_Info.release_date }" name="release_date" class="form-control" disabled />
		</td>
	</tr>
	
	<tr>
		<td width="20%" align="center" ><span style="color: #172b4d;"><strong>가격</strong></span></td>
		<td>
			<input type="text" value="${detail_Game_Info.price }" name="price" class="form-control" disabled />
		</td>
	</tr>
	
	<tr>
		<td width="20%" align="center"><span style="color: #172b4d;"><strong>등급</strong></span></td>
		<td>
			<input type="text" id="i_age" value="${detail_Game_Info.age }" name="age" class="form-control" disabled />
		</td>
	</tr>
	
	<tr>
		<td width="20%" align="center"><span style="color: #172b4d;"><strong>최소 사양</strong></span></td>
		<td>
			<textarea name="min_system" id="i_min_system" class="form-control" 
			rows="3" disabled="disabled">${detail_Game_Info.min_system }</textarea>
		</td>
	</tr>
		
	<tr>
		<td width="20%" align="center" ><span style="color: #172b4d;"><strong>권장 사양</strong></span></td>
		<td>
			<textarea name="recommen_system" id="i_recommen_system" class="form-control" 
			rows="3" disabled="disabled">${detail_Game_Info.recommen_system }</textarea>
<%-- 			<input type="text" id="i_recommen_system" value="${detail_Game_Info.recommen_system }" name="recommen_system" disabled /> --%>
		</td>
	</tr>
	
	<tr>
		<td width="20%" align="center"><span style="color: #172b4d;"><strong>등록일</strong></span></td>
		<td>
			<input type="text" value="${detail_Game_Info.registered_date }" name="registered_date" class="form-control"  disabled />
		</td>
	</tr>
	
	<tr>
		<td width="20%" align="center"><span style="color: #172b4d;"><strong>제작사</strong></span></td>
		<td>
			<input type="text" value="${detail_Game_Info.menufacture }" name="menufacture" class="form-control"  disabled />
		</td>
	</tr>
	
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>배급사</strong></span></td>
		<td>
			<input type="text" value="${detail_Game_Info.share_company }" name="share_company" class="form-control"  disabled />
		</td>
	</tr>
	
	<tr>
		<td  align="center"><span style="color: #172b4d;"><strong>게임 소개</strong></span></td>
		<td>
			<textarea name="content" id="i_content" class="form-control" rows="3" 
			disabled="disabled">${detail_Game_Info.content }</textarea>
		</td>
	</tr>
	
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>공식 사이트(link1)</strong></span></td>
		<td>
			<input type="text" id="i_link_1" value="${detail_Game_Info.link_1 }" name="link_1" class="form-control" disabled />
		</td>
	</tr>
	
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>게임 영상(link2)</strong></span></td>
		<td >
			<textarea name="link_2"  id="i_link_2" style="display: none;" class="form-control" 
			rows="3" disabled="disabled">${detail_Game_Info.link_2 }</textarea>
			<span id="i_link_2_2" style="display: block;">${detail_Game_Info.link_2 }</span>
		</td>
	</tr>
	
	<tr>
		<td  align="center"><span style="color: #172b4d;"><strong>게임 설치/구매(공식 사이트/구글 플레이)(link3)</strong></span></td>
		<td>
			<input type="text" id="i_link_3" value="${detail_Game_Info.link_3 }" name="link_3" class="form-control" disabled />
		</td>
	</tr>
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>게임 설치/구매(ios)(link4)</strong></span></td>
		<td>
			<input type="text" id="i_link_4" value="${detail_Game_Info.link_4 }" name="link_4" class="form-control" disabled />
		</td>
	</tr>
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>해시태그 #1</strong></span></td>
		<td>
			<input type="text" id="i_hash_tag" value="${detail_Game_Info.hash_tag }" name="hash_tag" class="form-control" disabled />
		</td>
	</tr>
	<tr>
		<td  align="center"><span style="color: #172b4d;"><strong>해시태그 #2</strong></span></td>
		<td>
			<input type="text" id="i_hash_tag2" value="${detail_Game_Info.hash_tag2 }" name="hash_tag2" class="form-control" disabled />
		</td>
	</tr>
	<tr>
		<td align="center"><span style="color: #172b4d;"><strong>해시태그 #3</strong></span></td>
		<td>
			<input type="text" id="i_hash_tag3" value="${detail_Game_Info.hash_tag3 }" name="hash_tag3" class="form-control" disabled />
		</td>
	</tr>
	
	<c:forEach var="item" items="${detail_Image_Info }" varStatus="status">
	<tr >
		<td align="center"><span style="color: #172b4d;"><strong>이미지 ${status.count }</strong></span></td>
		<td>
		<input type="hidden" name="originalContentName${status.count }" value="${item.imagefilename}" />
		<img id="i_Content_Image_preview${status.count }" alt=" " src="#" width="200" height="200" style="display: none;">
		<img alt=" " src="${contextPath }/management/download.ddun?imagefilename=${item.imagefilename}&game_code=${detail_Game_Info.game_code}" 
				width="443" height="500" id="i_Content_Image${status.count }"/><br>
		</td>
		<td><input type="file" name="NewContentName${status.count }" id="i_NewContentName${status.count }" disabled="disabled" onchange="readURL(this,'i_Content_Image${status.count }','i_Content_Image_preview${status.count }');"></td>
	</tr>
	</c:forEach>
	
	
	<tr id="tr_btn_modyfy" style="display: none;">
		<td colspan="2" align="center">
			<input type="button" value="수정반영하기" onclick="fn_Modify_Game_Info('${for_Back_List_Function[2] }','${for_Back_List_Function[0]}','${for_Back_List_Function[1]}','${for_Back_List_Function[3]}')">
			<input type="button" value="취소" onclick="reflesh(ftmGameInfo)">
		</td>
	</tr>
	
	<tr id="tr_btn">
		<td>
			<input type="button" value="수정하기" onclick="fn_enable_Modify(this.form)" />&nbsp;
			<input type="button" value="삭제하기" onclick="fn_remove_Game_Info('${contextPath}/management/remove_Game_Info.ddun',${detail_Game_Info.game_code })" />&nbsp;
			<input type="button" value="목록" onclick="backToList('${contextPath }/management/gamelist.ddun','${for_Back_List_Function[2] }','${for_Back_List_Function[0]}','${for_Back_List_Function[1]}','${for_Back_List_Function[3]}')">
		
		</td>
	
	</tr>
	
	
	</table>
	
	</form>
	</div>
	</div>
	</div>

</body>
<!--   Core JS Files   -->
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="${contextPath}/resources/js/bootstrap-switch.js"></script>
<!--  Chartist Plugin  -->
<script src="${contextPath}/resources/js/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="${contextPath}/resources/js/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script
	src="${contextPath}/resources/js/light-bootstrap-dashboard.js?v=2.0.0 "
	type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="${contextPath}/resources/js/demo.js"></script>
</html>