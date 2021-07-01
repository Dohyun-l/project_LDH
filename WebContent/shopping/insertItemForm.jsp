<%@page import="com.project_ldh.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품 등록</title>
<link href="../css/boardstyle.css" rel="stylesheet">
<style type="text/css">
.board input {
	text-align: center;
	border-bottom-style: solid;
}

.button {
	margin: 0 10px;
	border-style: none;
	font-size: 1.2em;
}
</style>

<script type="text/javascript">
	function insertItem(){
		if(document.fr.name.value == ""){
			alert("상품명을 기입해 주세요.");
			document.fr.name.focus();
			return false;
		}
		
		if(document.fr.price.value == ""){
			alert("상품 가격을 기입해 주세요.");
			document.fr.price.focus();
			return false;
		}
		
		if(document.fr.qty.value == ""){
			alert("상품의 수량을 기입해 주세요.");
			document.fr.qty.focus();
			return false;
		}
		
		if(document.fr.size.value == ""){
			alert("상품의 사이즈를 선택해주세요.");
			return false;
		}
		
		if(document.fr.img_name.value == ""){
			var img_check = confirm("이미지가 등록되어 있지 않습니다. 이미지 등록 없이 진행하시겠습니까?");
			if(img_check){
				return;
			} else {
				return false;
			}
		}
	}

</script>

</head>
<body>
	<jsp:include page="../layout/layout_head.jsp"/>
	
	<%
		String id = (String) session.getAttribute("id");
		
		userDAO ubao = new userDAO();
		int su = 0;
		if(id != null){
			su = ubao.suUser(id);
		}
		
		if (su != 1){
			response.sendRedirect("shopForm.jsp");
		}
		
		%>

	<h1 style="text-align: center;">상품 등록</h1>
	
	<form action="insertItemPro.jsp" method="post" name="fr"  enctype="multipart/form-data" onsubmit="return insertItem()">
		
		<table border="1"  class="board" style="width: 30%;">
			<tr>
				<th>상품명</th>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><input type="number" name="price" min="0">원</td>
			</tr>
			<tr>
				<th>수량</th>
				<td><input type="number" name="qty" min="0"></td>
			</tr>
			<tr>
				<th>사이즈</th>
				<td>
				<label><input type="radio" name="size" value="S">S</label>
				<label><input type="radio" name="size" value="M">M</label>
				<label><input type="radio" name="size" value="L">L</label>
				<label><input type="radio" name="size" value="XL">XL</label>
				</td>
			</tr>
			<tr>
				<th>적립포인트</th>
				<td><input type="number" name="point" min="0"></td>
			</tr>
			<tr>
				<th>이미지</th>
				<td><input type="file" name="img_name" style="border-style: none; font-size: 1em;"></td>
			</tr>
			<tr>
				<th>이미지 크기</th>
				<td>가로 : <input type="number" name="img_width" value="500" style="width: 100px" min="0">px /
				 세로 : <input type="number" name="img_height" value="700" style="width: 100px" min="0">px</td>
			</tr>
		</table>
		<div style="margin: 30px auto; display: table;">
			<input type="submit" value="등록하기" class="button">
			<input type="reset" value="재작성하기" class="button">
		</div>
	</form>

</body>
</html>