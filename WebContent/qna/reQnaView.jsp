<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.project_ldh.qnaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	qnaDAO qdao = new qnaDAO();
	
	String re_ref = request.getParameter("re_ref");
	
	JSONArray reQnaList = new JSONArray();
	reQnaList = qdao.getReQnaList(re_ref);
	
	for(int i=0; i<reQnaList.size(); i++){
		JSONObject qb = (JSONObject) reQnaList.get(i);
%>
<tr class='reqna<%=qb.get("re_ref") %>'>
<td><%for(int j=1; j < (Integer)qb.get("re_lev"); j++){%><img src="level.gif"> <%} %><img src="re.gif"></td>
<td><textarea id='qcon<%=qb.get("num") %>' rows='2px' cols='170px' style='border-style: none;' readonly><%=qb.get("content") %></textarea></td>
<td id='qnaid<%=qb.get("num") %>'><%=qb.get("id") %><input type="hidden" id="qnapw<%=qb.get("num")%>" value="<%=qb.get("pw") %>">
<input type="hidden" id="qnare_lev<%=qb.get("num")%>" value="<%=qb.get("re_lev") %>">
</td>
<td colspan='2'>
<input id='qconb<%=qb.get("num") %>' name='qcon<%=qb.get("num") %>' type='button' value='글 수정' style='font-size:1em; border-left-style: solid;' onclick="updateQna(<%=qb.get("num")%>)">
<input type='button' value='글 삭제' style='font-size:1em; border-left-style: solid;' onclick="deleteQna(<%=qb.get("num") %>)">
<input type='button' id='insertComment<%=qb.get("num") %>' value='답글달기' style='font-size:1em; border-left-style: solid; border-right-style: solid;' onclick="insertComment(<%=qb.get("num")%>)">
</td>
</tr>
<tr style='display: none; background-color: rgb(245 237 216);' id='insertCommentLine<%=qb.get("num") %>' class="insertCommentLine<%=qb.get("re_ref") %>"><td>답글작성</td>
<td><textarea id='qcomment<%=qb.get("num") %>' rows='5px' cols='170px'></textarea></td>
<td colspan='2'><input id='insertCommentButton<%=qb.get("num") %>' type='button' value='작성하기' onclick="insertCommentButton(<%=qb.get("num") %>)" style='font-size:1em; border-left-style: solid; border-right-style: solid;'></td>
</tr>
<%}%>