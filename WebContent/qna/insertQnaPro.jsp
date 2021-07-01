<%@page import="com.project_ldh.qnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	%>
	
	<jsp:useBean id="qb" class="com.project_ldh.qnaBean"/>
	<jsp:setProperty property="*" name="qb"/>
	
	<%
		// ip 정보 추가
		qb.setIp(request.getRemoteAddr());
	
		qnaDAO qdao = new qnaDAO();
		qdao.insertBoard(qb);
		
		response.sendRedirect("qnaForm.jsp");
	%>


</body>
</html>