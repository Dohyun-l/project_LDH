<%@page import="com.project_ldh.itemDAO"%>
<%@page import="com.project_ldh.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 보기</title>

<link rel="stylesheet" href="../css/boardstyle.css">
<link rel="stylesheet" href="../css/shopping.css">

<script src="../js/jquery-3.6.0.js"></script>
<%
// 	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
// 	int pageSize = Integer.parseInt(request.getParameter("pageSize"));
	int col = 5;
	String sPageNum = request.getParameter("pageNum");
	String sPageSize = request.getParameter("pageSize");
	
	int pageNum = 0;
	int pageSize = 0;
	
	if (sPageNum == null){
		pageNum = 1;
	} else {
		pageNum = Integer.parseInt(sPageNum);
	}
	
	if (sPageSize == null){
		pageSize = 10;
	} else {
		pageSize = Integer.parseInt(sPageSize);
	}
	
	itemDAO idao = new itemDAO();
	int cnt = idao.cntItem();
	
%>


<script type="text/javascript">
	$(document).ready(function(){
		
		var pageNum = <%=pageNum %>
		
		var col = <%=col %>;
		var pageSize = <%=pageSize %>;
		var cnt = <%=cnt %>;
		
		var pageCount = Math.floor(cnt/pageSize) + (cnt % pageSize == 0? 0 : 1);
		var pageBlock = 2;
		var startPage = Math.floor((pageNum -1)/pageBlock) * pageBlock + 1;
		var endPage = startPage + pageBlock -1;
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		$.getJSON("itemView.jsp?pageNum="+pageNum + "&pageSize="+pageSize, function(data) {
			console.log(data);
			
			$('#itemPage').html(function(){
				var t = ""
				if(startPage > pageBlock){
					t += '<a href="shopForm.jsp?pageNum=' + (startPage-pageBlock) + "&pageSize="+pageSize + '">[ 이전 ]</a>';
				}
				
				// 숫자 1....5
				for(var i=startPage; i<=endPage; i++){
					t += ' <a href="shopForm.jsp?pageNum='+ i + "&pageSize="+pageSize +'">[ '+ i +' ]</a> ';
				}
				
				// 다음
				if(endPage < pageCount){
					t += '<a href="shopForm.jsp?pageNum='+ (startPage+pageBlock) + "&pageSize="+pageSize +'">[ 다음 ]</a>';
				}
				return t;
			});
			
			$.each(data, function(idx, item){
				$('.itemNum'+(((pageNum-1)*pageSize)+idx)).attr("id", "itemNum"+item.num);
				$('.itemNum'+(((pageNum-1)*pageSize)+idx)).css("display", "inline-block");
				
				
				var t = ""
					
				t += "<div class='imgLayout'><img alr='"+item.name+"' src='../upload/shop/"+item.img_name+"'></div>";
				t += "<hr>";
				t += "" + item.name + "-" +item.size ;
				
				$('#itemNum'+item.num).append(t);
				
				$('#itemNum'+item.num).on('click', function(){
					location.href="buyItemForm.jsp?num="+item.num+"&pageNum="+pageNum + "&pageSize="+pageSize;
				});
				
				
			});
		});
		
	});

</script>

</head>
<body>

	<jsp:include page="../layout/layout_head.jsp" />

	<%
		String id = (String) session.getAttribute("id");
		
		userDAO ubao = new userDAO();
		int su = 0;
		if(id != null){
			su = ubao.suUser(id);
		}
		
		int line = pageSize/col + (pageSize%col == 0 ? 0 : 1);
		int lastline = cnt % col;
		
		%>
		<main>
		<%
		
		for(int i=0; i<line; i++){
			for(int j=0; j<col; j++){
				%>
				<div class="item itemNum<%=((pageNum-1)*pageSize)+(i*col)+j %>"></div>
				<%
			}
			%><br><%
		}
	%>
	</main>
	
	<div id="itemPage"></div>
	
	<div class="clear"></div>
	
	<%
		if (su == 1) {
	%>
	<input class="insertButton" type="button" value="글쓰기" style="margin-right: 15%;"
		onclick="location.href='insertItemForm.jsp';">
	<%
		}
	%>


</body>
</html>