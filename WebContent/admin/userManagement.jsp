<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/management.css">
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.getJSON("userView.jsp", function(data) {
			console.log(data);
			
			$.each(data, function(idx, item) {
				var t = '';
				t += '<tr>';
				t += '<th><input type="checkbox" name="num'+item.num+'"></th>';
				
				t += '<td><input type="text" name="num'+item.num+'" id="num'+item.num+'" value="'+item.num+'"></td>';
				t += '<td><input type="text" name="id'+item.num+'" id="id'+item.num+'" value="'+item.id+'"></td>';
				t += '<td><input type="password" name="pw'+item.num+'" id="pw'+item.num+'" value="'+item.pw+'"></td>';
				t += '<td><input type="text" name="name'+item.num+'" id="name'+item.num+'" value="'+item.name+'"></td>';
				t += '<td><input type="text" name="tel'+item.num+'" id="tel'+item.num+'" value="'+item.tel+'"></td>';
				
				t += '<td><input type="text" name="birth'+item.num+'" id="birth'+item.num+'" value="'+item.birth+'"></td>';
				t += '<td><input type="text" name="gender'+item.num+'" id="gender'+item.num+'" value="'+item.gender+'"></td>';
				t += '<td><input type="text" name="email'+item.num+'" id="email'+item.num+'" value="'+item.email+'"></td>';
				t += '<td><input type="text" name="addr'+item.num+'" id="addr'+item.num+'" value="'+item.addr+'"></td>';
				t += '<td><input type="text" name="cdate'+item.num+'" id="cdate'+item.num+'" value="'+item.cdate+'"></td>';
				
				t += '<td><input type="text" name="rec'+item.num+'" id="rec'+item.num+'" value="'+item.rec+'"></td>';
				t += '<td><input type="text" name="point'+item.num+'" id="point'+item.num+'" value="'+item.point+'"></td>';
				t += '<td><input type="text" name="su'+item.num+'" id="su'+item.num+'" value="'+item.su+'"></td>';
				
				t += '</tr>';
				
				$('table').append(t);
			});
			
		});
	});
</script>
</head>
<body>

	<table border="1">
		<tr>
			<th><input type="checkbox" value="all"></th>
			<th class="user_num">회원번호</th>
			<th class="user_id">아이디</th>
			<th class="user_pw">비밀번호</th>
			<th class="user_name">이름</th>
			<th class="user_tel">전화번호</th>
			<th class="user_birth">생년월일</th>
			<th class="user_gender">성별</th>
			<th class="user_email">이메일</th>
			<th class="user_addr">주소</th>
			<th class="user_cdate">가입일</th>
			<th class="user_rec">추천인</th>
			<th class="user_point">보유보인트</th>
			<th class="user_su">관리자</th>
		</tr>
	
	</table>

</body>
</html>