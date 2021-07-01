<%@page import="com.project_ldh.boardBean"%>
<%@page import="com.project_ldh.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항 수정</title>
<link href="../css/boardstyle.css" rel="stylesheet">

<script type="text/javascript">
	function updateCheck(){
		var checkPw = prompt("비밀번호를 입력해 주세요.", "");
		if(document.fr.file1.value != ""){
			var file1 = document.fr.file1.value + "";
		
			alert(file1.substring(12));
		
			document.fr.file.value = file1.substring(12);
		}
		
		if(checkPw == null){
			return false;
		} else if(checkPw == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		} else {
			document.fr.pw.value = checkPw;
			return;
		}
	}
</script>

</head>
<body>
	<jsp:include page="../layout/layout_head.jsp" />
	<%
		String id = (String) session.getAttribute("id");
		String num = request.getParameter("num");
		String pageNum = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");

		if(num == null){
			response.sendRedirect("noticeForm.jsp");
		} else {
	
			boardDAO ubao = new boardDAO();
			boardBean bb = ubao.readNotice(num);
			
			System.out.println(bb);
			
			if(bb != null) {
				if (!bb.getId().equals(id)) {
					%>
					<script type="text/javascript">
						alert("글을 수정할 권한이 없습니다.")
						location.href="noticeForm.jsp"
					</script>
					<%
				}
	%>
			<div>
				<form action="updateNoticePro.jsp" enctype="multipart/form-data" method="post" name="fr" onsubmit="return updateCheck();">
				<h1 style="text-align: center;">공지사항(수정)</h1>
			
					<table class="board">
						<tr>
							<th>제목<input type="hidden" name="num" value="<%=bb.getNum()%>"></th>
							<td colspan="2"><input type="text" name="subject" style="float: left; width: 90%;" value="<%=bb.getSubject()%>"></td>
						</tr>
						<tr>
							<th rowspan="2">첨부파일</th>
							<td>
							<%if(bb.getFile() != null){ %>
								<input type="text" name="file" style="float: left;'" readonly value="<%=bb.getFile()%>">
							<%} else { %>
								<input type="text" name="file" style="float: left;'" readonly>
							<%} %>
							</td>
							<th rowspan="2"><label><input type="checkbox" name="important" value="1" 
							<%if(bb.getImportant()==1){	%>checked<%} %>>중요</label></th>
						</tr>
						<tr>
							<td><input type="file" name="file1" style="float: left;'" value="<%=bb.getFile()%>" ></td>
						</tr>
						<tr>
							<td colspan="3"><textarea rows="15px" cols="200px" name="content" style="border-style: none;"><%=bb.getContent() %></textarea>
							<input type="hidden" name="id" value="<%=bb.getId()%>">
							<input type="hidden" name="pw">
							<input type="hidden" name="pageNum" value="<%=pageNum%>">
							<input type="hidden" name="pageSize" value="<%=pageSize%>"></td>
						</tr>
					</table>
					<input type="button" value="목록으로" class="insertButton" onclick="location.href='noticeForm.jsp">
					<input type="reset" value="재작성" class="insertButton" style="margin-right: 10px;">
					<input type="submit" value="수정하기" class="insertButton" style="margin-right: 10px;">
				</form>
			</div>
	<%
			}
		}
	%>
</body>
</html>