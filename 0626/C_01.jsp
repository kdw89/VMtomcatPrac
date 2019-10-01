<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<title>투ㅡ표</title>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();

	ResultSet rset2 = stmt.executeQuery("select count(*) from tupyo");			//총 투표 인원 세기
	rset2.next();
	int allVote = rset2.getInt(1);
	ResultSet rset3 = stmt.executeQuery("SELECT MAX(counted) FROM(SELECT COUNT(*) AS counted FROM tupyo GROUP BY id) AS wqq");
	rset3.next();																//최다득표자
	int maxVote = rset3.getInt(1);
	ResultSet rset = stmt.executeQuery("SELECT a.id, a.NAME, COUNT(*)"
			+" FROM hubo a, tupyo b WHERE a.id = b.id GROUP BY a.id");			//각 후보당 득표수
%>
<center>
<a href=A_01.jsp><img src='./image/a0.png'/></a>
<a href=B_01.jsp><img src='./image/b0.png'/></a>
<a href=C_01.jsp><img src='./image/c1.png'/></a>
<h1>후보 별 득표율<h1>
<table border="1">
<%
	while (rset.next()) {
		double perVote = rset.getInt(3) / (double)allVote * 100;				//득표율
		String formatPer = String.format("%.1f",perVote);						//소수점1자리
		out.println("<tr height=50>");
		out.println("<td width=80><p align=center>"+"<a href=C_02.jsp?id="+Integer.toString(rset.getInt(1))
						+">"+Integer.toString(rset.getInt(1))+" "+rset.getString(2)
						+"</a>"+"</p></td>");									//후보명(이동)
		out.println("<td width=500><p align=left><img src='./image/bar.png' width="
							+(int)((double)rset.getInt(3)/maxVote*80)+"% height=20/> "			// 최다득표자로부터
							+Integer.toString(rset.getInt(3))+"("+formatPer+"%)</p></td>");		// 자기득표비율만큼 그래프
		out.println("</tr></form>");
	}
	rset.close();
	rset2.close();
	rset3.close();
	stmt.close();
	conn.close();

%>
</table>
</center>
</body>
</html>