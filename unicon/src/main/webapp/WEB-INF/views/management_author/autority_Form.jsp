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
<title>권한 관리</title>
<style type="text/css">
	.searchModal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 10; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }

    /* Modal Content/Box */
    .search-modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 15% from the top and centered */
        padding: 20px;
        border: 1px solid #888;
        width: 40%; /* Could be more or less, depending on screen size */
    }
</style>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" charset="UTF-8">
//아이디 중복 여부 확인

var idState=0;
var nameState=0;
var phoneState=0;

$(function() {
	$("#checkId").blur(function() {
		var vid=$('#checkId').val();
	    var idRegExp = /^[a-zA-z0-9]{4,12}$/;
	    

		$.ajax({
			url:'${contextPath}/management/idCheck.ddun',
			type:'post',
        	data: { "id" : vid },
	        success:function(data){
	            /* console.log("1=중복 o /0=중복 x :"+data); */
	            if($.trim(data)==1){
	                $("#id_Check").html('<p style="color:red">사용중인 아이디 입니다</p>');
	                document.getElementById("authorSubmit").disabled=true;
	                idState=0;
	            }else{
	                if(vid==""){
	                	$("#id_Check").html('<p style="color:red">아이디를 입력해주세요</p>');
	                	idState=0;
	                }else if(!idRegExp.test(vid)){
	                	$("#id_Check").html('<p style="color:red">아이디가 올바르지 않습니다.</p>');
	                	idState=0;
	                }else{
	                	$("#id_Check").html('<p style="color:blue">사용 가능합니다.</p>');
	                	idState=1;
	                }
	            }
	        },
	        error:function(){
	          /*   console.log("실패"); */
	        }
		});
		
		if(idState=='1'&&nameState=='1'&&phoneState=='1'){
	    	document.getElementById("authorSubmit").disabled=false;
	    }else{
	    	document.getElementById("authorSubmit").disabled=true;
	    }
	});
});
//휴대폰 번호 중복 확인
$(function() {
	$("#checkCel").blur(function() {
		var vcel=$('#checkCel').val();

		$.ajax({
			url:'${contextPath}/management/phoneCheck.ddun',
			type:'post',
        	data: { "phone_number" : vcel },
	        success:function(data){
	           /*  console.log("1=중복 o /0=중복 x :"+data); */
	            if($.trim(data)==1){
	                $("#phone_Check").html('<p style="color:red">사용중인 휴대폰 번호 입니다</p>');
	                phoneState=0;

	            }else{
	                if(vcel==""){
	                	$("#phone_Check").html('<p style="color:red">휴대폰 번호를 입력해주세요</p>');
	                	phoneState=0;
	                }else if(vcel.length<12){
	                	$("#phone_Check").html('<p style="color:red">휴대폰 번호가 명확하지 않습니다</p>');
	                	phoneState=0;
	                }else{
	                	$("#phone_Check").html('<p style="color:blue">사용 가능합니다.</p>');
	                	phoneState=1;
	                }
	            }
	        },
	        error:function(){
	            /* console.log("실패"); */
	        }
		});
		
		if(idState=='1'&&nameState=='1'&&phoneState=='1'){
	    	document.getElementById("authorSubmit").disabled=false;
	    }else{
	    	document.getElementById("authorSubmit").disabled=true;
	    }
		
	});
});

$(function() {
	$("#checkName").blur(function() {
		var vname=$("#checkName").val();
		if(vname==""){
			$("#name_Check").html('<p style="color:red">이름을 입력해주세요</p>');
			nameState=0;
		}else{
			$("#name_Check").html('<p style="color:red"></p>');
			//document.getElementById("authorSubmit").disabled=false;
			nameState=1;
		}
		
		if(idState=='1'&&nameState=='1'&&phoneState=='1'){
	    	document.getElementById("authorSubmit").disabled=false;
	    }else{
	    	document.getElementById("authorSubmit").disabled=true;
	    }
	})
});

function inputPhoneNumber(obj) {
    var number = obj.value.replace(/[^0-9]/g, "");
    var phone = "";

    if(number.length < 4) {
        return number;
    } else if(number.length < 7) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3);
    } else if(number.length < 11) {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 3);
        phone += "-";
        phone += number.substr(6);
    } else {
        phone += number.substr(0, 3);
        phone += "-";
        phone += number.substr(3, 4);
        phone += "-";
        phone += number.substr(7);
    }
    obj.value = phone;
}

	$(function() {
		$("#checkGrade").click(function() {
			if(idState=='1'&&nameState=='1'&&phoneState=='1'){
		    	document.getElementById("authorSubmit").disabled=false;
		    }else{
		    	document.getElementById("authorSubmit").disabled=true;
		    }
		});
	});


</script>

