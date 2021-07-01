<%@page import="com.project_ldh.talkDTO"%>
<%@page import="com.project_ldh.talkDAO"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String nickname = (String) session.getAttribute("nickname");

	String idx = request.getParameter("idx");
	talkDAO tdao = new talkDAO();
	talkDTO tdto = tdao.getTalkInfo(Integer.parseInt(idx));
	FileReader fReader = new FileReader("D://talk/" + tdto.getFilename() + ".txt");
	BufferedReader br = new BufferedReader(fReader);
	String s = new String("");
	String write_nickname = "";
	String content = "";
	String date = "";
	
	while ((s = br.readLine()) != null) {
		
		String[] data = s.split("]");

		for(int i=0; i<data.length; i++) {
 			String[] Info = data[i].replace("[", "").toString().split("::");
 			
 			write_nickname = Info[0];
			content = Info[1];
			date = Info[2];
			
			out.println("<div class='talk' id='nick"+write_nickname+"'>");
			out.println("<div class='nickname'>"+write_nickname+"</div>");
			out.println("<div class='content'>"+content+"</div>");
			out.println("<div class='date'>"+date+"</div>");
			out.println("</div>");
			out.println("<br>");
		}
	} 
	out.println("<br id='lastline'>");
	br.close();
	fReader.close();
%>