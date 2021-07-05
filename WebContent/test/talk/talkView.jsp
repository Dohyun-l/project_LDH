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
	String nickname = (String)session.getAttribute("nickname");

	if(nickname == null){
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
	height: 700px;
/* 	background: linear-gradient(to bottom left, skyblue, pink); */
 	background-image: url('back.jpg');
	background-repeat: no-repeat;
    background-position: center;
    background-size: contain;
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
				    data: {nickname: nickname, content:content},
				    method: "POST",
				    success: function(data){
				    	location.reload();
				    }
				});
				
			});
		}
	}
	
	function enterKey() {
		if(window.event.keyCode == 13){
			writeContent();
		}
	}

	</script>

	<h1><%=idx%> 채팅방</h1>
	<h2><%=tdto.getTitle() %></h2>
	<a href="talkList.jsp">채팅방 리스트 보기</a><br>
	닉네임 : <input type="text" id="nickname" value="<%=nickname%>" readonly>
	내용 : <input type="text" id="content" onkeyup="enterKey()">
	<input type="button" value="전송" onclick="writeContent()"><br>
	<div>
		링크 거는 법 : &lt;a href="링크주소" target="_blank"&gt;(페이지명)&lt;/a&gt;
	</div>
	<hr>
	<div id="talkContent" style="width: 50%; float: left;"></div>
	<iframe src="game/index.html" width="40%" height="700px"></iframe>
	
	<hr>
	
	
	<!-- Search Google -->
	<form method=get action="http://www.google.co.kr/search" target="_blank" id="googleSearch" >
		<table bgcolor="#FFFFFF">
			<tr>
				<td>
				<input type=text name=q size=25 maxlength=255 value="" />
				<!-- 구글 검색 입력 창 -->
				<input type=submit name=btnG value="Google 검색" />
				<!-- 검색 버튼 -->
				</td>
			</tr>
		</table>
	</form>
	<!-- Search Google -->
	
	
</body>
</html>