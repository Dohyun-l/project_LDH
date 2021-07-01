<%@page import="java.sql.SQLException"%>
<%@page import="com.project_ldh.userBean"%>
<%@page import="com.project_ldh.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원정보 조회</title>

<link rel="stylesheet" href="../css/insert.css">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">

<script src="../js/jquery-3.6.0.js"></script>

<script type="text/javascript">
	$(document).ready(function(){
		
		$('#changeEmail').click(function(){
			var changeEmailState = $('#changeEmail').val();
			if(changeEmailState == '변경하기'){ 
				$('#changeEmailText').fadeToggle('slow',function(){});
				document.fr.changeEmail.value = '변경취소';
			} else if(changeEmailState == '변경취소'){
				$('#changeEmailText').fadeToggle('slow',function(){});
				document.fr.changeEmail.value = '변경하기';
			}
		});
		
		$('#changeTel').click(function(){
			var changeTelState = $('#changeTel').val();
			if(changeTelState == '변경하기'){ 
				$('#changeTelText').fadeToggle('slow',function(){});
				document.fr.changeTel.value = '변경취소';
			} else if(changeTelState == '변경취소'){
				$('#changeTelText').fadeToggle('slow',function(){});
				document.fr.changeTel.value = '변경하기';
			}
		});
		
		$('#changeAddr').click(function(){
			var changeAddrState = $('#changeAddr').val();
			if(changeAddrState == '변경하기'){ 
				$('.changeAddrText').fadeToggle('slow',function(){});
				document.fr.changeAddr.value = '변경취소';
			} else if(changeAddrState == '변경취소'){
				$('.changeAddrText').fadeToggle('slow',function(){});
				document.fr.changeAddr.value = '변경하기';
			}
		});
	});
</script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
    
    
    function email_check(){
    	var input_email = document.fr.email.value;
    	
    	var eIndex = "";
		var datIndex = ["co.kr", ".com", ".net", "or.kr", "go.kr"];
    	
		eIndex = input_email.indexOf('@');
		
		if(document.fr.emailcheck.value == "중복확인"){
	    	
	    	if(input_email == ""){
	    		alert("이메일을 입력해 주세요.");
	    		document.fr.email.focus();
	    		return;
	    	}
		
		
	    	if(eIndex != -1){
				for(var i in datIndex){
					if(input_email.indexOf(datIndex[i]) > 0){
						window.open("email_check.jsp?email=" + input_email,"이메일 중복 체크", "WIDTH=630, HEIGHT=430");
						return;
					}
				}
				if(input_email.indexOf(datIndex[i]) == -1){
					alert("이메일 형식이 잘못되었습니다.");
					document.fr.email.focus();
					return;
				}
			}else{
				alert("이메일 형식이 잘못되었습니다.");
				document.fr.email.focus();
				return;
			}
    	}
    }
    
    function onReset() {
    	document.fr.email.readOnly = false;
    	document.fr.emailcheck.value = "중복확인";
    }
    
    function updateSubmit(){
    	
    	var checkpw = prompt('비밀번호를 입력하세요', '');
    	
    	if(checkpw == document.fr.pw.value){
	    	if(document.fr.changeEmail.value == "변경취소"){
				if(document.fr.email.value == ""){
					alert("변경할 이메일을 작성해 주세요.");
					document.fr.email.focus();
					return false;
				}
	    		if(document.fr.emailcheck.value == '중복확인'){
	    			alert("변경하실 이메일의 중복확인을 해주세요.");
	    			document.fr.email.focus();
	    			return false;
	    		}
	    	} else {
	    		document.fr.email.value = document.fr.e_email.value;
	    	}
	    	
			if(document.fr.changeAddr.value == "변경취소"){
				if(document.fr.detailAddress.value == ""){
					alert("변경할 주소를 작성해 주세요.");
					document.fr.detailAddress.focus();
					return false;
				} else {
					document.fr.addr.value = "(" + document.fr.postcode.value + ")" + document.fr.address.value
					+ ", " + document.fr.detailAddress.value + document.fr.extraAddress.value;
				}
	    	}
			
			if(document.fr.changeTel.value == "변경취소"){
				if(document.fr.tel.value == ""){
					alert("변경할 전화번호를 작성해 주세요.");
					document.fr.tel.focus();
					return false;
				}	
	    	} else {
	    		document.fr.tel.value = document.fr.e_tel.value;
	    	}
	    } else {
	    	alert("정확한 비밀번호를 입력해주세요.");
	    	return false;
	    }
    }
