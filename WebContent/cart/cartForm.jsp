<%@page import="com.project_ldh.userBean"%>
<%@page import="com.project_ldh.userDAO"%>
<%@page import="com.project_ldh.cartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장바구니</title>
<link href="../css/boardstyle.css" rel="stylesheet">
<style type="text/css">
b {
	font-size: 2em;
}
h1 {
	margin: 100px auto;
	text-align: center;
	text-shadow: 10px 10px 20px skyblue, -10px 10px 20px skyblue,
				 -10px -10px 20px pink, 10px -10px 20px pink;
	font-size: 5em;
	color: white;
	border-bottom-style: solid;
}


</style>
<script src="../js/jquery-3.6.0.js"></script>

</head>
<body>
	<jsp:include page="../layout/layout_head.jsp"/>
	<%
	String id = (String) session.getAttribute("id");
	
	if(id == null){
	%>
		<div><h1>로그인 하셔야 이용 가능합니다.</h1></div>
	
	
	<%
	} else {
	%>
	<script type="text/javascript">
		$(document).ready(function(){
			$.getJSON('cartView.jsp', function(data) {
				
				console.log(data);
				
				var total = "";
				var totalPrice = 0;
				
				total += "<tr><td colspan='6'><b>합계</b> : ";
				
				$.each(data, function(idx, item){
					var t = "";
					t += "<tr>";
					t += "<td style='width: 10%;'><img alr='" + item.cartName + "' src='../upload/shop/" + item.cartImg_name + "' width='80%'></td>";
					t += "<td>"+item.cartName+"-"+item.cartSize+"</td>";
					t += "<td>"+item.cartDate+"</td>";
					t += "<td>"+item.cartPrice+"</td>";
					t += "<td>"+item.cartQty+"</td>";
					t += "<td>"+(item.cartQty * item.cartPrice)+"원</td>";
					t += "</tr>";
					
					total += item.cartName + "(" + (item.cartQty * item.cartPrice) + "원)";
					
					totalPrice += (item.cartQty * item.cartPrice); 
					
					$('#itemT').append(t);
					if(idx != (Object.keys(data).length)-1){
						total += " + ";
					} 
					
					
					
				});
				total += "=<b>" + totalPrice + "</b>원</td></tr>";
				$('#itemT').append(total);
			});
		});
	</script>
	
	
	<%
		userDAO udao = new userDAO();
		userBean ub = udao.readInfo(id);
		
	
	%>
	<fieldset class="cartField">
		<legend style="text-align: center;">[ 상품정보 ]</legend>
		<table border="1" class="board cart" id="itemT">
			<tr>
				<th class="itemInfo" colspan="2">상품정보</th>
				<th class="itemDate">주문일자</th>
				<th class="itemPrice">주문금액</th>
				<th class="itemQty">수량</th>
				<th class="itemSum">합계</th>
			</tr>
		</table>
	</fieldset>
	<fieldset class="cartField">
		<legend style="text-align: center;">[ 고객 정보 ]</legend>
		<table border="1" class="board cart" id="userT">
			<tr>
				<th class="itemName">고객명ID</th>
				<th class="itemAddr">주소</th>
				<th class="itemUserName">이름</th>
				<th class="itemTel">전화번호</th>
				<th class="itemEmail">이메일</th>
			</tr>
			<tr>
				<td><%=ub.getId() %></td>
				<td><%=ub.getAddr() %></td>
				<td><%=ub.getName() %></td>
				<td><%=ub.getTel() %></td>
				<td><%=ub.getEmail() %></td>
			</tr>
		</table>
	</fieldset>
<%} %>
</body>
</html>