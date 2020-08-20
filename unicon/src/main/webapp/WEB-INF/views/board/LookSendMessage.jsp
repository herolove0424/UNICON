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
<title></title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
$(function(){
    
	getSendList();
    
});

function getSendList() {
	$.ajax({
		type:'get',
		url:"<c:url value='/message/lookSendMessageList.do' />",
		dataType:"json",
		//data:$("#fn_Author_Form").serialize(),
		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
		success: function(data){
			var html="";
			var cCnt=data.length;
			if(data.length>0){
				html += "<div>";
                html += "<div align='center'><table class='table'>";
                html += "<tr align='center'><td>#</td>";
                html += "<td>받은 사람</td>";
                html += "<td>제목</td>";
                html += "<td>발신일</td>";
                html += "<td>확인</td>";
                html += "</tr>";
				for(i=0;i<data.length;i++){
					
					if(data[i].readyn==1){
						html += "<tr align='center'><td><input type='checkbox' name='delCheck' value='"+data[i].messagenum+"'></td>";
						html += "<td>"+data[i].id+"</td>";
	                    html += "<td><a href='${contextPath }/message/detailSendMessage.do?messagenum="+data[i].messagenum+"'>"+data[i].title+"</a></td>";
	                    html += "<td>"+data[i].sendday+"</td>";
	                    html += "<td>안읽음</td>";
	                    html += "</tr>"
					}else{
						html += "<tr align='center'><td><input type='checkbox' name='delCheck' value='"+data[i].messagenum+"'></td>";
						html += "<td>"+data[i].id+"</td>";
	                    html += "<td><a href='${contextPath }/message/detailSendMessage.do?messagenum="+data[i].messagenum+"'>"+data[i].title+"</a></td>";
	                    html += "<td>"+data[i].sendday+"</td>";
	                    html += "<td>읽음</td>";
	                    html += "</tr>"
					}
					
				}
				
				html += "</table></div>";
                html += "</div>";
			}else{	
				 html += "<div>";
	             html += "<div align='center'><table class='table'><hr><h6><strong>보낸 메세지가 없습니다.</strong></h6><hr>";
	             html += "</table></div>";
	             html += "</div>";
			}
			
			$("#sendList").html(html);
			
		},
		error:function(request,status,error){
            
	       }
		
	});
}

function delMessages() {
	var checkArr=[];
	var values = $('input:checkbox[name=delCheck]:checked').length;
	console.log(values);
	 $("input[name=delCheck]:checked").each(function() {
		 checkArr.push($(this).val());
	});
	 
	 $.ajax({
	        url: "<c:url value='/message/delSendMessages.do' />"
	        , type: 'get'
	        , data: {
	            valueArrTest: checkArr
	        },
	        success:function(data){
				 if(data=="success"){
					console.log("내가 보낸 메세지 삭제 완료");
					//location.href = location.href;
					getSendList();
				} 
				 
			},
			error:function(data){
				if(data=="error"){
					console.log("내가 보낸 메세지 삭제 실패");
					//location.href = location.href;
					getSendList();
				}
				
	        }
			
	    });

}

</script>
<style type="text/css">
.sans {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
</head>
<body>
	<div class="container" align="right">
	<br>
		<h3 class="sans" align="left">보낸 쪽지함</h3>		
		<div id="sendList">
		</div>
		<button class="btn btn-default btn-round" type="button" onclick="delMessages()">
			<i class="material-icons">clear</i>&nbsp;&nbsp;삭제
		</button>
	</div>
</body>
</html>