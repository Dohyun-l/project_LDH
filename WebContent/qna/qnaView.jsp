
<%@page import="com.project_ldh.qnaDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	qnaDAO qbao = new qnaDAO();
	
	int cnt = qbao.getBoardCount();
	
	int pageSize = Integer.parseInt(request.getParameter("pageSize"));
	String pageNum = request.getParameter("pageNum");
	
	
	int currentpage = Integer.parseInt(pageNum);
	int startRow = (currentpage - 1) * pageSize + 1;
	
	int endRow = currentpage * pageSize;
	
	
	JSONArray noticeList = new JSONArray();
	noticeList = qbao.getNoticeList(startRow, pageSize);
%>
<%=noticeList%>