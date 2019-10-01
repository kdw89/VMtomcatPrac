<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.text.*, java.util.Date" %>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String created = sdt.format(new Date());

	stmt.execute("insert into gongji (title, content, date) values("
		+"'공지사항1', 'ㅁㄴㅇㄹ','"+created+"')");
	stmt.execute("insert into gongji (title, content, date) values("
		+"'공지사항2', 'ㅁㄴㅇㄹ','"+created+"')");
	stmt.execute("insert into gongji (title, content, date) values("
		+"'공지사항3', 'ㅁㄴㅇㄹ','"+created+"')");
	stmt.execute("insert into gongji (title, content, date) values("
		+"'공지사항4', 'ㅁㄴㅇㄹ','"+created+"')");
	stmt.execute("insert into gongji (title, content, date) values("
		+"'공지사항5', 'ㅁㄴㅇㄹ','"+created+"')");
	stmt.close();
	conn.close();
%>
</body>
</html>