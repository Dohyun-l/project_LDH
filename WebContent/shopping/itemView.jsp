<%@page import="com.project_ldh.itemDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	itemDAO idao = new itemDAO();

	String pageNum = request.getParameter("pageNum");
	int pageSize = Integer.parseInt(request.getParameter("pageSize"));

	int cnt = idao.cntItem();
	
	int currentpage = Integer.parseInt(pageNum);
	int startRow = (currentpage - 1) * pageSize + 1;
	
	int endRow = currentpage * pageSize;
	
	JSONArray itemList  = idao.readItem(startRow, pageSize);
%>
<%=itemList %>