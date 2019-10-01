<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.*, java.util.Date" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<SCRIPT LANGUAGE="javaScript">
function submitForm(mode){
	fm.action = "gongji_write.jsp?key=INSERT";
	var title = document.getElementById("title").value.trim();
	var content = document.getElementById("content").value.trim();
	if(title == "") alert('제목을 입력하세요');
	else if(content == "") alert('내용을 입력하세요');
	else fm.submit();
}									//제목, 내용 작성여부 체크

</SCRIPT>
</head>
<body>
<center>

<%
	SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd");
	String created = sdt.format(new Date());			//현재시간
%>
<FORM METHOD=POST name='fm'>
<table width=650 border=1 cellspacing=0 cellpadding=5>

<tr>
<td><b>번호</b></td>
<td>신규(insert)<input type=hidden name=id value='INSERT' ></td>
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