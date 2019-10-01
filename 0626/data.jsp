<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<html>
<head>
<title>투ㅡ표</title>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	Random random = new Random();
	
	for(int i=0; i< 1000; i++){
		stmt.execute("insert into tupyo (id, age) values("+ (1+random.nextInt(5))+", "+ ((1+random.nextInt(9))*10)+")");
	}
	stmt.close();
	conn.close();
%>
</body>
</html>