<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String studentid = request.getParameter("studentid");
%>

<html>
<head>
</head>
<body>
<h1>레코드 삭제</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	
	stmt.execute("delete from examtable where studentid ="+ studentid);
	ResultSet rset = stmt.executeQuery("SELECT examtable.name, examtable.studentid, examtable.kor, examtable.eng, examtable.mat, "
							+ "examtable.kor+eng+mat, @prev := @curr, @curr := kor+eng+mat, @rank := IF(@prev = @curr, @rank, @rank + @i) AS rank, "
							+ "IF(@prev <> kor+eng+mat, @i:=1, @i:=@i+1) AS counter FROM examtable, "
							+ "(SELECT @curr := null, @prev := null, @rank := 1, @i := 0) tmp_tbl "
							+ "ORDER BY examtable.kor+eng+mat DESC");				//랭킹 쿼리
%>
<Table cellspacing=1 width=600 border=1>
<tr><td width=50><p align=center>이름</font></a></p></td>
<td width=50><p align=center>학번</font></a></p></td>
<td width=50><p align=center>국어</font></a></p></td>
<td width=50><p align=center>영어</font></a></p></td>
<td width=50><p align=center>수학</font></a></p></td>
<td width=50><p align=center>총점</font></a></p></td>
<td width=50><p align=center>평균</font></a></p></td>
<td width=50><p align=center>등수</font></a></p></td></tr>
<%
	while (rset.next()) {
		out.println("<tr>");
		out.println("<td width=50><p align=center>"+"<a href=oneview.jsp?studentId="+Integer.toString(rset.getInt(2))+"&studentName="+rset.getString(1)
													+" target=main>"+rset.getString(1)+"</font></a>"+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
		double ave = rset.getInt(6) / 3.0;
		out.println("<td width=50><p align=center>"+rset.getInt(6)+"</p></td>");
		out.println("<td width=50><p align=center>"+String.format("%.2f",ave)+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(9))+"</p></td>");
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();

%>
</Table>
</body>
</html>