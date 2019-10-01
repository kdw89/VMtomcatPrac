<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String id = request.getParameter("id");
	String age = request.getParameter("age");			//id와 연령을 받아서
%>
<html>
<head>
<title>투ㅡ표</title>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	
	stmt.execute("insert into tupyo (id, age) values("+id+", "+age+")");
														//넣는다
	stmt.close();
	conn.close();
%>
<center>
<a href=A_01.jsp><img src='./image/a0.png'/></a>
<a href=B_01.jsp><img src='./image/b1.png'/></a>
<a href=C_01.jsp><img src='./image/c0.png'/></a><br><br><br>
<h1>투표 결과 : 투표하였습니다.<h1>
</center>
</body>
</html>