<script type="text/javascript" charset="UTF-8">
$(function() {
	$("#authorSubmit").click(function() {
		if(confirm("관리자 계정을 생성하시겠습니까?")){
			/* console.log("관리자 권한 생성"); */
			
			
			$(function(){
				var popwidth='500';
				var popheight='150';
				var leftPos = '800';
				var topPos='300';
				var winName='권한 생성';
				var features = 'left='+ leftPos+', top='+ topPos;
		        features  += ',location=no, directories=no, menubar=no, scrollbars=auto';
		        features  += ',width='+ popwidth+ ',height='+ popheight;
		        
				
				window.open("",winName,features);
			    
			    var frmData=document.fn_Author_Form;
			    frmData.target=winName;
			    frmData.action="${contextPath}/management/confirm_Form.ddun";
			    frmData.submit();
				
			});
			
			/* $("#checkId").val("");
			$("#checkName").val("");
			$("#checkCel").val("");
			$("#checkGrade").val("");
			$("#name_Check").html("");
			$("#phone_Check").html("");
			$("#id_Check").html(""); */
			
		}else{
			/* console.log("관리자 권한 생성 실패"); */
			$("#checkId").val("");
			$("#checkName").val("");
			$("#checkCel").val("");
			$("#checkGrade").val("");
			$("#name_Check").html("");
			$("#phone_Check").html("");
			$("#id_Check").html("");
			}
	})
});
	
	$(function(){
	    
		getAuthorList();
	    
	});
	
	function getAuthorList() {
		$.ajax({
			type:'post',
			url:"<c:url value='/management/authorList.ddun' />",
			dataType:"json",
			data:$("#fn_Author_Form").serialize(),
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success: function(data){
				var html="";
				var cCnt=data.length;
				if(data.length>0){
					for(i=0;i<data.length;i++){
						html += "<div>";
	                    html += "<div><table class='table'>";
	                    html += "<tr><td width='20%' id='vid'>"+data[i].id+"</td>";
	                    html += "<td width='20%'>"+data[i].name+"</td>";
	                    html += "<td width='20%'>"+data[i].email+"</td>";
	                    html += "<td width='20%'>"+data[i].joindate+"</td>";
	                    html += "<td width='10%' id='gradeTD"+i+"'>"+data[i].grade+"</td>";
	                    html += "<td><select id='modGradeTD"+i+"' name='grade' style='display: none;' disabled>"
	                    html += "<option value='1'>등급 1 : Manager"
	                    html += "<option value='2'>등급 2 : Master </select></td>"
 	                    html += "<td width='5%'><input type='button' value='수정하기' id='begindModTD"+i+"' class='btn btn-default btn-sm btn-fill' onclick='startModifi(this.form,"+i+")'></td>";
 	                   	html += "<td width='5%'><input type='button' value='수정 반영하기' id='endModTD"+i+"' class='btn btn-default btn-sm btn-fill' style='display: none;' onclick='checkPassword(this.form,"+JSON.stringify(data[i].id)+","+i+")'></td>"; 
 	                    html += "<td width='5%' id='removeTD"+i+"'><input type='button' value='삭제' class='btn btn-default btn-sm btn-fill' onclick='checkPassword2(this.form,"+JSON.stringify(data[i].id)+")'></td>"; 
	                    html += "</tr>"
	                    html += "</table></div>";
	                    html += "</div>";
					}
				}else{	
					 html += "<div>";
		             html += "<div><table class='table'><h6><strong>등록된 관리자 계정이 없습니다.</strong></h6>";
		             html += "</table></div>";
		             html += "</div>";
				}
				
				$("#authorList").html(html);
				
			},
			error:function(request,status,error){
	            
		       }
			
		});
	}
	
	function actionModifi() {
		var vid=$('input[name=modalId]').val();
    	var valueByPw=$('input[name=checkPassword]').val();
    	var num=$('input[name=modalNum]').val();
    	var grade=document.getElementById("modGradeTD"+num).value;
    	
		if(confirm(vid+"의 권한을 "+grade+"로 변경하시겠습니까?")){
			$.ajax({
				url:'${contextPath}/management/modifyAuthor.ddun',
				type:'post',
	        	data: { 'id' : vid, 'grade' : grade, 'password' : valueByPw },
	        	success:function(data){
	        		if(data=="success") alert("변경 성공");
	        		getAuthorList();
	        	},
	        	error:function(){
	        		if(data=="failed") {
	        			alert("변경에 실패했습니다. 다시 시도해주세요");
	        		}else if(data=="none"){
	        			alert("비밀번호가 맞지 않습니다.");
	        		}
	        		getAuthorList();
	        	}
			});
			
		}
		
		$("#checkPassword").val("");
		closeModal();
		
	}
	
	function removeAuthor(vid) {
		var vid=$('input[name=modalId]').val();
    	var valueByPw=$('input[name=checkPassword2]').val();
    	
		if(confirm(vid+"관리자 계정을 삭제하시겠습니까?")){
			$.ajax({
				url:'${contextPath}/management/removeAuthor.ddun',
				type:'post',
	        	data: { 'id' : vid,'password' : valueByPw },
	        	success:function(data){
	        		if(data=="success") alert("삭제 성공");
	        		getAuthorList();
	        	},
	        	error:function(){
	        		if(data=="failed"){
	        			alert("삭제에 실패했습니다. 다시 시도해주세요");
	        		}else if(data=="none"){
	        			alert("비밀번호가 맞지 않습니다.");
	        		}
	        		getAuthorList();
	        	}
			});
			
		}
		
		$("#checkPassword2").val("");
		closeModal();
		
	}
	
	function startModifi(obj,num) {
		/* document.getElementById("gradeTD"+num).style.display="none"; */
		document.getElementById("modGradeTD"+num).style.display="block";
		document.getElementById("modGradeTD"+num).disabled=false;
		
		document.getElementById("begindModTD"+num).style.display="none";
		document.getElementById("endModTD"+num).style.display="block";
		
	}
	
	function checkPassword(obj,vid,num) {
        $("#modal").show();
        $("#checkPassword").html("");
        $("#modalId").val(vid);
        $("#modalNum").val(num);
    }
	
	function checkPassword2(obj,vid) {
        $("#modal2").show();
        $("#checkPassword2").html("");
        $("#modalId").val(vid);
    }
	
	function closeModal() {
	    $('.searchModal').hide();
	 };
	
	function backFunction() {
		var form=document.createElement("form");
        form.method="post";
		form.action="${contextPath }/management/main.ddun";
		document.body.appendChild(form);
		form.submit();
	}

