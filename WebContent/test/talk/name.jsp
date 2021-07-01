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
	session.invalidate();
%>

<script type="text/javascript">
	function checkNickname() {
		
		if(document.fr.nickname.value == ""){
			alert("닉네임을 입력하세요.");
			return false;
		}
		
	}

</script>


<h1>닉네임 설정</h1>
<form action="namePro.jsp" method="post" onsubmit="return checkNickname()" name="fr">
<input name="nickname">
<hr>
<input type="submit" value="입장하기">
</form>
</body>
</html>