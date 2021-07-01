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
		request.setCharacterEncoding("UTF-8");
		String prePage = request.getParameter("prePage");
		
		System.out.println(prePage);
	%>
	
	<jsp:useBean id="ub" class="com.project_ldh.userBean"/>
	<jsp:setProperty property="*" name="ub"/>

	<%
	
		userDAO udao = new userDAO();
		int result = udao.login(ub);
		
		
		if(result == 1){
			session.setAttribute("id", ub.getId());
			if(prePage == ""){
				response.sendRedirect("../layout/main.jsp");
			} else {
				response.sendRedirect(prePage);				
			}
		} else if(result == 0) {
			%>
			<script type="text/javascript">
				alert("비밀번호가 일치하지 않습니다.");
				history.back();
			</script>
			<%
		} else {
			%>
			<script type="text/javascript">
				alert("입력하신 정보의 아이디가 없습니다.");
				history.back();
			</script>
			<%
		}
		
	%>
</body>
</html>