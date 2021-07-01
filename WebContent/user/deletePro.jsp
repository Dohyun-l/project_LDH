<%@page import="com.project_ldh.userDAO"%>
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
		request.setCharacterEncoding("utf-8");

		String id = (String) session.getAttribute("id");
		String pw = request.getParameter("pw");

		userDAO udao = new userDAO();
		int result = udao.deleteUser(id, pw);

		if (result == 0) {
			%>
			<script type="text/javascript">
				alert("비밀번호가 일치 하지 않습니다.");
				history.back();
			</script>
			<%
		} else if (result == -1) {
			%>
			<script type="text/javascript">
				alert("일치하는 회원이 없습니다.");
				history.back();
			</script>
			<%
		} else {
			%>
			<script type="text/javascript">
				alert("회원 탈퇴가 완료 되었습니다.");
				history.back();
			</script>
			<%
			
			session.invalidate();
			
			response.sendRedirect("../layout/main.jsp");
		}
	%>
</body>
</html>