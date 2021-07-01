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
	String nickname = (String)session.getAttribute("nickname");

	if(nickname == null){
		response.sendRedirect("name.jsp");
	}
%>

<h1>채팅방 만들기</h1>
<form action="createTalkPro.jsp" method="post">
방제목 : <input type="text" name="title">
<hr>
<input type="submit" value="방만들기">

</form>
<a href="talk.jsp">메인으로 돌아가기</a>

</body>
</html>