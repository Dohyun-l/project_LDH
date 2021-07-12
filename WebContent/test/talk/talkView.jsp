<%@page import="com.project_ldh.talkDTO"%>
<%@page import="com.project_ldh.talkDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<%
	String nickname = (String) session.getAttribute("nickname");

	if (nickname == null) {
		response.sendRedirect("name.jsp");
	}

	String idx = request.getParameter("idx");

	talkDAO tdao = new talkDAO();
	talkDTO tdto = tdao.getTalkInfo(Integer.parseInt(idx));
%>

<style type="text/css">
#talkContent {
	margin: 0 auto;
	padding: 0 3%;
	width: 70%;
	height: 600px;
	/* 	background: linear-gradient(to bottom left, skyblue, pink); */
	background-image: url('back.jpg');
	background-repeat: no-repeat;
	background-position: center;
	background-size: cover;
	overflow: scroll;
	overflow-x: hidden;
	font-size: 1.2em;
}

[id=nick<%=nickname%>] {
	text-align: right;
}

.nickname {
	color: #800080;
}

#content {
	width: 30%;
}

.content {
	background-color: #FFF56E;
	width: 20%;
	height: auto;
	display: inline-block;
}

#googleSearch {
	float: right;
}
</style>
</head>
<body>



	<script type="text/javascript">
	
	$(function(){

		$("#content").focus();
		
		$.ajax({
		    url: "printTalk.jsp",
		    data: { idx: <%=idx%>},
		    success: function(data){
		    	$("#talkContent").html(data);
		    	$("#talkContent").scrollTop(100000);
		    }
		});
		setInterval(function () {
			$.ajax({
			    url: "printTalk.jsp",
			    data: { idx: <%=idx%>},
			    success: function(data){
			    	$("#talkContent").html(data);
			    	$("#talkContent").scrollTop(100000);
			    }
			});
         }, 3000);
        
	});
	
	function writeContent() {
		var nickname = document.getElementById("nickname").value;
		var content = document.getElementById("content").value;
		
		if(content != ""){
			$(function(){
				$.ajax({
				    url: "updateTalk.jsp?idx=<%=idx%>",
						data : {
							nickname : nickname,
							content : content
						},
						method : "POST",
						success : function(data) {
							document.getElementById("content").value = "";
							$.ajax({
								url : "printTalk.jsp",
								data : {
									idx :<%=idx%>
								},
								success : function(data) {
									$("#talkContent").html(data);
									$("#talkContent").scrollTop(100000);
								}
							});
						}
					});

				});
			}
		}

		function enterKey() {
			if (window.event.keyCode == 13) {
				writeContent();
			}
		}
	</script>

	<h1><%=idx%>
		채팅방
	</h1>
	<h2><%=tdto.getTitle()%></h2>
	<a href="talkList.jsp">채팅방 리스트 보기</a>
	<br> 닉네임 :
	<input type="text" id="nickname" value="<%=nickname%>" readonly>
	내용 :
	<input type="text" id="content" onkeyup="enterKey()">
	<input type="button" value="전송" onclick="writeContent()">
	<br>
	<div style="float: left;">
		링크 거는 법 : &lt;a href="링크주소" target="_blank"&gt;(페이지명)&lt;/a&gt;<br>
		※ 키 설정 ※<br> 뿌요뿌요 : Enter 방향키 z x &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 메탈슬러그
		3 : Enter 방향키 z x s<br> 스노우 브라더스 2, 텐가이, 펭귄브라더스 : Enter 방향키 s x
		shift(동전넣기) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 붐버맨 : Enter 방향키 q a s x(이거밖에 안쓰는 듯) shift(동전넣기) <br>
		커비의 모험 : 시작: 엔터 이동: ←,→ 점프: Z 공중부양: ↑ 먹기&공격: X 기술흡수: 먹은상태에서 ↓ 기술뱉기: 쉬프트
	</div>
	<div style="float: right;">
		<a href="game/index.html" target="game">뛰어댕기기</a>
		<a href="game/타자/index.html" target="game">타자게임</a>
		<a href="https://www.retrogames.cc/embed/19912-super-puyo-puyo-tsuu-remix-japan.html" target="game">뿌요뿌요</a>
		<a href="//www.retrogames.cc/embed/9159-metal-slug-3-ngh-2560.html?old=1" target="game">메탈슬러그3</a>
		<a href="//www.retrogames.cc/embed/9876-snow-bros-2-with-new-elves.html" target="game">스노우 브라더스2</a><br>
		<a href="//www.retrogames.cc/embed/10279-tengai.html" target="game">텐가이</a>
		<a href="//www.retrogames.cc/embed/9447-penguin-brothers-japan.html" target="game">펭귄브라더스</a>
		<a href="//www.retrogames.cc/embed/9293-neo-bomberman.html" target="game">붐버맨</a>
		<a href="//www.retrogames.cc/embed/22129-kirby-s-adventure-usa.html" target="game">커비의 모험</a>
	</div>
	<hr style="clear: both;">
	<div id="talkContent" style="width: 50%; float: left;"></div>
	<iframe src="game/index.html" width="40%" height="600px" name="game"></iframe>

	<hr>


	<!-- Search Google -->
	<form method=get action="http://www.google.co.kr/search"
		target="_blank" id="googleSearch">
		<table bgcolor="#FFFFFF">
			<tr>
				<td><input type=text name=q size=25 maxlength=255 value="" />
					<!-- 구글 검색 입력 창 --> <input type=submit name=btnG value="Google 검색" />
					<!-- 검색 버튼 --></td>
			</tr>
		</table>
	</form>
	<!-- Search Google -->


</body>
</html>