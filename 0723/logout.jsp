<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<center>
<%
	session.invalidate();
	out.println("<h2>로그아웃 되었습니다.</h2>");
	
	out.println("<input type=button value='메인페이지' OnClick=\"location.href='login_test.jsp'\">");
%>
</center>
</BODY>
</HTML>