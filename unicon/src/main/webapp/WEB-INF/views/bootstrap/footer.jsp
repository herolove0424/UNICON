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
<meta content='width=device-width, initial-scale=1.0, shrink-to-fit=no'
	name='viewport' />

<!-- Bootstrap core CSS -->
<link href="${contextPath}/resources/css/material-kit.min.css?v=2.0.7"
	rel="stylesheet" />
<link href="${contextPath}/resources/css/modern-business.css"
	rel="stylesheet">

<!-- Fonts and icons -->
<link rel="stylesheet" type="text/css"
	ref="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
</head>
<body>
	<footer class="footer" data-background-color="black">
		<div class="container">
			<div class="copyright float-center">
				&copy;
				<script>
					document.write(new Date().getFullYear())
				</script>
				, made by 
				<i class="fas fa-horse-head"></i>
				Team Unicon Project
			</div>
		</div>
	</footer>
</body>

<!--   Core JS Files   -->
<script src="${contextPath}/resources/js/core/jquery.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/core/popper.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
<script src="${contextPath}/resources/js/plugins/moment.min.js"></script>

<!--	Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
<script src="${contextPath}/resources/js/plugins/bootstrap-datetimepicker.js" type="text/javascript"></script>

<!--  Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
<script src="${contextPath}/resources/js/plugins/nouislider.min.js" type="text/javascript"></script>

<!-- Place this tag in your head or just before your close body tag. -->
<script async defer src="https://buttons.github.io/buttons.js"></script>

<!-- Control Center for Material Kit: parallax effects, scripts for the example pages etc -->
<script src="${contextPath}/resources/js/material-kit.js?v=2.0.4" type="text/javascript"></script>

</html>