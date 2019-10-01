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
	stmt.execute("drop table examtable");		//테이블 제거문
	out.println("<h1>테이블 삭제 완료.</h1>");
	stmt.close();
	conn.close();
	} catch (Exception e) {
		out.println("<h1>이미 테이블이 없습니다.</h1>");
	}
%>
</Table>
</body>
</html>