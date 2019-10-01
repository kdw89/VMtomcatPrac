<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String studentName = request.getParameter("studentName");
	String studentId = request.getParameter("studentId"); //get방식으로 숫자 수신
%>
<html>
<head>
</head>
<body>
<a href=Allview.jsp>전체보기</a>
<%
	out.println("<h1>["+ studentName +"]조회</h1>");		//이름 출력
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();				//id로 쿼리
	ResultSet rset = stmt.executeQuery("select * from examtable where studentid =" + studentId);
%>
<Table cellspacing=1 width=600 border=1>
<tr><td width=50><p align=center>이름</font></a></p></td>
<td width=50><p align=center>학번</font></a></p></td>
<td width=50><p align=center>국어</font></a></p></td>
<td width=50><p align=center>영어</font></a></p></td>
<td width=50><p align=center>수학</font></a></p></td></tr>
<%
	while (rset.next()) {
		out.println("<tr>");
		out.println("<td width=50><p align=center>"+rset.getString(1)+"</p></td>");		
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();

%>
</Table>
</body>
</html>