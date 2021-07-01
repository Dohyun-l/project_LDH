<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.project_ldh.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	userDAO udao = new userDAO();
	JSONArray userList = udao.readAllUser();
%>
<%=userList %>