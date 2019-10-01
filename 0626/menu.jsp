<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String btn = request.getParameter("btn");	//get방식으로 숫자 수신
%>
<html>
<head>
</head>
<body>
<center>
<%
	if (btn == null) {
		btn = "1";
	}
	int btnEnable = Integer.parseInt(btn);
	int a = 0, b = 0, c = 0;
	if(btnEnable == 1)	a = 1;
	if(btnEnable == 2)	b = 1;
	if(btnEnable == 3)	c = 1;
	out.println("<a href=A_01_H.jsp target=main onclick=top.menu.location='menu.jsp?btn="
			+ 1 +"'><img src='./image/a"+a+".png'/></a>");
	out.println("<a href=B_01_H.jsp target=main onclick=top.menu.location='menu.jsp?btn="
			+ 2 +"'><img src='./image/b"+b+".png'/></a>");
	out.println("<a href=C_01_H.jsp target=main onclick=top.menu.location='menu.jsp?btn="
			+ 3 +"'><img src='./image/c"+c+".png'/></a>");
%>
</center>
</body>
</html>