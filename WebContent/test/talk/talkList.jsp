<%@page import="com.project_ldh.talkDTO"%>
<%@page import="com.project_ldh.talkDAO"%>
<%@page import="java.util.List"%>
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
	talkDAO tdao = new talkDAO();

	List talkList = tdao.getTalkList();
%>
<a href="talk.jsp">메인으로 돌아가기</a>

<table border="1">
	<tr>
		<th>방 번호</th>
		<th>방 제목</th>
		<th>방장 이름</th>
	</tr>
	<%for(int i=0; i<talkList.size(); i++) {
		talkDTO tdto = (talkDTO) talkList.get(i);
	%>
	<tr>
		<td><%=tdto.getIdx() %></td>
		<td><a href="talkView.jsp?idx=<%=tdto.getIdx()%>"><%=tdto.getTitle() %></a></td>
		<td><%=tdto.getMaster() %></td>
	</tr>
	<%} %>
</table>


</body>
</html>