<%@page import="com.project_ldh.userDAO"%>
<%@page import="com.project_ldh.itemBean"%>
<%@page import="com.project_ldh.itemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 구매</title>
<link rel="stylesheet" href="../css/boardstyle.css">
<link rel="stylesheet" href="../css/shopping.css">
<script src="../js/jquery-3.6.0.js"></script>

<script type="text/javascript">
	function updateItem(){
		if (document.fr2.updateButton.value == "상품 정보 수정"){
			document.fr.name.readOnly = false;
			document.fr.price.readOnly = false;
			document.fr.qty.readOnly = false;
			document.fr.point.readOnly = false;
			$(document).ready(function(){
				$('#img_size').fadeToggle();
			});
			document.fr2.updateButton.value = "수정 완료";
		} else {
			var check = confirm("상품 정보를 수정하시겠습니까?");
			if(check) {
				location.href="javascript:fr.submit();";
			} else {
				location.reload();
			}
		}
	}
	
	function deleteItem(){
		var num = document.fr.num.value;
		location.href="deleteItem.jsp?num="+num;
	}

</script>

</head>
<body>
	<jsp:include page="../layout/layout_head.jsp"/>

	<%
		String num = request.getParameter("num");
		String pageNum = request.getParameter("pageNum");
		String pageSize = request.getParameter("pageSize");
		String id = (String) session.getAttribute("id");
		
		userDAO ubao = new userDAO();
		int su = 0;
		if(id != null){
			su = ubao.suUser(id);
		}
	
		itemDAO idao = new itemDAO();
		
		if(num == null){
			response.sendRedirect("shopForm.jsp");
		}
		
		itemBean ib = idao.readItem(num);
		idao.readCountUp(num);
		
		if(num != null){
	%>
	<main>
		<div id="readcount">조회수 : <%=ib.getReadcount() %></div>
		<div class="clear"></div>
		<div id="showItem">
			<img alt="<%=ib.getName() %>" src="../upload/shop/<%=ib.getImg_name()%>"
			 width="<%=ib.getImg_width()%>px" height="<%=ib.getImg_height()%>px">
		</div>
		<div id="itemInfo">
			<form action="updateItem.jsp" method="post" name="fr">
				<input type="hidden" name="num" value="<%=ib.getNum()%>">
				<table border="1">
					<tr>
						<th colspan="2">상품 정보</th>
					</tr>
					<tr>
						<th>상품명</th>
						<td><input type="text" name="name" value="<%=ib.getName() %>" style="width:90%;" readonly></td>
					</tr>
					<tr>
						<th>가격</th>
						<td><input type="number" name="price" value="<%=ib.getPrice() %>" readonly>원</td>
					</tr>
					<tr>
						<th>상품사이즈</th>
						<td><input type="text" name="size" value="<%=ib.getSize() %>" readonly></td>
					</tr>
					<tr>
						<th>상품 재고 수량</th>
						<td><input type="number" name="qty" value="<%=ib.getQty() %>" readonly></td>
					</tr>
					<tr>
						<th>적립 포인트</th>
						<td><input type="number" name="point" value="<%=ib.getPoint() %>" readonly></td>
					</tr>
					<tr id="img_size" style="display: none;" >
						<th>그림 사이즈</th>
						<td>가로 : <input type="number" name="img_width" value="<%=ib.getImg_width()%>">px / 
						세로 : <input type="number" name="img_height" value="<%=ib.getImg_height()%>">px</td>
					</tr>
				</table>
			</form>
			
			<form action="../cart/insertCartPro.jsp?pageNum=<%=pageNum %>&pageSize=<%=pageSize %>" 
						name="fr2" method="post" onsubmit="return insertCartCheck()">
				<input type="hidden" name="itemnum" value="<%=ib.getNum()%>">
				<table border="1">
					<tr>
						<th colspan="2">구매</th>
					</tr>
					<tr>
						<th>구매 수량</th>
						<td><input type="number" name="ea" value="1" min="1" max="<%=ib.getQty()%>"></td>
					</tr>
					<tr>
						<td><input type="submit" value="장바구니 담기"></td>
						<td><input type="button" value="목록으로" onclick="location.href='shopForm.jsp?pageNum=<%=pageNum%>&pageSize=<%=pageSize%>'"></td>
					</tr>
					<%if(su==1){ %>
					<tr>
					<td><input type="button" value="상품 정보 수정" name="updateButton" onclick="updateItem();"></td>
					<td><input type="button" value="상품 삭제" name="deleteButton" onclick="deleteItem();"></td>
					</tr>
				 	<%} %>
				</table>
			</form>
		</div>
	</main>
	<%} %>
<script type="text/javascript">
	function insertCartCheck(){
		var id = "<%=id%>";
		if(id == "null"){
			var idCheck = confirm("장바구니에 담으시려면 로그인을 하셔야 합니다. 로그인 창으로 이동하시겠습니까?");
			if(idCheck){
				location.href="../user/loginForm.jsp";
				return false;
			} else {
				return false;
			}
		} else {
			var insertCartCheckQ = confirm("해당 상품을 장바구니에 추가하시겠습니까?");
			
			if(insertCartCheckQ){
				return;
			} else {
				return false;
			}
		}
		
	}
</script>
	
</body>
</html>