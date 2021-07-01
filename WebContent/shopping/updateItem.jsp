<%@page import="com.project_ldh.itemDAO"%>
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
		String id = (String)session.getAttribute("id");
		
		if(new userDAO().suUser(id) != 1){
			%>
			<script type="text/javascript">
				alert("정보 수정 권한이 없습니다.");
				history.back();
			</script>
			<%
		} else {
	
	%>
	<jsp:useBean id="ib" class="com.project_ldh.itemBean"/>
	<jsp:setProperty property="*" name="ib"/>
	
	<%
			if(ib != null){
				itemDAO idao = new itemDAO();
				idao.updateItem(ib);
				response.sendRedirect("shopForm.jsp");
			}else{
				%>
				<script type="text/javascript">
					alert("수정 실패");
					history.back();
				</script>
				<%
			}
		
		}
	%>

</body>
</html>