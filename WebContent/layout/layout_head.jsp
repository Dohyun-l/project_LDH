<%@page import="com.project_ldh.userDAO"%>
<%@page import="com.project_ldh.userBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/layout.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script&family=Nanum+Brush+Script&display=swap" rel="stylesheet">

</head>
<body>
	<h1 id="mainHeader"><a href="/project_LDH/layout/main.jsp" style="text-decoration: none; color: white;">harugamsung</a></h1>
	
		<%
			String id = (String)session.getAttribute("id");
		
			userDAO udao = new userDAO();
			int point = udao.pointPnt(id);
		
			if (id == null) {
		%>
		<span class="userInfo">
			<a href="../user/loginForm.jsp">로그인</a> /
			<a href="../user/insertForm.jsp">회원가입</a>
		</span>

		<%
			} else {
		%>
		<span class="userInfo">
			<%=id %>님 환영합니다. 현재 보유 Point : <%=point %> /
			<a href="../user/updateForm.jsp">정보조회</a> /
			<a href="../user/logout.jsp">로그아웃</a>
		</span>
		<%
			}
		%>
	<br>
	
	<div id="navbar">
		<ul>
		  <li><a href="../board/noticeForm.jsp">공지사항</a></li>
		  <li><a href="../shopping/shopForm.jsp">쇼핑</a></li>
		  <li><a href="../cart/cartForm.jsp">장바구니</a></li>
		  <li><a href="#">주문관리</a></li>
		  <li><a href="../qna/qnaForm.jsp">Q&A</a></li>
		</ul>
	</div>


</body>
</html>