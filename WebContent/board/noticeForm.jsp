<%@page import="com.project_ldh.boardDAO"%>
<%@page import="com.project_ldh.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공지사항</title>

<link rel="stylesheet" href="../css/boardstyle.css">

<script src="../js/jquery-3.6.0.js"></script>

<script type="text/javascript">
	var pageNum = <%=request.getParameter("pageNum") %>;
	var pageSize = <%=request.getParameter("pageSize") %>;
	
	if(pageNum == null){
		pageNum = 1;
	}
	
	if(pageSize == null){
		pageSize = 5;
	}
	
	var cnt = <%=new boardDAO().getBoardCount() %>;
	
	var pageCount = Math.floor(cnt/pageSize) + (cnt % pageSize == 0? 0 : 1);
	var pageBlock = 2;
	var startPage = Math.floor((pageNum -1)/pageBlock) * pageBlock + 1;
	var endPage = startPage + pageBlock -1;
	if(endPage > pageCount) {
		endPage = pageCount;
	}

	$(document).ready(
			function() {

				$('#noticePage').html(function(){
					var t = ""
					if(startPage > pageBlock){
						t += '<a href="noticeForm.jsp?pageNum=' + (startPage-pageBlock) + '&pageSize='+pageSize+'">[ 이전 ]</a>';
					}
					
					// 숫자 1....5
					for(var i=startPage; i<=endPage; i++){
						t += ' <a href="noticeForm.jsp?pageNum='+ i +'&pageSize='+pageSize+'">[ '+ i +' ]</a> ';
					}
					
					// 다음
					if(endPage < pageCount){
						t += '<a href="noticeForm.jsp?pageNum='+ (startPage+pageBlock) +'&pageSize='+pageSize+'">[ 다음 ]</a>';
					}
					return t;
				});
				
				
				
				$.getJSON('noticeView.jsp?pageNum='+pageNum+"&pageSize="+pageSize, function(data) {
					console.log(data);
					
					$.each(data, function(idx, item){

						 var t = "";
						 if(item.important == 1) {
							 t += "<tr style='background: #F2F2F2;'>";
							 t += "<td style='color: #FA5882;'>중요</td>";
						 } else {
							 t += "<tr>";
							 t += "<td>"+item.num+"</td>";
						 }

						 t += "<td id='sub"+idx+"'>"+item.subject+"</td>";
//						 t += "<td id='sub"+idx+"'><a href='content.jsp?num='"+item.num+">"+item.subject+"</a></td>";

						 t += "<td>"+item.id+"</td>";
						 t += "<td>"+item.date+"</td>";
						 t += "<td>"+item.readcount+"</td>";
						
						 t += "</tr>";
						 $('table').append(t);
						 
						 $('#sub'+idx).on('click', function(){
							 location.href="content.jsp?num="+item.num+"&pageNum="+pageNum + "&pageSize="+ pageSize;
						 });

					 });
				});
			});

	
	function changePageSize1(){
		pageSize = document.fr.changePageSize.value;
		location.href = "noticeForm.jsp?pageNum=" + pageNum + "&pageSize="+ pageSize;
	}
</script>
</head>
<body>

	<jsp:include page="../layout/layout_head.jsp" />

	<%
		String id = (String) session.getAttribute("id");

		String pageSize = request.getParameter("pageSize");
		if(pageSize == null){
			pageSize = "5";
		}
		
		userDAO ubao = new userDAO();
		int su = ubao.suUser(id);
	%>
	<form action="" name="fr">
		<select name="changePageSize" id="changePageSize" onchange="changePageSize1()">
			<option style="display: none;"><%=pageSize %>개씩 보기</option>
			<option value="5">5개씩 보기</option>
			<option value="10">10개씩 보기</option>
			<option value="15">15개씩 보기</option>
			<option value="20">20개씩 보기</option>
		</select>
	</form>
	
	<div class="clear"></div>
	
	<table border="1" class="board" style="margin-top: 30px; margin-bottom: 30px;">
		<tr class="bhead">
			<th class="bnum">글번호</th>
			<th class="bsub">제목</th>
			<th class="bname">글쓴이</th>
			<th class="bdate">작성일</th>
			<th class="bread">조회수</th>
		</tr>

	</table>

	<div id="noticePage"></div>

	<%
		if (su == 1) {
	%>
	<input class="insertButton" type="button" value="글쓰기"
		onclick="location.href='insertNoticeForm.jsp';">
	<%
		}
	%>


</body>
</html>