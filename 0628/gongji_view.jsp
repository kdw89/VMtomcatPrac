<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String key = request.getParameter("key");
	int key2 = Integer.parseInt(key);				//값을 받아변환
%>
<html>
<head>
</head>
<body>
<center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "select id, title, date, content from gongji where id=?";		//쿼리
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,key2);
	ResultSet rset = pstmt.executeQuery();
%>
<FORM METHOD=POST name='fm'>
<table width=650 border=1 cellspacing=0 cellpadding=5>
<%
	rset.next();
	out.println("<tr><td><b>번호</b></td>");
	out.println("<td>"+rset.getInt(1)+"</td></tr>");
	out.println("<tr><td><b>제목</b></td>");
	out.println("<td><input type=text size=70 maxlength=70 value=\""+rset.getString(2)+"\" readonly></td></tr>");
	out.println("<tr><td><b>일자</b></td>");
	out.println("<td>"+rset.getDate(3)+"</td></tr>");
	out.println("<tr><td><b>내용</b></td>");
	out.println("<td><textarea style='width:500px; height:250px;' name=content cols=70 row=600 readonly>"
												+rset.getString(4)+"</textarea></td></tr>");
	rset.close();
	pstmt.close();
	conn.close();
%>
</table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=button value="목록" OnClick="location.href='gongji_list.jsp'"></td>
<%
out.println("<td><input type=button value='수정' OnClick=location.href='gongji_update.jsp?key="+key+"'></td>");
%>
</tr>
</table>
</FORM>
</center>
</body>
</html>