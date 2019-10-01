<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<html>
<head>
</head>
<body>

<%
	try{
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	Random random = new Random();
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'나연', 209901, 95, 100, 95)");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'정연', 209902, 95, 95, 95)");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'모모', 209903, 100, 100, 100)");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'사나', 209904, 100, 95, 90)");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'지효', 209905, 80, 100, 70)");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'미나', 209906, 100, 100, 70)");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'다현', 209907, 70, 70, 70)");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'채영', 209908, 80, 75, 72)");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'쯔위', 209909, 78, 79, 82)");
					
					
	for (int i=10; i < 500; i++){
			stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values("
					+"'듣보"+i+"', "+(209900+i)+", "+(1+random.nextInt(99))+", "+(1+random.nextInt(99))+", "+(1+random.nextInt(99))+")");
	}
	
	out.println("<h1>실습데이터 입력 완료</h1>");
	stmt.close();
	conn.close();
	} catch (Exception e) {
		if(e.toString().contains("Duplicate")) {
		out.println("<h1>이미 존재하는 데이터가 있습니다.</h1>");
		} else out.println("<h1>테이블이 없습니다.</h1>");
	}
%>
</Table>
</body>
</html>