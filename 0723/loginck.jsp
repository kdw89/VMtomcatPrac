<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<center>
<%
	request.setCharacterEncoding("utf-8");
	
	String jump = request.getParameter("jump");
	String id = request.getParameter("id");
	String pass = request.getParameter("passwd");
	
	boolean bPassChk=false;
	
	if(id.replaceAll(" ","").equals("admin")&&pass.replaceAll(" ","").equals("admin"))
	{
		bPassChk=true;
	}else{
		bPassChk=false;
	}

	if(bPassChk) {
		session.setAttribute("login_ok","yes");
		session.setAttribute("login_id",id);
		response.sendRedirect(jump);
	} else {
		out.println("<h2>아이디 또는 패스워드 오류.</h2>");
		out.println("<input type=button value='로그인' OnClick=\"location.href='login.jsp?jump="+jump+"'\">");
	}
%>
</center>
</BODY>
</HTML>