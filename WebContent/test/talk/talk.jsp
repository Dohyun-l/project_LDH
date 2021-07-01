<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>

<h1>채팅시스템</h1>

<%
	String nickname = (String)session.getAttribute("nickname");

	if(nickname == null){
		response.sendRedirect("name.jsp");
	}
%>

<a href="name.jsp">닉네임 재설정</a>
/
<a href="createTalk.jsp">채팅방 만들기</a>
/
<a href="talkList.jsp">채팅방 리스트 보기</a>


</body>
</html>