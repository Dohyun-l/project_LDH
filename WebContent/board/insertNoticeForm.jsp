<%@page import="com.project_ldh.userBean"%>
<%@page import="com.project_ldh.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항 작성</title>
<link href="../css/boardstyle.css" rel="stylesheet">
<script type="text/javascript">
	function checkNotice() {
		if (document.fr.subject.value == "") {
			alert("제목을 입력해 주세요.");
			return false;
		}
		
		if(document.fr.content.value == ""){
			alert("내용을 입력해주세요.");
			return false;
		}
	}

</script>
</head>
<body>
	<jsp:include page="../layout/layout_head.jsp" />
	<%
		String id = (String) session.getAttribute("id");

		if(id == null){
			response.sendRedirect("noticeForm.jsp");
		} else {
	
			userDAO ubao = new userDAO();
			userBean ub = ubao.readInfo(id);
			
			
	
			int su = ub.getSu();
			
			if (su != 1) {
				%>
				<script type="text/javascript">
					location.href="../layout/main.jsp";
				</script>
				<%
			}
	%>
			<div>
				<form action="insertNoticePro.jsp" enctype="multipart/form-data" method="post" onsubmit="return checkNotice();" name="fr">
				<h1 style="text-align: center;">공지사항</h1>
			
					<table class="board">
						<tr>
							<th>제목</th>
							<td colspan="2"><input type="text" name="subject" style="float: left; width: 90%;"></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td><input type="file" name="file" style="float: left;'"></td>
							<th><label><input type="checkbox" name="important" value="1" >중요</label></th>
						</tr>
						<tr>
							<td colspan="3"><textarea rows="15px" cols="200px" name="content" style="border-style: none;"></textarea>
							<input type="hidden" name="id" value="<%=ub.getId()%>">
							<input type="hidden" name="pw" value="<%=ub.getPw()%>"></td>
						</tr>
					</table>
					<input type="reset" value="재작성" class="insertButton">
					<input type="submit" value="작성하기" class="insertButton" style="margin-right: 10px;">
				</form>
			</div>
	<%} %>
</body>
</html>