<%@page import="com.project_ldh.boardBean"%>
<%@page import="com.project_ldh.boardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항</title>
<link href="../css/boardstyle.css" rel="stylesheet">

</head>
<body>
	<jsp:include page="../layout/layout_head.jsp"/>
	
	<%
			String id = (String)session.getAttribute("id");
	
			String num = request.getParameter("num");
			String pageNum = request.getParameter("pageNum");
			String pageSize = request.getParameter("pageSize");

			if (num == null) {
				response.sendRedirect("noticeForm.jsp");
			}

			boardDAO bdoa = new boardDAO();
			bdoa.readCnt(num);
			boardBean bb = bdoa.readNotice(num);

			if (bb != null) {
		%>
					<table class="board">
						<tr>
							<th>작성일자</th>
							<td><input type="text" name="date" value="<%=bb.getDate()%>" readonly></td>
							<th>작성자</th>
							<td><input type="text" name="id" value="<%=bb.getId()%>" readonly></td>
							<th>조회수</th>
							<td><input type="text" name="date" value="<%=bb.getReadcount()%>" readonly></td>
						</tr>
						<tr>
							<th>제목</th>
							<td colspan="5"><input type="text" name="subject" style="float: left; width: 90%;" readonly value="<%=bb.getSubject()%>"></td>
						</tr>
						<tr>
							<th>첨부파일</th>
							<td colspan="4">
							<%if(bb.getFile() != null){ %>
								<input type="text" name="file" style="float: left;'" readonly 
								value="<%=bb.getFile()%>"  onclick="location.href='file_down.jsp?filename=<%=bb.getFile()%>'">
							<%} %>
							</td>
							<th><label><input type="checkbox" name="important" value="1" readonly
							<%if (bb.getImportant() == 1) {%>checked<%}%>>
							중요</label></th>
						</tr>
						<tr>
							<td colspan="6"><textarea rows="15px" cols="200px" name="content" readonly style="border-style: none;"><%=bb.getContent()%></textarea>
							</td>
						</tr>
					</table>
					<div>
						<input type="button" class="insertButton" value="목록으로" onclick="location.href='noticeForm.jsp?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>'">
						<%if(bb.getId().equals(id)) {%>
						<input type="button" class="insertButton" value="글 삭제하기" style="margin-right: 10px;" onclick="return deleteNotice();">
						<input type="button" class="insertButton" value="글 수정하기" style="margin-right: 10px;" onclick="location.href='updateNoticeForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>'">
						<%} %>
					</div>
	<%}%>
	
	<script type="text/javascript">
	function deleteNotice(){
		var checkPw = prompt("비밀번호를 입력해주세요.", "");
		
		if(checkPw == null) {
			return false;
		} else if (checkPw == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		} else {
			location.href="deleteNotice.jsp?num="+<%=num%>+"&pw="+checkPw;
			return;	
		}
	}


	</script>
	
</body>
</html>