</script>
</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>

	<div class="content">
<!-- 	<h3><strong>권한 관리</strong></h3> -->
		<form name="fn_Author_Form" id="fn_Author_Form" method="post">
			<table class="table">
				<tr class="table-primary" align="center">
					<td><strong>계정</strong></td>
					<td><strong>이름</strong></td>
					<td><strong>휴대폰</strong></td>
					<td><strong>권한</strong></td>
					<td><strong>등록</strong></td>
				</tr>

				<tr class="table-light" align="center">
					<td><input type="text" name="id" id="checkId" class="form-control"></td>
					<td><input type="text" name="name" id="checkName" class="form-control"></td>
					<td><input type="tel" name="phone_number" id="checkCel"
						onKeyup="inputPhoneNumber(this);" maxlength="13"
						style="text-align: center;" class="form-control" /></td>
					<td><select name="grade" id="checkGrade" class="form-control">
							<option value="1">Manager</option>
							<option value="2">Master</option>
					</select></td>
					<td><input type="button" class="btn btn-primary btn-fill" value="설정" id="authorSubmit"></td>
				</tr>

				<tr  align="center">
					<td><div id="id_Check"></div></td>
					<td><div id="name_Check"></div></td>
					<td><div id="phone_Check"></div></td>
					<td></td>
					<td></td>
				</tr>


			</table>


		</form>

		<div class="container">
			<form id="authorListForm" name="authorListForm" method="post">
				<div id="authorList"></div>
			</form>
		</div>

		<div id="modal" class="searchModal">
			<div class="search-modal-content">
				<div class="page-header">
					<h1><strong>경고</strong></h1>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12">
								<h3>권한 변경 : 비밀번호를 입력해주세요</h3>
								<input type="password" id="checkPassword" name="checkPassword" class="form-control" placeholder="PASSWORD">
								<input type="hidden" name="modalId" id="modalId"> 
								<input type="hidden" name="modalNum" id="modalNum">
							</div>
						</div>
					</div>
				</div>
				<hr>

				<div
					style="cursor: pointer; background-color: #f76767; text-align: center; padding-bottom: 10px; padding-top: 10px;"
					onClick="actionModifi();">
					<span class="pop_bt modalCloseBtn" style="font-size: 13pt;">
						변경 </span>
				</div>
				<br>
				<div
					style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
					onClick="closeModal();">
					<span class="pop_bt modalCloseBtn" style="font-size: 13pt;">
						취소 </span>
				</div>
			</div>
		</div>

		<div id="modal2" class="searchModal">
			<div class="search-modal-content">
				<div class="page-header">
					<h1><strong>경고</strong></h1>
				</div>
				<div class="row">
					<div class="col-sm-12">
						<div class="row">
							<div class="col-sm-12">
								<h3>권한 변경 : 비밀번호를 입력해주세요</h3>
								<input type="password" id="checkPassword2" name="checkPassword2" class="form-control"  placeholder="PASSWORD">
								<input type="hidden" name="modalId" id="modalId">
							</div>
						</div>
					</div>
				</div>
				<hr>

				<div
					style="cursor: pointer; background-color: #f76767; text-align: center; padding-bottom: 10px; padding-top: 10px;"
					onClick="removeAuthor();">
					<span class="pop_bt modalCloseBtn" style="font-size: 13pt;">
						변경 </span>
				</div>
				<br>
				<div
					style="cursor: pointer; background-color: #DDDDDD; text-align: center; padding-bottom: 10px; padding-top: 10px;"
					onClick="closeModal();">
					<span class="pop_bt modalCloseBtn" style="font-size: 13pt;">
						취소 </span>
				</div>
			</div>
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