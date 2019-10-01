<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.*, java.util.Date" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<%
	String key = request.getParameter("key");
	int key2 = Integer.parseInt(key);
	String level = request.getParameter("lv");
	int level2 = Integer.parseInt(level)+1;
	String recnt = request.getParameter("recnt");
	int recnt2 = Integer.parseInt(recnt)+1;
%>
<SCRIPT LANGUAGE="javaScript">
function submitForm(mode){
	fm.action = "gongji_write.jsp?key=INSERT";
	var title = document.getElementById("title").value.trim();
	var content = document.getElementById("content").value.trim();
	if(title == "") alert('제목을 입력하세요');
	else if(content == "") alert('내용을 입력하세요');
	else fm.submit();
}

</SCRIPT>
</head>
<body>
<center>
<%
	SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd");
	String created = sdt.format(new Date());
%>
<FORM METHOD=POST name='fm'>
<table width=650 border=1 cellspacing=0 cellpadding=5>

<tr>
<td><b>번호</b></td>
<td>댓글<input type=text name=id value='INSERT' readonly></td>
</tr>
<tr>
<td><b>제목</b></td>
<td><input type=text id=title name=title size=70 maxlength=70 ></td>
</tr>
<tr>
<td><b>일자</b></td>
<%
	out.println("<td>"+created+"</td>");
%>
</tr>
<tr>
<td><b>내용</b></td>
<td><textarea style='width:500px; height:250px;' id=content name=content cols=70 row=600></textarea></td>
</tr>
<tr>
<td><b>원글</b></td>
<td><input type=text id=root name=root size=70 maxlength=70 value='<%=key2%>' readonly></td>
</tr>
<tr>
<td><b>댓글수준</b></td>
<td><input type=text id=level name=level size=70 maxlength=70 value='<%=level2%>' readonly></td>
</tr>
<tr>
<td><b>댓글내순서</b></td>
<td><input type=text id=recnt name=recnt size=70 maxlength=70 value='<%=recnt2%>' readonly></td>
</tr>
</table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp'"></td>
<td><input type=button value="쓰기" OnClick="submitForm('write')"></td>
</tr>
</table>
</FORM>
</center>
</body>
</html>