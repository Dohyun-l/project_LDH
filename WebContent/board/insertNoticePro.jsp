<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.project_ldh.boardBean"%>
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
		request.setCharacterEncoding("UTF-8");
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
		
		String subject = multi.getParameter("subject");
		int important;
		if(multi.getParameter("important") == null){
			important = 0;
		} else {
			important = Integer.parseInt(multi.getParameter("important"));			
		}
		String id = multi.getParameter("id");
		String pw = multi.getParameter("pw");
		String content = multi.getParameter("content");


		String file = multi.getFilesystemName("file");
		
		boardBean bb = new boardBean();
		
		bb.setSubject(subject);
		bb.setId(id);
		bb.setPw(pw);
		bb.setImportant(important);
		bb.setFile(file);
		bb.setContent(content);
		
		// ip 정보 추가
		bb.setIp(request.getRemoteAddr());
	
		boardDAO bdao = new boardDAO();
		bdao.insertBoard(bb);
		
		response.sendRedirect("noticeForm.jsp");
	%>


</body>
</html>