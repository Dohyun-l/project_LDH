<%@page import="com.project_ldh.boardBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.project_ldh.boardDAO"%>
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
		String id = (String) session.getAttribute("id");

		
		String path = request.getRealPath("/upload/notice");
		
		System.out.println("파일저장되는 실제 경로 : " + path);
		
		int maxSize = 10 * 1024 * 1024;
	
		MultipartRequest multi = new MultipartRequest(
				request,
				path,		
				maxSize,
				"UTF-8",
				new DefaultFileRenamePolicy()
				);
		
		String pageNum = multi.getParameter("pageNum");
		String pageSize = multi.getParameter("pageSize");
		
		
		
		String subject = multi.getParameter("subject");
		int important;
		if(multi.getParameter("important") == null){
			important = 0;
		} else {
			important = Integer.parseInt(multi.getParameter("important"));			
		}

		String pw = multi.getParameter("pw");
		String content = multi.getParameter("content");
		int num = Integer.parseInt(multi.getParameter("num"));
		
		// String file = multi.getFilesystemName("file");
		// String file_n = multi.getParameter("file");
		// String file = file_n.substring(12);
		String file = multi.getParameter("file");
		
		
		boardBean bb = new boardBean();
		
		bb.setNum(num);
		bb.setSubject(subject);
		bb.setId(id);
		bb.setPw(pw);
		bb.setImportant(important);
		bb.setFile(file);
		bb.setContent(content);
		
		
		System.out.println(bb);
		
		boardDAO bdao = new boardDAO();
		int result = bdao.updateBoard(bb);
		
		
		if (result == 1) {
			%>
			<script type="text/javascript">
				alert("업데이트가 완료 되었습니다.");
				location.href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=pageNum%>&pageSize=<%=pageSize%>";
			</script>
			<%
		} else if (result == 0) {
			%>
			<script type="text/javascript">
				alert("비밀번호가 올바르지 않습니다. 비밀번호를 확인해 주세요.");
				history.back();
			</script>
			<%
		} else {
			%>
			<script type="text/javascript">
				alert("해당글을 찾을 수 없습니다.");
				history.back();
			</script>
			<%
		}
	%>


</body>
</html>