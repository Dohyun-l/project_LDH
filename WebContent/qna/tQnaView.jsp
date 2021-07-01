
<%@page import="com.project_ldh.qnaDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	qnaDAO qbao = new qnaDAO();
	
	JSONArray noticeList = new JSONArray();
	noticeList = qbao.getNoticeList();
%>
<%=noticeList%>