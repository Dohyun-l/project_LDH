<%@page import="com.project_ldh.qnaDAO"%>
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
		String id = (String) session.getAttribute("id");
		String num = request.getParameter("num");
		String checkPw = request.getParameter("checkPw");
	
		System.out.println(id +','+num+','+checkPw);
	
		qnaDAO qdao = new qnaDAO();
		int result = qdao.deleteQna(num, checkPw, id);
		
		if(result == -1){
			%>
			<script type="text/javascript">
				alert("해당글을 찾을수가 없습니다.");
				history.back();
			</script>
			<%
		} else if (result == 0){
			%>
			<script type="text/javascript">
				alert("입력하신 비밀번호가 다릅니다. 비밀번호를 확인해 주세요.");
				history.back();
			</script>
			<%
		} else if (result == -2){
			%>
			<script type="text/javascript">
				alert("글을 수정하실 권한이 없습니다.");
				history.back();
			</script>
			<%
		} else {
			%>
			<script type="text/javascript">
				alert("글이 삭제 되었습니다.");
				location.href="qnaForm.jsp";
			</script>
			<%
		}
	
	%>

</body>
</html>