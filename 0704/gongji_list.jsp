<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.util.Date" %>
<%@ page errorPage="error.jsp" %>
<html>
<style>
.ellipsis {
  text-overflow: ellipsis;
	width:350px;
  white-space: nowrap;
  overflow: hidden;
}
</style>
<head>
</head>
<body>
<center>
<h1>게시판</h1>
<%
	Date today = new Date();
	String newPost = "";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select id, title, viewcnt, date, rootid, relevel, recnt from gongji order by rootid desc, recnt asc");
%>
<table cellspacing=1 width=750 border=1>
<tr>
<td width=50><p align=center>번호</p></td>
<td width=500><p align=center>제목</p></td>
<td width=100><p align=center>조회수</p></td>
<td width=100><p align=center>등록일</p></td>
</tr>
<%
	while (rset.next()) {
			out.println("<tr>");
			out.println("<td width=50><p align=center>"+rset.getInt(1)+"</p></td>");
			out.println("<td width=500><p class='ellipsis'><a href='gongji_view.jsp?key="+rset.getInt(1)+"'>");
			for(int i=0; i<rset.getInt(6); i++) out.println("└&gt;");
			if(rset.getInt(6) > 0) out.println("[re]");
			if(((today.getTime() - rset.getTimestamp(4).getTime())/3600000) < 12) newPost = "<img src=new.gif>";
			else newPost = "";
			out.println(rset.getString(2)+" "+newPost+"</p></td>");
			out.println("<td width=100><p align=center>"+rset.getInt(3)+"</p></td>");
			out.println("<td width=100><p align=center>"+rset.getDate(4)+"</p></td>");
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