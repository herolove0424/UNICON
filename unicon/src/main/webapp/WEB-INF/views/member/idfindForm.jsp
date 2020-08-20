<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<c:set var="isLogOn" value="${param.isLogOn }" />
<c:set var="result" value="${param.result }" />
<%
   request.setCharacterEncoding("UTF-8");
%>

   
<!DOCTYPE html>
<html>
<head>
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

<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
 <c:choose>
    <c:when test="${result=='notfindid'}">
      <script>
         window.onload=function() {
            alert("찾으시는 아이디가 존재하지 않습니다.")
         }
      </script>
      </c:when>
</c:choose>
</head>
<body>

<div class="col-lg-4 col-md-6 mx-auto">
            <div class="card card-login">
              <form class="form" action="${contextPath}/member/idfind.do">
                <div class="card-header card-header-info text-center">
                  <h4 class="card-title">아이디 찾기</h4>
                </div>
                <div class="card-body">
                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="material-icons">face</i>
                      </span>
                    </div>
                    <input type="text" class="form-control" placeholder="이름" name="name" id="name">
                  </div>
                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text">
                        <i class="material-icons">mail</i>
                      </span>
                    </div>
                    <input type="email" class="form-control" placeholder="E-mail" name="email" id="email">
                  </div>
                </div>
                <div class="footer text-center">
				 <button type="submit" class="btn btn-primary btn-link btn-wd btn-lg">확인</button>
                  <button type="reset" class="btn btn-primary btn-link">
                  <i class="fa fa-refresh fa-spin fa-3x fa-fw"></i>다시 입력
                  </button>
                </div>
              </form>
            </div>
          </div>
</body>
     <jsp:include page="../bootstrap/footer.jsp"/>
</html>
