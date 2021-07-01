<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입</title>

<link rel="stylesheet" href="../css/insert.css">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Gugi&display=swap" rel="stylesheet">


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
    
    function id_check(){
    	var input_id = document.fr.id.value;
    	
    	if(document.fr.idcheck.value == "중복확인"){
    	
	    	if(input_id == ""){
	    		alert("아이디를 입력해 주세요.");
	    		document.fr.id.focus();
	    		return;
	    	}
	    	
	    	window.open("id_check.jsp?id=" + input_id,"아이디 중복 체크", "WIDTH=630, HEIGHT=430");
    	}
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
    
    function pw_check(){
    	if(document.fr.pw.value != ""){
	    	if(document.fr.pw.value == document.fr.pw2.value){
	    		document.fr.pw.readOnly = true;
	    		document.fr.pw2.readOnly = true;
	    		document.fr.pwcheck.value="체크완료"
	    	} else {
	    		alert("비밀번호가 다릅니다.");
	    		document.fr.pw.focus();
	    	}
    	} else {
    		alert("비밀번호를 입력해 주세요.");
    		document.fr.pw.focus();
    	}
    }
    
    function insertSubmit() {
    	if(document.fr.idcheck.value == "체크완료"){
    		if(document.fr.pwcheck.value == "체크완료"){
    			if(document.fr.emailcheck.value == "체크완료"){
    				if(document.fr.detailAddress.value != ""){
    					return true;			    					
    				} else {
    					alert("주소를 입력해 주세요.");
    					document.fr.detailAddress.focus();
    					return false;
    				}
    			} else {
    				alert("이메일 중복확인을 체크해 주세요.")
    				return false;
    			}
    		} else {
    			alert("비밀번호 체크를 확인해 주세요.");
    			return false;
    		}
    	} else {
    		alert("아이디 중복확인을 체크해주세요.");
    		return false;
    	}
    }
    
    function onReset() {
    	document.fr.id.readOnly = false;
    	document.fr.pw.readOnly = false;
    	document.fr.pw2.readOnly = false;
    	document.fr.email.readOnly = false;
    	document.fr.idcheck.value = "중복확인";
    	document.fr.pwcheck.value = "비밀번호체크";
    	document.fr.emailcheck.value = "중복확인";
    }
    
</script>

</head>
<body>
	<%
		String id = (String) session.getAttribute("id");
		if(id != null) {
			response.sendRedirect("../layout/main.jsp");
		}
	%>


	<jsp:include page="../layout/layout_head.jsp"/>
	<fieldset id="insertTable">
		<legend>[ 회원가입 ]</legend>
		<small>(* 필수항목)</small>
		<form action="insertPro.jsp" method="post" name="fr" onsubmit="return insertSubmit();">

			<table>
				<tr>
					<td>*</td>
					<td>아이디</td>
					<td colspan="3"><input type="text" name="id" id="id">
					<input type="button" name="idcheck" value="중복확인" class="qInfo" onclick="id_check();"></td>
				</tr>
				
				<tr>
					<td>*</td>
					<td>비밀번호</td>
					<td><input type="password" name="pw"></td>
				</tr>
				<tr>
					<td></td>
					<td>비밀번호 확인 </td>
					<td><input type="password" name="pw2"></td>
					<td><input type="button" value="비밀번호체크" name="pwcheck" class="qInfo" onclick="pw_check();"></td>
					
				</tr>
				
				<tr>
					<td>*</td>
					<td>이름</td>
					<td><input type="text" name="name"></td>
				</tr>
				
				<tr>
					<td></td>
					<td>생년/월/일</td>
					<td><input type="date" name="birth"></td>
				</tr>
				<tr>
					<td></td>
					<td>성별</td>
					<td><label>
						<input type="radio" name="gender" value="1" checked="checked">남
						<input type="radio" name="gender" value="2">여
					</label></td>
				</tr>
				
				<tr>
					<td>*</td>
					<td>email</td>
					<td colspan="3"><input type="email" name="email" id="email" style="width: 430px;"></td>
					<td><input type="button" name="emailcheck" value="중복확인" class="qInfo" onclick="email_check();"></td>
				</tr>
				
				
				<tr>
					<td></td>
					<td>전화번호</td>
					<td colspan="3">
						<input type="tel" name="tel" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="010-0000-0000">
					</td>
				</tr>
				<tr>
					<td rowspan="3">*</td>
					<td rowspan="3">주소</td>
					<td style="">우편번호</td>
					<td><input type="text" name="postcode" id="postcode" readonly></td>
					<td><input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="qInfo"></td>
				</tr>
				
				<tr>
					<td>주소</td>
					<td colspan="2"><input type="text" name="address" id="address" readonly></td>
				</tr>
				<tr>
					<td>상세주소</td>
					<td><input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소"></td>
					<td><input type="text" name="extraAddress" id="extraAddress"></td>
				</tr>
					
				<tr>
					<td> </td>
					<td>추천인</td>
					<td><input type="text" name="rec"></td>
				</tr>
				
			</table>
	
		<p style="text-align: center;">
		<input type="submit" value="회원가입하기"  class="qInfo"><input type="reset" value="다시작성" class="qInfo" onclick="onReset();">
		</p>
	</form>
	</fieldset>
</body>
</html>
