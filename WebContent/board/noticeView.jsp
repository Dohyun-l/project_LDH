
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.project_ldh.boardDAO"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	boardDAO dbao = new boardDAO();
	
	int cnt = dbao.getBoardCount();
	
	int pageSize = Integer.parseInt(request.getParameter("pageSize"));
	String pageNum = request.getParameter("pageNum");
	
	
	int currentpage = Integer.parseInt(pageNum);
	int startRow = (currentpage - 1) * pageSize + 1;
	
	int endRow = currentpage * pageSize;
	
	
	JSONArray noticeList = new JSONArray();
	noticeList = dbao.getNoticeList(startRow, pageSize);
%>
<%=noticeList%>