<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%-- <c:set var="isLogOn" value="${param.isLogOn }" /> --%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<!-- CSS Files -->
<link href="${contextPath}/resources/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css">
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="${contextPath}/resources/css/demo.css" rel="stylesheet" />
<title>Management Main</title>
<style type="text/css">

</style>
<!-- <style type="text/css">
	.boardMenu a{cursor: pointer;}
	.boardMenu .hide{display: none;}
</style> -->

<!-- <script src="https://code.jquery.com/jquery-latest.min.js"></script> -->
<!-- <script type="text/javascript">
		 $(document).ready(function() {
			$(".boardMenu>a").click(function() {
				var submenu = $(this).next("ul");
				if( submenu.is(":visible") ){
					submenu.slideUp();
				}else{
					 submenu.slideDown();
				}
			});
		}); 
	
	</script> -->

</head>
<jsp:include page="../bootstrap/managersidebar.jsp"></jsp:include>
<body>
	<div class="content">
		<div class="container-fluid">
			<div class="header-body">
				<!-- Card stats -->
				<div class="row">
					<div class="col-xl-3 col-md-6">
						<div class="card card-stats">
							<!-- Card body -->
							<div class="card-body">
								<div class="row">
									<div class="col">
										<h5 class="card-title text-uppercase text-muted mb-0">Today Visitor</h5>
										<span class="h2 font-weight-bold mb-0" style="color: #f5365c;">${todayCount}</span>
									</div>
									<div class="col-auto">
										<div class="icon icon-shape bg-gradient-red text-white rounded-circle shadow">
											<i class="fas fa-chart-line"></i>
										</div>
									</div>
								</div>
								 <p class="mt-3 mb-0 text-sm">
									<span class="text-success mr-2"><i
										class="fa fa-arrow-up"></i> ${visitUpDown } %</span> <span class="text-nowrap">Since
										last day</span>
								</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card card-stats">
							<!-- Card body -->
							<div class="card-body">
								<div class="row">
									<div class="col">
										<h5 class="card-title text-uppercase text-muted mb-0">New users</h5>
										<span class="h2 font-weight-bold mb-0" style="color: #fb6340;">${newMember }</span>
									</div>
									<div class="col-auto">
										<div
											class="icon icon-shape bg-gradient-orange text-white rounded-circle shadow">
											<i class="ni ni-chart-pie-35"></i>
										</div>
									</div>
								</div>
								<p class="mt-3 mb-0 text-sm">
									<span class="text-success mr-2"><i
										class="fa fa-arrow-up"></i> ${upDown }%</span> <span class="text-nowrap">Since
										last day</span>
								</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card card-stats">
							<!-- Card body -->
							<div class="card-body">
								<div class="row">
									<div class="col">
										<h5 class="card-title text-uppercase text-muted mb-0">New Post</h5>
										<span class="h2 font-weight-bold mb-0" style="color: #2dce89;">${todayBoard }</span>
									</div>
									<div class="col-auto">
										<div
											class="icon icon-shape bg-gradient-green text-white rounded-circle shadow">
											<i class="ni ni-money-coins"></i>
										</div>
									</div>
								</div>
								<p class="mt-3 mb-0 text-sm">
									<span class="text-success mr-2"><i
										class="fa fa-arrow-up"></i> ${boardUpDown } %</span> <span class="text-nowrap">Since
										last day</span>
								</p>
							</div>
						</div>
					</div>
					<div class="col-xl-3 col-md-6">
						<div class="card card-stats">
							<!-- Card body -->
							<div class="card-body">
								<div class="row">
									<div class="col">
										<h5 class="card-title text-uppercase text-muted mb-0">New Review</h5>
										<span class="h2 font-weight-bold mb-0" style="color: #1171ef;">${todayReview }</span>
									</div>
									<div class="col-auto">
										<div
											class="icon icon-shape bg-gradient-info text-white rounded-circle shadow">
											<i class="ni ni-chart-bar-32"></i>
										</div>
									</div>
								</div>
								<p class="mt-3 mb-0 text-sm">
									<span class="text-success mr-2"><i
										class="fa fa-arrow-up"></i> ${reviewUpDown } %</span> <span class="text-nowrap">Since
										last day</span>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- </div> -->

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