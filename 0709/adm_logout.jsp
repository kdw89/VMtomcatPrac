<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>
<style>
.text_border {
	text-shadow: -1px 0 #000000, 0 1px #000000, 1px 0 #000000, 0 -1px #000000;
}
#fixed{
	position:fixed;
	bottom:0%;
	right:0%;			/*브라우저 우하단에 고정*/
	width:fixed;
	padding:5px;
	color:white;
}

td {
	padding:5px
}
.outline{
	background-color: #ffffff;
	width: 500px;
	padding:20px;
	border-radius:20px;
	border: 5px solid gold;	
}
</style>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
</HEAD>
<BODY background='/0709/background.jpg'>
<br>
<center>
<div class='outline' >
<%
	session.invalidate();
	out.println("<h2>로그아웃 되었습니다.<br></h2>");
	out.println("<script>parent.menu.location.reload();</script>");
	out.println("<input type=button  class='btn btn-success btn-lg' value='메인페이지' OnClick=\"location.href='main.jsp'\">");
%>
</center>
</div>
</BODY>
</HTML>