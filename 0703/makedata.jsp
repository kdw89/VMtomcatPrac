<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.util.*, java.text.*, java.util.Date" %>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	Random random = new Random();
	for(int i=90001; i<90800; i++) {
		stmt.execute("insert into stock (id, product, inven, take_inven, product_regist, detail, photo) values("
				+i+", '바나나"+i+"',"+(1+random.nextInt(20))+", now(), '2019-01-01', 'ㅁㄴㅇㄹ', '/0703/img/banana.jpg')");
	}
	stmt.close();
	conn.close();
%>
</body>
</html>