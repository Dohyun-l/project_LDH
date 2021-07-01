<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	// 1975347818aff30b8c78be4bce58ffbd
	window.Kakao.init("1975347818aff30b8c78be4bce58ffbd");
	
	var loginInfo;
	
	
	function kakao_Login() {
		window.Kakao.Auth.login({
			scope:'profile, account_email, gender',
			success: function(authObj){
				
				console.log(authObj);
				window.Kakao.API.request({
				
					url:'/v2/user/me',
					success: res => {
					
						const kakao_account = res.kakao_account;
						console.log(kakao_account);
						
					}
					
				});
			}
		});
	}
	

</script>
</head>
<body>

	<a href="javascript:kakao_Login();"><img src="Kakao_Login_Logo.jpg"></a>


</body>
</html>