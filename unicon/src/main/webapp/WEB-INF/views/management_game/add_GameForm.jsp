<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />

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
<title>게임 등록</title>
<style>
        #contentPreview img {
            width: 400px;
            height: 400px;
        }
        #contentPreview p {
            text-overflow: ellipsis;
            overflow: hidden;
        }
        .preview-box {
            border: 1px solid;
            border-color: #dee2e6;
            padding: 5px;
            border-radius: 2px;
            margin-bottom: 10px;
        }
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>

<script>
    //임의의 file object영역
    var files = {};
    var previewIndex = 0;

    // image preview 기능 구현
    // input = file object[]
    function addPreview(input) {
    	files = {};
        $("#contentPreview").empty();
        if (input[0].files) {
            //파일 선택이 여러개였을 시의 대응
            for (var fileIndex = 0; fileIndex < input[0].files.length; fileIndex++) {
                var file = input[0].files[fileIndex];

                if (validation(file.name))
                    continue;

                var reader = new FileReader();
                reader.onload = function(img) {
                    //div id="preview" 내에 동적코드추가.
                    //이 부분을 수정해서 이미지 링크 외 파일명, 사이즈 등의 부가설명을 할 수 있을 것이다.
                    var imgNum = previewIndex++;
                    $("#contentPreview")
                            .append(
                                    "<div class=\"preview-box\" value=\"" + imgNum +"\">"
                                            + "<img class=\"thumbnail\" src=\"" + img.target.result + "\"\/>"
                                            + "<p>"
                                            + file.name
                                            + "</p>"
                                            + "<a href=\"#\" value=\""
                                            + imgNum
                                            + "\" onclick=\"deletePreview(this)\">"
                                            + "삭제" + "</a>" + "</div>");
                    files[imgNum] = file;
                };
                reader.readAsDataURL(file);
            }
        } else
            alert('이미지 첨부를 취소했습니다.'); 
    }

    //preview 영역에서 삭제 버튼 클릭시 해당 미리보기이미지 영역 삭제
    function deletePreview(obj) {
        var imgNum = obj.attributes['value'].value;
        delete files[imgNum];
        $("#contentPreview .preview-box[value=" + imgNum + "]").remove();
        resizeHeight();
    }

    //client-side validation
    //always server-side validation required
    function validation(fileName) {
        fileName = fileName + "";
        var fileNameExtensionIndex = fileName.lastIndexOf('.') + 1;
        var fileNameExtension = fileName.toLowerCase().substring(
                fileNameExtensionIndex, fileName.length);
        if (!((fileNameExtension === 'jpg')
                || (fileNameExtension === 'gif') ||(fileNameExtension === 'jpeg') || (fileNameExtension === 'png'))) {
            alert('jpg, gif, png 확장자만 업로드 가능합니다.');
            return true;
        } else {
            return false;
        }
    }

     $(document).ready(function() {
        $('#multiattach input[type=file]').change(function() {
            addPreview($(this)); //preview form 추가하기
        });
    }); 

    
</script>

