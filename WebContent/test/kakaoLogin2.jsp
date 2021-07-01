<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>카카오 로그인 테스트2</title>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

</head>
<body>

   <h1>카카오 로그인 테스트2(다른 계정으로 로그인 하기)</h1>

   <a id="reauthenticate-popup-btn" href="javascript:loginFormWithKakao()">
      <img
      src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg"
      width="222" />
   </a>
   
   <input type="button" value="로그아웃하기" onclick="logout()">
   <p id="reauthenticate-popup-result"></p>
   <script type="text/javascript">
   
   var email = "";
   var nickname = "";
   var image = "";
   var id = "";
   
   
   window.Kakao.init("1975347818aff30b8c78be4bce58ffbd");
   
      function loginFormWithKakao() {
    	
    	  if(id == ""){
    	  
    	  Kakao.Auth.loginForm({

            success : function(authObj) {
               console.log(authObj);
               window.Kakao.API.request({
                  
                  url:'/v2/user/me',
                  success: function(res) {
                  
                     const kakao_account = res.kakao_account;
                     console.log(kakao_account);
                     
                     email = kakao_account.email;
                     
                     nickname = kakao_account.profile.nickname;
                     
                     image = kakao_account.profile.profile_image_url;
                     
                     id = res.id;
                     
                     var img = "<img src='"+image+"'>";
                     
                     var t = ""
                     
                     t += JSON.stringify(authObj.access_token);
                     
                     t += "<table>";
                     t += "<tr>";
                     t += "<td>"+img+"</td>";
                     t += "<td> 아이디 : "+ id+"<br>닉네임 : "+nickname+"<br>이메일 : "+email+"<br>동의날짜 : "+res.connected_at	+"</td>";
                     
                     
                     t += "</tr>";
                     t += "</table>";
                     
                     showResultHTML(t);
                     
                  }
                  
               });
               
               
            },
            fail : function(err) {
               showResult(JSON.stringify(err))
            },
         })
         
    	  }
      }
      
      function showResult(result) {
         document.getElementById('reauthenticate-popup-result').innerText = result;
      }
      
      function showResultHTML(result) {
          document.getElementById('reauthenticate-popup-result').innerHTML = result;
       }
      
      
      function logout() {
    	  if (!Kakao.Auth.getAccessToken()) {
    		  showResultHTML("로그인해주세요.");
    		  return;
    		}
    		Kakao.Auth.logout(function() {
    		  console.log(Kakao.Auth.getAccessToken());
    		  showResultHTML("");
			  id = "";
    		});
      }
      
      
   </script>
   



</body>
</html>