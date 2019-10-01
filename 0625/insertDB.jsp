<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String name = request.getParameter("name");
	String kor = request.getParameter("kor");
	String eng = request.getParameter("eng");
	String mat = request.getParameter("mat");	//get방식으로 숫자 수신

    String name2=new String(name.getBytes("8859_1"),"utf-8");
%>

<html>
<head>
</head>
<body>

<%
	try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select studentid from examtable");
	int studentid = 209901;
	while (rset.next()) {
		if (rset.getInt(1) == studentid)	studentid++;
		else	break;
	}			//학번 체크 후 빈 학번에 studentid 세팅

	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('"
					+ name2 +"', "+ studentid +", "+ kor +", "+ eng +", "+ mat + ")");	//입력
					
	out.println("<h1>성적입력추가완료</h1>");

	stmt.close();
	conn.close();
%>
<form action="inputForm1.html">
<table border="1">
<%
out.println("<tr><td>이름</td><td><input type=text value='"+ name2 +"' readonly></td></tr>");
out.println("<tr><td>학번</td><td><input type=text value='"+ studentid +"' readonly></td></tr>");
out.println("<tr><td>국어</td><td><input type=text value='"+ kor +"' readonly></td></tr>");
out.println("<tr><td>영어</td><td><input type=text value='"+ eng +"' readonly></td></tr>");
out.println("<tr><td>수학</td><td><input type=text value='"+ mat +"' readonly></td></tr>");
%>
</table>		<!--표로 출력-->
<br><br>
<input type="submit" value="뒤로가기">
</Table>

<%
	} catch (Exception e) {
		//out.println(e.toString());
		if(e.toString().contains("table")) {
			out.println("<h1>테이블이 없습니다.</h1>");
		} else { 
			out.println("<script>alert('똑바로 입력해 주세요');</script>");
			out.println("<script>history.back();</script>");
		}
	}
%>
</body>
</html>
