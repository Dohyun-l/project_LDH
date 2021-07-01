<%@page import="com.project_ldh.userDAO"%>
<%@page import="com.project_ldh.itemDAO"%>
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
		String id = (String) session.getAttribute("id");
	
		if(new userDAO().suUser(id) != 1){
			response.sendRedirect("shopForm.jsp");	
		}
		
		itemDAO idao = new itemDAO();
		idao.deleteItem(num);
	%>
	<script type="text/javascript">
		alert("삭제가 완료되었습니다.");
		location.href="shopForm.jsp";
	</script>
	

</body>
</html>