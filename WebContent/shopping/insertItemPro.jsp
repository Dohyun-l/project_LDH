<%@page import="com.project_ldh.itemBean"%>
<%@page import="com.project_ldh.itemDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>insertItemPro</h1>
	
	<%
		request.setCharacterEncoding("UTF-8");
	
		String path = request.getRealPath("/upload/shop");
		
		System.out.println("파일저장되는 실제 경로 : " + path);
		
		int maxSize = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(
				request,
				path,		
				maxSize,
				"UTF-8",
				new DefaultFileRenamePolicy()
				);
		
		System.out.println("파일 업로드 완료!");
		
		// 이전 페이지에서 전달해준 정보를 출력
		String name = multi.getParameter("name");
		
		int price = Integer.parseInt(multi.getParameter("price"));
		int qty = Integer.parseInt(multi.getParameter("qty"));
		String size = multi.getParameter("size");
		int point = Integer.parseInt(multi.getParameter("point"));
		int img_width = Integer.parseInt(multi.getParameter("img_width"));
		int img_height = Integer.parseInt(multi.getParameter("img_height"));
		
		// -> 서버에 올라가는 파일의 이름(중복처리)
		String img_name = multi.getFilesystemName("img_name");
		
		itemBean ib = new itemBean();
		
		ib.setImg_height(img_height);
		ib.setImg_name(img_name);
		ib.setImg_width(img_width);
		ib.setName(name);
		ib.setPoint(point);
		ib.setPrice(price);
		ib.setQty(qty);
		ib.setSize(size);
		
		itemDAO idao = new itemDAO();
		idao.insertItem(ib);
		
	%>
	<script type="text/javascript">
		alert("상품 등록 완료");
		location.href="shopForm.jsp";
	</script>


</body>
</html>