<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String id = request.getParameter("id");
%>
<html>
<head>
<title>투ㅡ표</title>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	
	ResultSet rset4 = stmt.executeQuery("select id, name from hubo where id = " + id +"");
	rset4.next();
	String name = rset4.getString(2);

	ResultSet rset2 = stmt.executeQuery("select count(*) from tupyo where id = " + id +"");		//한 후보의 총 득표수
	rset2.next();
	int allVote = rset2.getInt(1);
	ResultSet rset3 = stmt.executeQuery("SELECT MAX(counted) FROM(SELECT COUNT(*) AS counted FROM tupyo WHERE id="+id+" GROUP BY age) AS wqq");
	rset3.next();																				//연령대의 최다득표
	int maxVote = rset3.getInt(1);
	ResultSet rset = stmt.executeQuery("SELECT age, COUNT(*) FROM tupyo WHERE id ="+id+" GROUP BY age;");		//후보의 연령별 득표
%>
<center>
<a href=A_01.jsp><img src='./image/a0.png'/></a>
<a href=B_01.jsp><img src='./image/b0.png'/></a>
<a href=C_01.jsp><img src='./image/c1.png'/></a>

<table border="1">
<%
	out.println("<h1>"+id+". "+name+" 후보 득표성향 분석<h1>");
	out.println("<table border=1>");
	while (rset.next()) {
		double perVote = rset.getInt(2) / (double)allVote * 100;
		String formatPer = String.format("%.1f",perVote);
		out.println("<tr height=50>");
		out.println("<td width=80><p align=center>"+Integer.toString(rset.getInt(1))+"대"		//연령대 표시
						+"</p></td>");
		out.println("<td width=500><p align=left><img src='./image/bar.png' width="
							+(int)((double)rset.getInt(2)/maxVote*80)+"% height=20/> "
							+Integer.toString(rset.getInt(2))+"("+formatPer+"%)</p></td>");			//최다득표 연령대비 현 연령 그래프
		out.println("</tr></form>");
	}
	rset.close();
	rset2.close();
	rset3.close();
	rset4.close();
	stmt.close();
	conn.close();

%>
</table>
</center>
</body>
</html>