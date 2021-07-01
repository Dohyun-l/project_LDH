<%@page import="com.project_ldh.boardDAO"%>
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
		String num = request.getParameter("num");
		String pw = request.getParameter("pw");
		
		boardDAO bdao = new boardDAO();
		int result = bdao.deleteNotice(num, pw);
		
		if(result == 1) {
			%>
			<script type="text/javascript">
				alert("글 삭제가 완료 되었습니다.");
				location.href="noticeForm.jsp";
			</script>
			<%
		} else if(result == 0){
			%>
			<script type="text/javascript">
				alert("비밀번호가 일치하지 않습니다. 비밀번호를 확인해 주세요.");
				history.back();
			</script>
			<%
		} else {
			%>
			<script type="text/javascript">
				alert("해당글을 찾을 수 없습니다.");
				history.back();
			</script>
			<%
		}
		
	%>
	
</body>
</html>