<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
</head>
<body>

<%	
	try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	stmt.execute("create table examtable(" 
						+ "name varchar(20), " 
						+ "studentid int not null primary key, " 
						+ "kor int, " 
						+ "eng int, " 
						+ "mat int) DEFAULT CHARSET=utf8");		//테이블 생성문
	
	out.println("<h1>테이블 생성 완료</h1>");

	stmt.close();
	conn.close();
	} catch (Exception e) {
			out.println("<h1>이미 테이블이 존재합니다.</h1>");
	}
%>
</Table>
</body>
</html>