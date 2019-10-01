<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String name = request.getParameter("name");
	String studentid = request.getParameter("studentid");
	String kor = request.getParameter("kor");
	String eng = request.getParameter("eng");
	String mat = request.getParameter("mat");	//get방식으로 숫자 수신

    String name2=new String(name.getBytes("8859_1"),"utf-8");
%>

<html>
<head>
</head>
<body>
<h1>레코드 수정</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	
	stmt.execute("update examtable set name='"
					+ name2 +"', kor="+ kor +", eng="+ eng +", mat="+ mat + " where studentid ="+ studentid);
	ResultSet rset = stmt.executeQuery("SELECT examtable.name, examtable.studentid, examtable.kor, examtable.eng, examtable.mat, "
							+ "examtable.kor+eng+mat, @prev := @curr, @curr := kor+eng+mat, @rank := IF(@prev = @curr, @rank, @rank + @i) AS rank, "
							+ "IF(@prev <> kor+eng+mat, @i:=1, @i:=@i+1) AS counter FROM examtable, "
							+ "(SELECT @curr := null, @prev := null, @rank := 1, @i := 0) tmp_tbl "
							+ "ORDER BY examtable.kor+eng+mat DESC");					//랭킹 보는 쿼리
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
		if(rset.getInt(2) == Integer.parseInt(studentid)){
			out.println("<tr bgcolor=#ffff00>");				//학번 같을 때 행을 노란색으로
		} else	{
			out.println("<tr>");								//아닐땐 그냥 출력
		}
		out.println("<td width=50><p align=center>"+"<a href=oneview.jsp?studentId="+Integer.toString(rset.getInt(2))+"&studentName="+rset.getString(1)
													+" target=main>"+rset.getString(1)+"</font></a>"+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(2))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(3))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(4))+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(5))+"</p></td>");
		double ave = rset.getInt(6) / 3.0;
		out.println("<td width=50><p align=center>"+rset.getInt(6)+"</p></td>");
		out.println("<td width=50><p align=center>"+String.format("%.2f",ave)+"</p></td>");
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(9))+"</p></td>");		//성적표 출력
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();

%>
</Table>
</body>
</html>