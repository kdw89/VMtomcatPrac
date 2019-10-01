<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>
<%
	String loginOK=null;
	String jumpURL="login.jsp?jump=login_test.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null) {
		response.sendRedirect(jumpURL);
		return;
	}
	if(!loginOK.equals("yes")) {
		response.sendRedirect(jumpURL);
		return;
	}
%>
</HEAD>
<BODY>
<center>
<h1> 로그인 오케이 </h1>
<br>
<br>
<a href="logout.jsp">로그아웃</a>
</center>
</BODY>
</HTML>