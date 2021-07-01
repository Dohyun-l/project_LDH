<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FileReader"%>
<%@page import="com.project_ldh.talkDTO"%>
<%@page import="com.project_ldh.talkDAO"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String idx = request.getParameter("idx");
	talkDAO tdao = new talkDAO();
	talkDTO tdto = tdao.getTalkInfo(Integer.parseInt(idx));

	String nickname = request.getParameter("nickname");
	String content = request.getParameter("content");

	SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	Date time = new Date();

	String time1 = format1.format(time);

	FileReader fReader = new FileReader("D://talk/" + tdto.getFilename() + ".txt");
	BufferedReader br = new BufferedReader(fReader);
	String s;
	String str = "";
	do {
		s = br.readLine();
		if (s != null) {
			str += s;
		}
	} while (s != null);

	br.close();
	fReader.close();

	FileWriter fw = null;
	BufferedReader br1 = new BufferedReader(new InputStreamReader(System.in));
	fw = new FileWriter("D://talk/" + tdto.getFilename() + ".txt");

	str += "[" + nickname + "::" + content + "::" + time1 + "]";
	fw.write(str);

	fw.close();
	br1.close();
%>