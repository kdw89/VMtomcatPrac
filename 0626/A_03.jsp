<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String name = request.getParameter("name");		//이름만 받아온다
	
	String name2=new String(name.getBytes("8859_1"),"utf-8");
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
	ResultSet rset = stmt.executeQuery("select id from hubo");
	int id = 1;
	while (rset.next()) {
		if (rset.getInt(1) == id)	id++;			//id체크 후 빈자리에 적절히
		else	break;
	}
	stmt.execute("insert into hubo (id, name) values("+id+", '"+name2+"')");		//넣는다

	stmt.close();
	conn.close();
%>
<center>
<a href=A_01.jsp><img src='./image/a1.png'/></a>
<a href=B_01.jsp><img src='./image/b0.png'/></a>
<a href=C_01.jsp><img src='./image/c0.png'/></a><br><br><br>
<h1>후보등록 결과 : 후보가 추가 되었습니다.<h1>
</center>
</body>
</html>