</script>

</head>
<body>

	<jsp:include page="../layout/layout_head.jsp"/>
	<%
		String id = (String)session.getAttribute("id");
	
		if (id == null){
			response.sendRedirect("../layout/main.jsp");
		}
		
		 
		userDAO ubao = new userDAO();
		userBean ub = ubao.readInfo(id);
		
		System.out.println(ub);
		
		if(ub != null){
	%>
	
	<fieldset id="insertTable">
		<legend>[ 회원정보 ]</legend>
		<form action="updatePro.jsp" method="post" name="fr" onsubmit="return updateSubmit();">

			<table>
				<tr>
					<td>아이디</td>
					<td colspan="3"><input type="text" name="id" id="id" value="<%=ub.getId() %>" readonly>
					<td><input type="hidden" name="num" value="<%=ub.getNum()%>"></td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td><input type="password" readonly="readonly"></td>
					<td><input type="hidden" id="pw" name="pw" value="<%=ub.getPw()%>"></td>
				</tr>
				
				<tr>
					<td>이름</td>
					<td><input type="text" name="name" value="<%=ub.getName()%>" readonly></td>
				</tr>
				
				<tr>
					<td>생년/월/일</td>
					<td><input type="date" name="birth" value="<%=ub.getBirth() %>" readonly></td>
				</tr>
				<tr>
					<td>성별</td>
					<td><label>
					
						<input type="radio" name="gender" value="1" 
						<%if(ub.getGender() == 1){ %>checked="checked" <%} %> readonly>남
						<input type="radio" name="gender" value="2"
						<%if(ub.getGender() == 2){ %>checked="checked" <%} %> readonly>여
					</label></td>
				</tr>
				
				<tr>
					<td>email</td>
					<td colspan="3"><input type="email" name="e_email" id="e_email" readonly style="width: 430px;" value="<%=ub.getEmail()%>"></td>
					<td><input type="button" value="변경하기" class="qInfo" id="changeEmail"></td>
				</tr>
				<tr id="changeEmailText" style="display: none;">
					<td>변경 email</td>
					<td colspan="3"><input type="email" name="email" id="email" style="width: 430px;"></td>
					<td><input type="button" name="emailcheck" value="중복확인" class="qInfo" onclick="email_check();"></td>
				</tr>

				<tr>
					<td>주소</td>
					<td colspan="3"><input type="text" name="addr" id="addr" readonly value="<%=ub.getAddr()%>" style="width: 430px;"></td>
					<td><input type="button" value="변경하기" class="qInfo" id="changeAddr"></td>
				</tr>
				
				<tr class="changeAddrText" style="display: none;">
					<td rowspan="3">변경<br> 주소</td>
					<td style="">우편번호</td>
					<td><input type="text" name="postcode" id="postcode" readonly></td>
					<td><input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="qInfo"></td>
				</tr>
				<tr class="changeAddrText" style="display: none;">
					<td>주소</td>
					<td colspan="2"><input type="text" name="address" id="address" readonly></td>
				</tr>
				<tr class="changeAddrText" style="display: none;">
					<td>상세주소</td>
					<td><input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"></td>
					<td><input type="text" name="extraAddress" id="extraAddress"></td>
				</tr>
					
				<tr>
					<td>전화번호</td>
					<td colspan="3">
						<input type="text" name="e_tel" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"
						 placeholder="010-0000-0000" value="<%=ub.getTel() %>" readonly>
					</td>
					<td><input type="button" value="변경하기" class="qInfo" id="changeTel"></td>
				</tr>
				
				<tr id="changeTelText" style="display: none;">
					<td>변경<br>전화번호</td>
					<td><input type="tel" name="tel" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}"
						 placeholder="010-0000-0000"></td>
				</tr>
				
			</table>
	
		<p style="text-align: center;">
		<input type="submit" value="정보수정하기" class="qInfo">
		<input type="reset" value="다시작성" class="qInfo" onclick="onReset();">
		<input type="button" value="회원탈퇴하기" class="qInfo" onclick="location.href='deleteForm.jsp'">
		</p>
		<%} %>
	</form>
	</fieldset>
</body>
</html>
