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
	function deleteSubmit(){
		var checkpw = prompt('비밀번호를 입력하세요', '');
		
		if(checkpw == null){
			return false;
		} else if (checkpw == ""){
			alert("비밀번호를 입력해 주세요.");
			return false;
		} else {
			document.fr.pw.value = checkpw;		
		}
	}


</script>
</head>
<body>
	<jsp:include page="../layout/layout_head.jsp"/>
	
	<%
		String id = (String)session.getAttribute("id");
	
		if(id == null){
			response.sendRedirect("../layout/main.jsp");
		}
	%>
	
	<div id="login_form">
		<form action="deletePro.jsp" method="post" name="fr" id="fr" onsubmit="return deleteSubmit();">
		<table>
			<tr>
				<td>
				<%=id %>님 탈퇴하시겠습니까?
				<input type="hidden" name="pw" id="pw">
				</td>		
				<td><button type="submit"
					style="border-style: none; background: white; ">
					<h1>탈퇴하기</h1></button></td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>