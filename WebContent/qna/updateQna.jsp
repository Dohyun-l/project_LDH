<%@page import="com.project_ldh.qnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	String num = request.getParameter("num");
	String content = request.getParameter("content");
	
	System.out.println(num);
	System.out.println(content);
	
	qnaDAO qdao = new qnaDAO();
	int result = qdao.updateContent(num, content);
%>
<%=result %>