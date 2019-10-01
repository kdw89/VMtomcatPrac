<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String id = request.getParameter("id");
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
	stmt.execute("delete from tupyo where id ="+ id);
	stmt.execute("delete from hubo where id ="+ id);
	stmt.close();
	conn.close();
%>
<center>
<a href=A_01.jsp><img src='./image/a1.png'/></a>
<a href=B_01.jsp><img src='./image/b0.png'/></a>
<a href=C_01.jsp><img src='./image/c0.png'/></a><br><br><br>
<h1>후보등록 결과 : 후보가 삭제 되었습니다.<h1>
</center>
</body>
</html>