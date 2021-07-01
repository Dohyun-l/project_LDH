<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="com.project_ldh.talkDAO"%>
<%@page import="com.project_ldh.talkDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");

	talkDTO tdto = new talkDTO(); 

	
	tdto.setTitle(request.getParameter("title"));
	
	String nickname = (String)session.getAttribute("nickname");
	
	tdto.setMaster(nickname);
	
	SimpleDateFormat format1 = new SimpleDateFormat ( "_yyyyMMdd_HHmmss");
	
	Date time = new Date();
	
	String filename = nickname + format1.format(time);
	
	tdto.setFilename(filename);
	
	
	talkDAO tdao = new talkDAO();
	int result = tdao.createTalk(tdto);
	
	
	if(result == 1){
		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		PrintWriter pw = new PrintWriter(new BufferedWriter(new FileWriter("D://talk/"+filename+".txt")));
		
		br.close();
		pw.close();
		response.sendRedirect("talk.jsp");
	} else if(result == 0) {
		%>
		<script type="text/javascript">
		alert("이미 동일한 제목의 방이 있습니다.");
		history.back();
		</script>
		<%
	} else {
		%>
		<script type="text/javascript">
		alert("방 생성에 문제가 생겼습니다.");
		history.back();
		</script>
		<%
	}
%>
</body>
</html>