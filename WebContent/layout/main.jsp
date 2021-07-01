<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="../css/SlideBar.css" rel="stylesheet">
<link rel="stylesheet" href="../css/boardstyle.css">
<script src="../js/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		var i = 1;
		setInterval(function(){
			$('#slide0'+ i++).removeAttr('checked');
			if(i > 6){
				i = 1;
			}
			$('#slide0'+ i).attr('checked','checked');
		}, 2000);
		
		var pageNum = 1;
		var pageSize = 5;
		
		$.getJSON('../board/noticeView.jsp?pageNum='+pageNum+"&pageSize="+pageSize, function(data) {
			console.log(data);
			
			$.each(data, function(idx, item){

				 var t = "";
				 if(item.important == 1) {
					 t += "<tr style='background: #F2F2F2;'>";
					 t += "<td style='color: #FA5882;'>중요</td>";
				 } else {
					 t += "<tr>";
					 t += "<td>"+item.num+"</td>";
				 }

				 t += "<td id='sub"+idx+"'>"+item.subject+"</td>";

				 t += "<td>"+item.id+"</td>";
				 t += "<td>"+item.date+"</td>";
				 t += "<td>"+item.readcount+"</td>";
				
				 t += "</tr>";
				 $('table').append(t);
				 
				 $('#sub'+idx).on('click', function(){
					 location.href="../board/content.jsp?num="+item.num+"&pageNum="+pageNum + "&pageSize="+ pageSize;
				 });

			 });
		});
		
		
	});
</script>

<style type="text/css">
.boardMain {
	width: 60%;
    float: right;
    margin: 5% 5% 0 0;
}

.slidewrap {
    float: left;
}

</style>


</head>
<body>
	
	<jsp:include page="layout_head.jsp"/>
	
	<div class="clear">
	
	<div class="section">
		<input type="radio" name="slide" id="slide01" checked>
		<input type="radio" name="slide" id="slide02">
		<input type="radio" name="slide" id="slide03">
		<input type="radio" name="slide" id="slide04">
		<input type="radio" name="slide" id="slide05">
		<input type="radio" name="slide" id="slide06">
		
		<div class="slidewrap">
			<ul class="slidelist">
				<li>
					<a>
						<label for="slide06" class="left"></label>
						<img src="../css/img/1.jpg">
						<label for="slide02" class="right"></label>
					</a>
				</li>
				<li>
					<a>
						<label for="slide01" class="left"></label>
						<img src="../css/img/2.jpg">
						<label for="slide03" class="right"></label>
					</a>
				</li>
				<li>
					<a>
						<label for="slide02" class="left"></label>
						<img src="../css/img/3.jpg">
						<label for="slide04" class="right"></label>
					</a>
				</li>
				<li>
					<a>
						<label for="slide03" class="left"></label>
						<img src="../css/img/4.jpg">
						<label for="slide05" class="right"></label>
					</a>
				</li>
				<li>
					<a>
						<label for="slide04" class="left"></label>
						<img src="../css/img/5.jpg">
						<label for="slide06" class="right"></label>
					</a>
				</li>
				<li>
					<a>
						<label for="slide05" class="left"></label>
						<img src="../css/img/6.jpg">
						<label for="slide01" class="right"></label>
					</a>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="boardMain">
		<form>
			<table border="1" class="board" style="margin-top: 30px; margin-bottom: 30px;">
				<tr class="bhead">
					<th class="bnum">글번호</th>
					<th class="bsub">제목</th>
					<th class="bname">글쓴이</th>
					<th class="bdate">작성일</th>
					<th class="bread">조회수</th>
				</tr>
			</table>
		</form>
	</div>
	

</body>
</html>