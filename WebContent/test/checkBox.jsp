<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="../js/jquery-3.6.0.js"></script>

</head>
<body>
	<%
		String[] ck = request.getParameterValues("ck");
	%>
	<script type="text/javascript">
		$(document).ready(function(){
			
			$('#insert').on('click', function(){
				var input = "<a href='#' id='b'>이동</a>";
				
				$('#a').html(input);
				
				alert($(".checkbox:checked").length);
			});
			
// 			$('#b').on('click', function(){
// 				alert("안녕");
// 			});
			
			$(document).on('click','#b',function(){
				alert("안녕");
			});
			
			
			
			$('.checkbox').on('click', function(){
				if ($(".checkbox:checked").length == $(".checkbox").length) {
					$("#chkBox").prop('checked', true);
					$('#checkBoxName').html("전체 선택");
					return;
				} else if($(".checkbox:checked").length == 0) {
					$('#checkBoxName').html("전체 해제");
					return;
				} else {
					$("#chkBox").prop('checked', false);
				}
				
				var t = "";
				
				$('.checkbox:checked').each(function() { 
					t += $(this).val() + " ";
				});
				
				$('#checkBoxName').html(t);
			});
		});
		
		
		function allCheck(){
			$(document).ready(function(){
				var isAllCheck = $("#chkBox").is(":checked");
				if (isAllCheck){
					$(".checkbox").prop('checked', true);
					$('#checkBoxName').html("전체 선택");
				} else {
					$(".checkbox").prop('checked', false);
					$('#checkBoxName').html("전체 해제");
				}
			});
		}
		
		
		
		
		
		
		
	</script>
	
	
	<div id="a"></div>
	<input type="button" id="insert" value="버튼">
	
	<hr>
	
	<form action="checkBoxPro.jsp" name="fr">
		<input type="checkbox" id="chkBox" value="all" onclick="allCheck();">전체선택 <br>
		<label><input type="checkbox" class="checkbox" value="1" name="ck">1</label>
		<label><input type="checkbox" class="checkbox" value="2" name="ck">2</label>
		<label><input type="checkbox" class="checkbox" value="3" name="ck">3</label>
		<label><input type="checkbox" class="checkbox" value="4" name="ck">4</label>
		<label><input type="checkbox" class="checkbox" value="5" name="ck">5</label>
		<label><input type="checkbox" class="checkbox" value="6" name="ck">6</label>
		<label><input type="checkbox" class="checkbox" value="7" name="ck">7</label>
		<label><input type="checkbox" class="checkbox" value="8" name="ck">8</label>
		<hr>
		<div id="checkBoxName"></div>
		
		<hr>
		
		<input type="submit">
	</form>
</body>
</html>