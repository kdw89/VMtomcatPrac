<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.util.Date" %>
<%@ page errorPage="error.jsp" %>
<html>

<head>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<%
	String pageNum = request.getParameter("pageNum");
	int currentPage = 1;
%>
<style>
.ellipsis {
	text-overflow: ellipsis;
	max-width:400px;
	white-space: nowrap;
	overflow: hidden;				// 제목 길면 ...
}
</style>
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
	ResultSet rset2 = stmt.executeQuery("SELECT count(*) from gongji");
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
	if(currentPage > (total-1)/20+1) {
		out.println("<script>alert('잘못된 접근입니다.'); location.href='gongji_list.jsp';</script>");	
	}
	int pageListStart = ((currentPage-1)/10)*10+1;
	
	PreparedStatement pstmt = null;
	String sql = "select id, title, viewcnt, date, rootid, relevel, recnt, filepath1, filepath2, filepath3 from gongji order by rootid desc, recnt asc limit ?, 20";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,((20*currentPage)-20));
	ResultSet rset = pstmt.executeQuery();
%>
<table class="table table-sm">
<tr>
<td width=10%><p align=center>번호</p></td>
<td width=50%><p align=center>제목</p></td>
<td width=15%><p align=center>첨부</p></td>
<td width=10%><p align=center>조회수</p></td>
<td width=15%><p align=center>등록일</p></td>
</tr>
<%
	while (rset.next()) {
			out.println("<tr>");
			out.println("<td><p align=center>"+rset.getInt(1)+"</p></td>");			
			out.println("<td><span style='display: inline-flex;'><div class='ellipsis'>");
			for(int i=0; i<rset.getInt(6); i++) out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			if(rset.getInt(6) > 0) out.println("<img src=reply.png> [re]");												//댓글 아이콘 표시
			if(((today.getTime() - rset.getTimestamp(4).getTime())/3600000) < 12) newPost = "&nbsp;&nbsp;<img style='display: inline-block;' src=new.png>";
			else newPost = "";
			out.println("<a href='gongji_view.jsp?key="+rset.getInt(1)+"'>"+rset.getString(2)+"</a></div></span>"+newPost+"</td>");		//시간계산해서 new아이콘
			out.println("<td><p align=center>");
			if(rset.getString(8) != null) out.println("<img src=clip.png>");
			if(rset.getString(9) != null) out.println("<img src=clip.png>");
			if(rset.getString(10) != null) out.println("<img src=clip.png>");
			out.println("</p></td>");
			out.println("<td><p align=center>"+rset.getInt(3)+"</p></td>");
			out.println("<td><p align=center>"+rset.getDate(4)+"</p></td>");
			out.println("</tr>");
		}
	rset.close();
	stmt.close();
	conn.close();
%>
</table><br>
<%
if (pageListStart != 1) {			//1페이지가 포함되었을땐 <<, <가 나타나지 않는다
	out.println("<a href=gongji_list.jsp?pageNum="+1+" class='btn' style='font-size:2em'>&lt;&lt;</a>");	//맨 앞으로
	out.println("<a href=gongji_list.jsp?pageNum="+(pageListStart-1)+" class='btn' style='font-size:2em'>&lt;</a>");		//10페이지 전으로
}
for(int i=pageListStart; i<pageListStart+10; i++){		//10개 페이지 링크 출력, 페이지번호와 시작 번호를 매칭...수열
	if((20*pageListStart+(i-pageListStart-1)*20) >= total) break;		//총량을 벗어날 경우 페이지 링크를 더 표시하지 않는다
	if(i == currentPage)	out.println("<a href=gongji_list.jsp?pageNum="+(i)+" class='btn btn-success' style='font-size:2em'><b>"+(i)+"</b></a>");
	else	out.println("<a href=gongji_list.jsp?pageNum="+(i)+" class='btn btn-info' style='font-size:2em'>"+(i)+"</a>");

}
if (20*pageListStart < total-180) {		//마지막 페이지에서는 >, >>가 안나타나도록
	out.println("<a href=gongji_list.jsp?pageNum="+(pageListStart+10)+" class='btn' style='font-size:2em'>&gt;</a>");		//10페이지 뒤로
	if(total%20 == 0) out.println("<a href=gongji_list.jsp?pageNum="+(total/20)+" class='btn' style='font-size:2em'>&gt;&gt;</a><br>");
	else out.println("<a href=gongji_list.jsp?pageNum="+(total/20+1)+" class='btn' style='font-size:2em'>&gt;&gt;</a><br>");	//마지막 페이지로
}

%><br>
<table width=650>
<tr>
<td width=550></td>
<td><input type=button value="신규" class="btn btn-warning btn-lg" OnClick="window.location='gongji_insert.jsp'"></td>
</tr>
</table>
</center>
</body>
</html>