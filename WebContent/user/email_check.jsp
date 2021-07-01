<%@page import="com.project_ldh.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Dancing+Script&family=Nanum+Brush+Script&display=swap" rel="stylesheet">

<script type="text/javascript">
	function returnEmail(){
		opener.document.fr.email.value = document.fr.email.value;
		opener.document.fr.emailcheck.value = "체크완료";
		opener.document.fr.email.readOnly = true;
		window.close();
	}
	
</script>

</head>
<body>
	<h1 style="font-size: 3.9em;">입력하신 EMAIL</h1>

	<div id="id_check">

	<form id="fr" style="font-size: 2em;"  action="email_check.jsp" method="post" name="fr">
	<%
		String email = request.getParameter("email");
		// 사용자가 입력한 ID 정보를 가지고
		// DB로 이동후 회원인지 아닌지 판단
	
		userDAO udao = new userDAO();
		int result = udao.emailCheck(email);
		if(result == 1){
			out.print("이미 사용중인 이메일 입니다.");
		} else {
			out.print("사용 가능한 이메일 입니다.");
		}
		
		
	%>
		<br>
		<input type="text" value="<%=email%>" name="email" id="email" style="width: 100%;"><br>
		<%
		if(result == 1){
		%>
		<input type="submit" value="중복체크">
		<%}else{ %>
		<input type="submit" value="중복체크">
		<input type="button" value="사용하기" onclick="returnEmail();">
		<%} %>
	</form>
	</div>
</body>
</html>