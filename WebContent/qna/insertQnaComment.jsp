<%@page import="com.project_ldh.userDAO"%>
<%@page import="com.project_ldh.qnaBean"%>
<%@page import="com.project_ldh.qnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");

	if(id != null){
	
		String num = request.getParameter("num");
		String content = request.getParameter("content");
		String re_lev = request.getParameter("re_lev");
		
		userDAO udao = new userDAO();
		
		qnaDAO qdao = new qnaDAO();
		qnaBean qb = qdao.getQna(num, re_lev);
		
		qb.setId(id);
		qb.setContent(content);
		qb.setPw(udao.readInfo(id).getPw());
		qb.setIp(request.getRemoteAddr());
	
		System.out.println(qb);
		
		
		qdao.insertQnaComment(qb);
		
	}

%>