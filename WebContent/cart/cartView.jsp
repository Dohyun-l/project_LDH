<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.project_ldh.cartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("id");
	cartDAO cdao = new cartDAO();
	JSONArray cartList = cdao.getCartList(id);
%>
<%=cartList%>