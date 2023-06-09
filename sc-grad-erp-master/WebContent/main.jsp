<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.db.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<style>
.dropdown:hover .dropdown-menu {
    display: block;
    margin-top: 0;
}
</style>
<head>
	<meta property="og:url" content="http://localhost:8090/semiERP/main.jsp">
	<meta property="og:title" content="SemiColon-ERP">
	<meta property="og:type" content="website">
	<meta property="og:image" content="image/image.png">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>Enterprise Resource Planning System</title>
	<!-- 부트스트랩 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 CSS 추가하기 -->
	<link rel="stylesheet" href="./css/custom.css">
	<link rel="stylesheet" href="./css/footable.bootstrap.css">
	<link rel="stylesheet" href="./css/footable.bootstrap.min.css">
	<!-- 
     <link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/> 
	-->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
	<script src="./js/footable.min.js"></script> 
	<script src="./js/footable.js"></script> 

</head>
<%
if(session.getAttribute("loginUser")==null){ %>
<script>
    alert("로그인 하세요.");
    location.href="index.jsp";
</script>
<%
}
%>
<body>
<div class="container-fluid mt-2 mb-5">
	<div class="row">
		<div class="col-md-12">
			<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-bottom" style="font-size: 17px;">
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="navbar-nav">
						<li class="nav-item mt-2 mr-5 text-secondary">
							<label>ERP 메뉴</label>
						</li>
						<li class="nav-item mt-2 mr-2">
							<label>|</label>
						</li>
						<li class="nav-item dropup mr-2">
							 <a class="nav-link dropdown-toggle text-dark" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">자재구매</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
								 <a class="nav-link active" href="materials.jsp">자재관리</a>
								 <a class="nav-link active" href="purchase.jsp">구매관리</a>
							</div>
						</li>
						<li class="nav-item mt-2 mr-2">
							<label>|</label>
						</li>
						<li class="nav-item dropup mr-2">
							 <a class="nav-link dropdown-toggle text-dark" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">제품생산</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
								<a class="nav-link active" href="product.jsp">제품관리</a>
								<a class="nav-link active" href="produce_list.jsp">생산목록</a>
								<a class="nav-link active" href="produce.jsp">생산관리</a>
							</div>
						</li>
						<li class="nav-item mt-2 mr-2" style="color:#111111">
							<label>|</label>
						</li>
						<li class="nav-item dropup mr-2">
							 <a class="nav-link dropdown-toggle text-dark" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">판매관리</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
								<a class="nav-link active" href="sale.jsp">판매관리</a>
							</div>
						</li>
						<li class="nav-item mt-2 mr-2" style="color:#111111">
							<label>|</label>
						</li>
						<li class="nav-item dropup mr-2">
							 <a class="nav-link dropdown-toggle text-dark" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">회사관리</a>
							<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
								<a class="nav-link active" href="client.jsp">거래처관리</a>
								<a class="nav-link active" href="employee.jsp">사원관리</a>
							</div>
						</li>
						<li class="nav-item mt-2 mr-2" style="color:#111111">
							<label>|</label>
						</li>
					</ul>
					<ul class="navbar-nav ml-md-auto">
						<li class="nav-item dropup">
							 <a class="nav-link dropdown-toggle text-primary" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">전체 메뉴</a>
							<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
								<a class="nav-link active" href="materials.jsp">자재관리</a>
								<a class="nav-link active" href="purchase.jsp">구매관리</a>
								<div class="dropdown-divider"></div>
								<a class="nav-link active" href="product.jsp">제품관리</a>		
								<a class="nav-link active" href="produce_list.jsp">생산목록</a>	
								<a class="nav-link active" href="produce.jsp">생산관리</a>
								<div class="dropdown-divider"></div>
								<a class="nav-link active" href="sale.jsp">판매관리</a>
								<div class="dropdown-divider"></div>
								<a class="nav-link active" href="client.jsp">거래처관리</a>
								<a class="nav-link active" href="employee.jsp">사원관리</a>
							</div>
						</li>
					</ul>
				</div>
			</nav>
			<div class="row" id="row1">
				<div class="col-md-12">
					<ul class="nav">
						<li class="nav-item">
							<a class="nav-link active" href="main.jsp"><h3>ERP System</h3></a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="profile.jsp">프로필</a>
						</li>
						<li class="nav-item dropdown ml-md-auto">
							 <a class="nav-link dropdown-toggle" href="http://example.com" id="hostinform" data-toggle="dropdown">회원정보</a>
							<div class="dropdown-menu dropdown-menu-right" aria-labelledby="hostinform">
								 <a class="dropdown-item" href="index.jsp">로그인</a>
								 <a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
								<div class="dropdown-divider">
								</div> <a class="dropdown-item" href="profile.jsp">프로필</a>
							</div>
						</li>
					</ul>
				</div>
			</div>
			<div class="row mb-1" id="row2">
			<div class="col-md-12">
				<nav class="navbar navbar-expand-lg navbar-light bg-white" style="font-size: 17px;">
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-2">
						<ul class="navbar-nav">
							<li class="nav-item mt-2 mr-5 text-secondary">
								<label>ERP 메뉴</label>
							</li>
							<li class="nav-item mt-2 mr-3">
								<label>|</label>
							</li>
							<li class="nav-item dropdown mr-2">
								 <a class="nav-link dropdown-toggle text-dark" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">자재구매</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
									 <a class="nav-link active" href="materials.jsp">자재관리</a>
									 <a class="nav-link active" href="purchase.jsp">구매관리</a>
								</div>
							</li>
							<li class="nav-item mt-2 mr-3">
								<label>|</label>
							</li>
							<li class="nav-item dropdown mr-3">
								 <a class="nav-link dropdown-toggle text-dark" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">제품생산</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
									<a class="nav-link active" href="product.jsp">제품관리</a>
									<a class="nav-link active" href="produce_list.jsp">생산목록</a>
									<a class="nav-link active" href="produce.jsp">생산관리</a>
								</div>
							</li>
							<li class="nav-item mt-2 mr-3" style="color:#111111">
								<label>|</label>
							</li>
							<li class="nav-item dropdown mr-3">
								 <a class="nav-link dropdown-toggle text-dark" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">판매관리</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
									<a class="nav-link active" href="sale.jsp">판매관리</a>
								</div>
							</li>
							<li class="nav-item mt-2 mr-3" style="color:#111111">
								<label>|</label>
							</li>
							<li class="nav-item dropdown mr-3">
								 <a class="nav-link dropdown-toggle text-dark" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">회사관리</a>
								<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
									<a class="nav-link active" href="client.jsp">거래처관리</a>
									<a class="nav-link active" href="employee.jsp">사원관리</a>
								</div>
							</li>
							<li class="nav-item mt-2 mr-3" style="color:#111111">
								<label>|</label>
							</li>
						</ul>
						<ul class="navbar-nav ml-md-auto">
							<li class="nav-item dropdown">
								 <a class="nav-link dropdown-toggle text-primary" href="http://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown">전체 메뉴</a>
								<div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
									<a class="nav-link active" href="materials.jsp">자재관리</a>
									<a class="nav-link active" href="purchase.jsp">구매관리</a>
									<div class="dropdown-divider"></div>
									<a class="nav-link active" href="product.jsp">제품관리</a>		
									<a class="nav-link active" href="produce_list.jsp">생산목록</a>	
									<a class="nav-link active" href="produce.jsp">생산관리</a>
									<div class="dropdown-divider"></div>
									<a class="nav-link active" href="sale.jsp">판매관리</a>
									<div class="dropdown-divider"></div>
									<a class="nav-link active" href="client.jsp">거래처관리</a>
									<a class="nav-link active" href="employee.jsp">사원관리</a>
								</div>
							</li>
						</ul>
					</div>
				</nav>
			</div>
			</div>
		</div>
	</div>
	<hr>
	<div class="row mr-5 mt-4">
		<div class="col-md-2"></div>
		<!-- 거래처관리 폼 시작 -->
		<div class="col-md-8 mt-6" style="font-size: 13px;">
			<h1><%=session.getAttribute("loginUser")%>님 안녕하세요! SemiColon-ERP 시스템입니다.</h1>
			<iframe src="https://calendar.google.com/calendar/embed?height=600&amp;wkst=1&amp;bgcolor=%23ffffff&amp;ctz=Asia%2FSeoul&amp;src=M3QxZGlkYWdscTZjbGh2ZnNqN2VxbmF0dWtAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ&amp;color=%23B39DDB" style="border:solid 1px #777" width="800" height="600" frameborder="0" scrolling="no"></iframe>
			<h1>　</h1>
			<br>
		</div>
		
		<div class="col-md-2" style="font-size: 18px;">
		<br><br>
			<p style="font-size: 18px; font-weight: bold;">빠른 메뉴</p>
			<li><a href="materials.jsp">자재관리</a><br></li>
			<li><a href="purchase.jsp">구매관리</a><br></li>
			<li><a href="product.jsp">제품관리</a><br></li>
			<li><a href="produce_list.jsp">생산목록</a><br></li>
			<li><a href="produce.jsp">생산관리</a><br></li>
			<li><a href="sale.jsp">판매관리</a><br></li>
			<li><a href="client.jsp">거래처관리</a><br></li>
			<li><a href="employee.jsp">사원관리</a><br></li>
		</div>
	</div>
</div>
	<!-- 
	<footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">
		Copyright &copy; 세미콜론 All Rights Reserved.
	</footer>
	 -->
	<!-- 제이쿼리 자바스크립트 추가하기 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 자바스크립트 추가하기 -->
	<script src="./js/popper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가하기 -->
	<script src="./js/bootstrap.min.js"></script>
</body>
</html>