<script>
    function backToList() {
			/* obj.action="${contextPath}/management/gamelist.ddun";
			obj.submit(); */
			location.href='${contextPath}/management/gamelist.ddun';
		}
		
	function readURL(input) {
			if(input.files && input.files[0]){
				var reader=new FileReader();
				reader.onload=function(e){
					$("#preview").attr('src',e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}

    function testFunction() {
    	//유효성 검사 아직 안넣음(정상 구동하면 넣기)
        var form=document.gameAddForm;
        form.method="post";
		form.action="${contextPath }/management/game_Registe.ddun";
		form.submit();
    }
    /* -0731 김도경 추가 */
    function checkNull() {
		//유효성 검사 아직 안넣음(정상 구동하면 넣기)
		var form = document.gameAddForm;
		var genre_value = form.genre.value;
		var age_value = form.age.value;
		var menufacture_value = form.menufacture.value;
		var share_company_value = form.share_company.value;

		var game_name_value = form.game_name.value;
		var price_value = form.price.value;
		var min_system_value = form.min_system.value;

		var recommen_system_value = form.recommen_system.value;
		var content_value = form.content.value;

		if (genre_value == null || genre_value.length == 0) {
			alert("장르를 입력해주세요");
		} else if (age_value == null || age_value.length == 0) {
			alert("등급을 입력해주세요");
		} else if (menufacture_value == null || menufacture_value.length == 0) {
			alert("제작사를 입력해주세요");
		} else if (share_company_value == null
				|| share_company_value.length == 0) {
			alert("배급사를 입력해주세요");
		} else if (game_name_value == null || game_name_value.length == 0) {
			alert("게임 이름을 입력해주세요");
		} else if (price_value == null || price_value.length == 0) {
			alert("가격을 입력해주세요");
		} else if (min_system_value == null || min_system_value.length == 0) {
			alert("최소 사양을 입력해주세요");
		} else if (recommen_system_value == null
				|| recommen_system_value.length == 0) {
			alert("권장 사양을 입력해주세요");
		} else if (content_value == null || content_value.length == 0) {
			alert("내용을 입력해주세요");
		} else {
			form.method = "post";
			form.action = "${contextPath }/management/game_Registe.ddun";
			form.submit();
		}
	}
    
    //아직스
    
    $(function() {
		$("#game_name").blur(function() {
    	var form = document.gameAddForm;
    	var small_category = form.small_category.value;
    	var game_name = form.game_name.value;
    	var btn = document.getElementById('btn');
    	console.log("small_category"+small_category);
    	console.log("game_name"+game_name);
    	
    	$.ajax({
			url:'${contextPath}/management/overlapGame.ddun',
			type:'post',
        	data: {"game_name" : game_name, "small_category" : small_category },
	        success:function(data){
	            console.log("1=중복 o /0=중복 x :"+data);
	            if($.trim(data)==1){
	                $("#overlapGamename").html('<p style="color:red">선택하신 소분류 내에 동일한 게임 명이 존재합니다.</p>');
	                btn.disabled = 'disabled';
	            }else{
	                if(game_name==""){
	                	$("#overlapGamename").html('<p style="color:red">게임 명을 입력해주세요.</p>');
	                	btn.disabled = 'disabled';
	                }else{
	                	$("#overlapGamename").html('<p style="color:blue">사용 가능합니다.</p>');
	                	btn.disabled = '';
	                }
	            }
	        },
	        error:function(){
	            console.log("실패");
	        }
		});
    	
		});
    });
</script>
</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content" align="center" style="clear: both;">
		<div style="background-color: white;">
		<br>
		<br>
		
		<form name="gameAddForm" enctype="multipart/form-data">
        <table  class="table table-condensed">
        	<!-- 게임스타일 추가 -->
            <tr>
				<td style="width: 50%">분류: <select name="small_category"  class="form-control">
						<option value="PC" selected="selected">PC
						<option value="MOBILE">MOBILE
							<!-- <option value="CONSOLE"> CONSOLE -->
						<option value="SWITCH">SWITCH
						<option value="PS4">PS4
						<option value="XBOX">XBOX
				</select> 
				</td>
				<td style="width: 50%">
				게임 스타일:<select name="play_type" class="form-control">
						<option value="null" selected="selected">미정
						<option value="싱글">싱글
						<option value="멀티">멀티
				</select>
				</td>
			</tr>
            
            <tr>
            	<td colspan="2">
            	<label>Game Logo</label><br>
            	<img id="preview" class="img-circle" alt="" src="#" width="400" height="400">
            	<input type="file" name="logoImageName" onchange="readURL(this);">
            	</td>
            </tr>
            
            <tr>
                <td>장르: <input type="text" name="genre" class="form-control" ></td>   
                <td>등급: <input type="text" name="age" class="form-control" ></td>
            </tr>

           	<tr>
                <td>제작: <input type="text" name="menufacture" class="form-control"></td>
                <td>배급: <input type="text" name="share_company" class="form-control" ></td>
            </tr>


            <tr>
                <td colspan="2">게임 이름: <input type="text" name="game_name" id="game_name" class="form-control"><br>
                <div id="overlapGamename"></div>
                </td>
            </tr>

           	<tr>
                <td>발매일: <input type="date" name="st_release_date" class="form-control"></td>
                <td>가격: <input type="text" name="price" class="form-control"></td>
            </tr>

            <tr>
                <td colspan="2">최소 사양: <textarea name="min_system" class="form-control" rows="3"></textarea></td>
            </tr>

            <tr>
                <td colspan="2">권장 사양: <textarea name="recommen_system" class="form-control" rows="3"></textarea></td>
            </tr>

            <tr>
                <td colspan="2">게임 소개: <textarea name="content"  class="form-control" rows="3"></textarea></td>
            </tr>

            <tr>
                <td colspan="2">공식 사이트(link1): <input type="text" name="link_1"  class="form-control"></td>
            </tr>

            <tr>
                <td colspan="2">게임 영상(link2): <input type="text" name="link_2" class="form-control" ></td>
            </tr>

            <tr>
                <td colspan="2">게임 설치/구매(공식 사이트/구글 플레이)(link3): <input type="text" name="link_3" class="form-control"></td>
            </tr>

            <tr>
                <td colspan="2">게임 설치/구매(ios)(link4): <input type="text" name="link_4" class="form-control"></td>
            </tr>

            <tr>
                <td colspan="2">
                <label>hash tag</label><br>
                #<input type="text" name="hash_tag" class="form-control">
                #<input type="text" name="hash_tag2"  class="form-control">
                #<input type="text" name="hash_tag3"  class="form-control"></td>
            </tr>
            
        </table> 

			<div class="multiwapper" align="left">
				<!-- <div class="multiheader">
					<label>사진 첨부</label>
				</div> -->
				<div class="multibody">
					<!-- 첨부 버튼 -->
					<div id="multiattach">
						<label class="waves-effect waves-teal btn-flat"
							for="uploadInputBox" style="color: #888;">사진첨부</label> <input id="uploadInputBox"
							style="display: none" type="file" name="contentImage"
							multiple="multiple" />
					</div>

					<!-- 미리보기 영역 -->
					<div id="contentPreview" class="content"></div>

					<!-- multipart 업로드시 영역 -->
					<form id="uploadForm" style="display: none;"></form>
				</div>
			</div>

			<input type="button" id="btn" value="등록하기" onclick="checkNull()"
				disabled="disabled" />
			<!--         <input type="button" value="등록하기" onclick="testFunction()"/> -->
			<input type="button" value="돌아가기" onclick="backToList()" />


		</form>
	</div>
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
