<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<style>
.ellipsis {
  text-overflow: ellipsis;
	width:350px;
  white-space: nowrap;
  overflow: hidden;
}							/* 350px 넘어서면 ...으로 표시 */
</style>
<head>
</head>
<body>
<center>
<h1>게시판</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select id, title, date from gongji");	//db연결, 쿼리
%>
<table cellspacing=1 width=650 border=1>
<tr>
<td width=50><p align=center>번호</p></td>
<td width=500><p align=center>제목</p></td>
<td width=100><p align=center>등록일</p></td>
</tr>
<%
	rset.last();
	rset.next();	
	while (rset.previous()) {			//역순
		out.println("<tr>");
		out.println("<td width=50><p align=center>"+rset.getInt(1)+"</p></td>");
		out.println("<td width=500><p class='ellipsis'><a href='gongji_view.jsp?key="+rset.getInt(1)+"'>"
												+rset.getString(2)+"</p></td>");
		out.println("<td width=100><p align=center>"+rset.getDate(3)+"</p></td>");
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
<table width=650>
<tr>
<td width=550></td>
<td><input type=button value="신규" OnClick="window.location='gongji_insert.jsp'"></td>
</tr>
</table>
</center>
</body>
</html>