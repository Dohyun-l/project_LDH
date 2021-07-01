<%@page import="com.project_ldh.userDAO"%>
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
		request.setCharacterEncoding("utf-8");
	
		String pw2 = request.getParameter("pw2");
		String addr
		 = "(" + request.getParameter("postcode") + ")" + request.getParameter("address") + ", " 
		 + request.getParameter("detailAddress") + request.getParameter("extraAddress");
		
	%>
	
	<jsp:useBean id="ub" class="com.project_ldh.userBean"/>
	<jsp:setProperty property="*" name="ub"/>
		
	<%
		ub.setAddr(addr);
	
		System.out.println(ub);
		
		userDAO udao = new userDAO();
		
		int rec = udao.insertUser(ub);
		
		if(rec == 1){
			udao.recPoint(ub.getRec(), 1000);
		}
		
		response.sendRedirect("loginForm.jsp");
	%>
	
	

</body>
</html>