<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<%
	String jump = request.getParameter("jump");
%>
<center>
<h1>관리자 로그인</h1>
<form method="post" action="loginck.jsp">
<table border=1>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="id"></id>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="passwd"></id>
	</tr>
	<tr>
		<td colspan=2 align=center><input type="submit" value="전송"> </td>
	</tr>
</table>
<input type="hidden" name="jump" value='<%=jump%>'>
</form>
</center>
</BODY>
</HTML>