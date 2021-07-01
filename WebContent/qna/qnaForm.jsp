<%@page import="com.project_ldh.qnaDAO"%>
<%@page import="com.project_ldh.userDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Q&A</title>

<link rel="stylesheet" href="../css/boardstyle.css">

<script src="../js/jquery-3.6.0.js"></script>
<% String id = (String) session.getAttribute("id"); %>
<script type="text/javascript">
	var pageNum = <%=request.getParameter("pageNum") %>
	var pageSize = <%=request.getParameter("pageSize") %>
	
	if(pageNum == null){
		pageNum = 1;
	}
	
	if(pageSize == null){
		pageSize = 5;
	}
	
	var cnt = <%=new qnaDAO().getBoardCount() %>;
	
	
	var pageCount = Math.floor(cnt/pageSize) + (cnt % pageSize == 0? 0 : 1);
	var pageBlock = 2;
	var startPage = Math.floor((pageNum -1)/pageBlock) * pageBlock + 1;
	var endPage = startPage + pageBlock -1;
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	
	

	$(document).ready(function() {

				$('#qnaPage').html(function(){
					var t = ""
					if(startPage > pageBlock){
						t += '<a href="qnaForm.jsp?pageNum=' + (startPage-pageBlock) + '&pageSize='+pageSize+'">[ 이전 ]</a>';
					}
					
					// 숫자 1....5
					for(var i=startPage; i<=endPage; i++){
						t += ' <a href="qnaForm.jsp?pageNum='+ i +'&pageSize='+pageSize+'">[ '+ i +' ]</a> ';
					}
					
					// 다음
					if(endPage < pageCount){
						t += '<a href="qnaForm.jsp?pageNum='+ (startPage+pageBlock) +'&pageSize='+pageSize+'">[ 다음 ]</a>';
					}
					return t;
				});
				
				
				
				$.getJSON('qnaView.jsp?pageNum='+pageNum+"&pageSize="+pageSize, function(data) {
					console.log(data);
					
					$.each(data, function(idx, item){

						var t = "";
						t += "<tr id='qnam"+idx+"'>";
						if(item.important == 1) {
							 t += "<td style='color:red;'>중요</td>";
						} else {
							 t += "<td>"+item.num+"</td>";
						}

						t += "<td id='sub"+idx+"'>"+item.subject+"</td>";

						t += "<td id='qnaid"+item.num+"'>"+item.id+"<input type='hidden' id='qnapw"+item.num+"' value='"+item.pw+"'></td>";
						t += "<td>"+item.date+"</td>";
						
						t += "</tr>";
						t += "<tr style='display:none; height: 100px;' id='qna"+idx+"'><td>내용</td>";
						t += "<td><textarea id='qcon"+item.num+"' rows='5px' cols='170px' style='border-style: none;' readonly>" + item.content + "</textarea></td>"
						t += "<td colspan='2'>"
						t += "<input id='qconb"+ item.num +"' name='qcon"+ item.num +"' type='button' value='글 수정'"
							 						+" style='font-size:1em; border-left-style: solid;' onclick='updateQna("+item.num+")'>";
						t += "<input type='button' value='글 삭제' style='font-size:1em; border-left-style: solid;'"
							    + " onclick='deleteQna("+item.num+");'>";
					    t += "<input type='button' id='insertComment"+item.num+"' value='답글달기' style='font-size:1em; border-left-style: solid;"
						    	+ "border-right-style: solid;'>";
						t += "</td></tr>";
						
						t += "<tr style='display: none; background-color: rgb(245 237 216);' id='insertCommentLine"+item.num+"'><td>답글작성</td>";
						t += "<td><textarea id='qcomment"+item.num+"' rows='5px' cols='170px'></textarea></td>";
						t += "<td colspan='2'><input id='insertCommentButton"+item.num+"' type='button' value='작성하기' style='font-size:1em; border-left-style: solid;"
					    	+ "border-right-style: solid;'></td>"
						t += "</tr>";
						 
						 
						$('table').append(t);
						
						$('#sub'+idx).on('click', function(){
							// location.href="qnaContent.jsp?num="+item.num+"&pageNum="+pageNum + "&pageSize="+ pageSize;
							$('#qna'+idx).fadeToggle();
							$('#insertCommentLine'+item.num).css('display', 'none');
							$('.insertCommentLine'+item.num).css('display', 'none');
							$('.reqna'+item.num).remove();
							if($('#qnam'+idx).css('background-color') == 'rgb(192, 192, 192)'){
								$('#qnam'+idx).css('background','white');
							} else {
								$('#qnam'+idx).css('background','silver');
							}
						});
						
						
						$('#insertComment'+item.num).on('click', function(){
							$('#insertCommentLine'+item.num).fadeToggle();
							$('.reqna'+item.num).remove();
							$.ajax('reQnaView.jsp?re_ref='+item.re_ref, {
								success: function(data) {
									$('#qna'+idx).after(data);
								}
							});
							
						});

						$('#insertCommentButton'+item.num).on('click', function(){
							if('<%=id%>' != 'null'){
								if ($('#qcomment'+item.num).val() == ""){
									alert("글을 작성해 주세요.");	
									$('#qcomment'+item.num).focus();
								} else {
									$.ajax({
										type: 'post',
										url: 'insertQnaComment.jsp',
										data: {num:item.num, content: $('#qcomment'+item.num).val(), re_lev:item.re_lev},
										success: function(){
											alert("작성완료");
											location.reload();
										}
									});
								}
							} else {
								loginGo();
							}
						});
					});
				});
			});

	function updateQna(num){
		$(document).ready(function() {
			if($('#qnaid'+num).text() == '<%=id%>'){
				console.log($('#qconb'+num).val());
				if($('#qconb'+num).val() == "글 수정"){
					$('#qconb'+num).val("수정/취소");
					$('#qcon'+num).removeAttr('readonly');
					$('#qcon'+num).focus();
				} else {
					$('#qconb'+num).val("글 수정");
					$('#qcon'+num).attr('readonly','readonly');
					var updateCheck = prompt("글을 수정 하시겠습니까?", "");
					if (updateCheck == $('#qnapw'+num).val()){
						 $.ajax({
							type: "post",
							url: 'updateQna.jsp',
							data: {num:num, content: $('#qcon'+num).val()},
							success: function(data){
								if(data == 1) alert("변경완료");
							}
						});
					} else if (updateCheck == null){
						alert("수정 취소");
						location.reload();
						return false;
					} else if (updateCheck == ""){
						alert("비밀번호를 입력해주세요");
						location.reload();
						return false;
					} else {
						alert("비밀번호가 다릅니다.");
						location.reload();
						return false;
					}
				}
			} else {
				alert("글을 수정할 권한이 없습니다.");
			}
		});
	}
	
	function insertComment(num){
		$(document).ready(function(){
			$('#insertCommentLine'+num).fadeToggle();
			
		});
	}
	
	function insertCommentButton(num){
		$(document).ready(function(){
			if('<%=id%>' != 'null'){
				if ($('#qcomment'+num).val() == ""){
					alert("글을 작성해 주세요.");	
					$('#qcomment'+num).focus();
				} else {
					$.ajax({
						type: 'post',
						url: 'insertQnaComment.jsp',
						data: {num:num, content: $('#qcomment'+num).val(), re_lev:$('#qnare_lev'+num).val()},
						success: function(){
							alert("작성완료");
							location.reload();
						}
					});
				}
			} else {
				loginGo();
			}
		});
	}

	
	function changePageSize1(){
		pageSize = document.fr.changePageSize.value;
		location.href = "qnaForm.jsp?pageNum=" + pageNum + "&pageSize="+ pageSize;
	}
	
	function loginGo(){
		var check = confirm("로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?");
		
		if(check){
			location.href="../user/loginForm.jsp";
		}
		
	}
	
	function deleteQna(num){
		var checkPw = prompt("글을 삭제하시겠습니까?", "");
		
		if(checkPw == null){
			return false;
		} else if(checkPw == ""){
			alert("비밀번호를 입력해 주세요.");
			return false;
		} else {
			location.href='deleteQnaPro.jsp?num='+ num + "&checkPw="+checkPw;
		}
	}
	
	
</script>
</head>
<body>

	<jsp:include page="../layout/layout_head.jsp" />


	<%
		

		String pageSize = request.getParameter("pageSize");
		if(pageSize == null){
			pageSize = "5";
		}
	%>
	<form action="" name="fr">
		<select name="changePageSize" id="changePageSize" onchange="changePageSize1()">
			<option style="display: none;"><%=pageSize %>개씩 보기</option>
			<option value="5">5개씩 보기</option>
			<option value="10">10개씩 보기</option>
			<option value="15">15개씩 보기</option>
			<option value="20">20개씩 보기</option>
		</select>
	</form>
	
	<div class="clear"></div>
	
	<table border="1" class="board" style="margin-top: 30px; margin-bottom: 30px;">
		<tr class="bhead">
			<th class="bnum">글번호</th>
			<th class="bsub">제목</th>
			<th class="bname">글쓴이</th>
			<th class="bdate" style="width: 20%;">작성일</th>
		</tr>

	</table>

	<div id="qnaPage"></div>

	
	<input class="insertButton" type="button" value="글쓰기"
		<%if(id == null){%>
			onclick="loginGo();"
		<%} else {%>
			onclick="location.href='insertQnaForm.jsp';"
		<% }%>>
	


</body>
</html>