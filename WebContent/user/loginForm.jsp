<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">
<script type="text/javascript">
	var prePage = document.referrer;

</script>
</head>
<body>
	<jsp:include page="../layout/layout_head.jsp"/>
	
	<%
		if(session.getAttribute("id") != null){
		response.sendRedirect("../layout/main.jsp");
	}
	
	%>	
	
	
	<div id="login_form">
		<form action="loginPro.jsp" method="post" id="fr" name="fr">
			<table>
			
			<tr>
				<td>아이디<input type="hidden" name="prePage"></td>
				<td><input type="text" name="id"></td>
				<td rowspan="2"><button type="submit"
					style="border-style: none; background: white; ">
					<h1>로그인</h1></button></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="pw"></td>
			</tr>
			
			</table>
		</form>
	</div>
	<div id="link"> 

	<a href="insertForm.jsp">회원가입</a>
	</div>
<script type="text/javascript">
	document.fr.prePage.value = prePage;
</script>
	
</body>
</html>