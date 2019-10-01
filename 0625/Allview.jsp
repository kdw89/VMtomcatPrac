<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<%
	String pageNum = request.getParameter("pageNum");
	int currentPage = 1;
%>
</head>
<body>
<%
	try {

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	ResultSet rset2 = stmt.executeQuery("select count(*) from examtable");
	rset2.next();
	int total = rset2.getInt(1);
	
	if(pageNum != null)	{
		try{
			currentPage = Integer.parseInt(pageNum);
		} catch(Exception e) {
			out.println("<script>alert('잘못된 접근입니다.'); location.href='gongji_list.jsp';</script>");
		}
	}
	if(currentPage < 1) currentPage = 1;
	if(currentPage > (total-1)/10+1) {
		out.println("<script>alert('잘못된 접근입니다.'); location.href='gongji_list.jsp';</script>");	
	}
	
		out.println("<h1>조회</h1>");
	int pageListStart = ((currentPage-1)/5)*5+1;
	
	PreparedStatement pstmt = null;
	String sql = "select * from (SELECT examtable.name, examtable.studentid as stid, examtable.kor, examtable.eng, examtable.mat, "
							+ "examtable.kor+eng+mat, @prev := @curr, @curr := kor+eng+mat, @rank := IF(@prev = @curr, @rank, @rank + @i) AS rank, "
							+ "IF(@prev <> kor+eng+mat, @i:=1, @i:=@i+1) AS counter FROM examtable, "
							+ "(SELECT @curr := null, @prev := null, @rank := 1, @i := 0) tmp_tbl "
							+ "ORDER BY examtable.kor+eng+mat DESC) as temp order by stid limit ?,10";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,((10*currentPage)-10));
	ResultSet rset = pstmt.executeQuery();
	
	
	//ResultSet rset = stmt.executeQuery("select * from (SELECT examtable.name, examtable.studentid, examtable.kor, examtable.eng, examtable.mat, "
	//						+ "examtable.kor+eng+mat, @prev := @curr, @curr := kor+eng+mat, @rank := IF(@prev = @curr, @rank, @rank + @i) AS rank, "
	//						+ "IF(@prev <> kor+eng+mat, @i:=1, @i:=@i+1) AS counter FROM examtable, "
	//						+ "(SELECT @curr := null, @prev := null, @rank := 1, @i := 0) tmp_tbl "
	//						+ "ORDER BY examtable.kor+eng+mat DESC) as temp limit ?,10");				//랭킹 산출을 위한 쿼리
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
		double ave = rset.getInt(6) / 3.0;				//평균계산
		out.println("<td width=50><p align=center>"+rset.getInt(6)+"</p></td>");
		out.println("<td width=50><p align=center>"+String.format("%.2f",ave)+"</p></td>");		//소수점2자리
		out.println("<td width=50><p align=center>"+Integer.toString(rset.getInt(9))+"</p></td>");
		out.println("</tr>");
	}
	rset.close();
	stmt.close();
	conn.close();
	
	

%>
</Table>
<br>
<Table cellspacing=1 width=600>
<tr><td align=center>
<%
if (pageListStart != 1) {			//1페이지가 포함되었을땐 <<, <가 나타나지 않는다
	out.println("<a href=Allview.jsp?pageNum="+1+" class='btn' >&lt;&lt;</a>");	//맨 앞으로
	out.println("<a href=Allview.jsp?pageNum="+(pageListStart-1)+" class='btn' >&lt;</a>");		//10페이지 전으로
}
for(int i=pageListStart; i<pageListStart+5; i++){		//5개 페이지 링크 출력, 페이지번호와 시작 번호를 매칭...수열
	if((10*pageListStart+(i-pageListStart-1)*10) >= total) break;		//총량을 벗어날 경우 페이지 링크를 더 표시하지 않는다
	if(i == currentPage)	out.println("<a href=Allview.jsp?pageNum="+(i)+" class='btn btn-success' ><b>"+(i)+"</b></a>");
	else	out.println("<a href=Allview.jsp?pageNum="+(i)+" class='btn btn-info' >"+(i)+"</a>");

}
if (10*pageListStart < total-90) {		//마지막 페이지에서는 >, >>가 안나타나도록
	out.println("<a href=Allview.jsp?pageNum="+(pageListStart+5)+" class='btn'>&gt;</a>");		//10페이지 뒤로
	if(total%10 == 0) out.println("<a href=Allview.jsp?pageNum="+(total/10)+" class='btn' >&gt;&gt;</a><br>");
	else out.println("<a href=Allview.jsp?pageNum="+(total/10+1)+" class='btn' >&gt;&gt;</a><br>");	//마지막 페이지로
}

	} catch (Exception e) {
				out.println("<h1>테이블이 없는데요</h1>");
	}

%>
</td></tr>
</table>
</body>
</html>