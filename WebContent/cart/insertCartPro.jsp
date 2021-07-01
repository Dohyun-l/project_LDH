<%@page import="com.project_ldh.cartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="cb" class="com.project_ldh.cartBean"/>
	<jsp:setProperty property="*" name="cb"/>
	<%
		String id = (String) session.getAttribute("id");
		String pageNum = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
	
		cb.setId(id);
		System.out.println(cb);
		
		cartDAO cdao = new cartDAO();
		cdao.insertCart(cb);
	%>
	<script type="text/javascript">
		var check = confirm("장바구니를 보러 가시겠습니까?");
		if(check){
			location.href = "cartForm.jsp";
		} else {
			location.href = "../shopping/shopForm.jsp?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>";
		}
		
	
	</script>

</body>
</html>