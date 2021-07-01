<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<link rel="stylesheet" href="../css/SlideBar.css">
<link rel="stylesheet" href="../css/Top.css">

<title>Project_LDH</title>
</head>
<body>


	<!-- navbar 메뉴 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light"> <a
		class="navbar-brand" href="index.jsp">harugamsung</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>


	<div class="collapse navbar-collapse" id="navbarNavDropdown">
		<ul class="navbar-nav">
			<!-- <li class="nav-item active"><a class="nav-link" href="#">공지사항
						<span class="sr-only">(current)</span>
				</a></li> -->
			<li class="nav-item"><a class="nav-link" href="#">공지사항</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#"
				id="navbarDropdownMenuLink" role="button" data-toggle="dropdown"
				aria-haspopup="true" aria-expanded="false"> 쇼핑 </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
					<a class="dropdown-item" href="#">전체</a> <a class="dropdown-item"
						href="#">아우터</a> <a class="dropdown-item" href="#">상의</a> <a
						class="dropdown-item" href="#">하의</a> <a class="dropdown-item"
						href="#">신발</a>
				</div></li>

			<li class="nav-item"><a class="nav-link" href="#">장바구니</a></li>
			<li class="nav-item"><a class="nav-link" href="#">주문관리</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Q&A</a></li>
		</ul>
	</div>
	<div id="Top">
		<%
			int a = 0;
			if (a == 1) {
		%>
		<p class="userTop">
			<a href="#">로그인</a> / <a href="#">회원가입</a>
		</p>

		<%
			} else {
		%>
		<p class="userTop">
			OOO님 환영합니다. 현재 보유 Point : 1000 <a href="#">정보조회</a>
		</p>
		<%
			}
		%>
	</div>
	</nav>
	<!-- navbar 메뉴 -->


	<div class="slidebox">
		<input type="radio" name="slide" id="slide01" checked> <input
			type="radio" name="slide" id="slide02"> <input type="radio"
			name="slide" id="slide03"> <input type="radio" name="slide"
			id="slide04">
		<ul class="slidelist">
			<li class="slideitem"><a><img src="../css/img/slide01.jpg"></a>
			</li>
			<li class="slideitem"><a><img src="../css/img/slide02.jpg"></a>
			</li>
			<li class="slideitem"><a><img src="../css/img/slide03.jpg"></a>
			</li>
			<li class="slideitem"><a><img src="../css/img/slide04.jpg"></a>
			</li>

		</ul>
		<div class="slide-control">
			<div class="control01">
				<label for="slide04" class="prev"></label> <label for="slide02"
					class="next"></label>
			</div>
			<div class="control02">
				<label for="slide01" class="prev"></label> <label for="slide03"
					class="next"></label>
			</div>
			<div class="control03">
				<label for="slide02" class="prev"></label> <label for="slide04"
					class="next"></label>
			</div>
			<div class="control04">
				<label for="slide03" class="prev"></label> <label for="slide01"
					class="next"></label>
			</div>
		</div>
	</div>




	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns"
		crossorigin="anonymous"></script>


</body>
</html>