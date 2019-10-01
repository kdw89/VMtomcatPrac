<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%
	String key = request.getParameter("key");
	int key2 = Integer.parseInt(key);
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
</head>
<body>
<center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "select id, title, date, viewcnt, content, rootid, relevel, recnt, filepath1, filepath2, filepath3 from gongji where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,key2);
	ResultSet rset = pstmt.executeQuery();
%>
<FORM METHOD=POST name='fm'>
<table width=650 class="table table-sm">
<%
	rset.next();
	out.println("<tr><td width='15%'><b>번호</b></td>");
	out.println("<td>"+rset.getInt(1)+"</td></tr>");
	out.println("<tr><td><b>제목</b></td>");
	out.println("<td><input type=text size=70 maxlength=70 value=\""+rset.getString(2)+"\" readonly></td></tr>");
	out.println("<tr><td><b>일자</b></td>");
	out.println("<td>"+rset.getDate(3)+"</td></tr>");
	out.println("<tr><td><b>조회수</b></td>");
	out.println("<td>"+(rset.getInt(4)+1)+"</td></tr>");
	out.println("<tr><td><b>내용</b></td>");
	out.println("<td style='height:400px; word-break: break-all'>"+rset.getString(5)+"</td></tr>");
	out.println("<tr><td><b>원글</b></td>");
	out.println("<td>"+rset.getInt(6)+"<input type=hidden name=key value="+rset.getInt(6)+"></td></tr>");
	out.println("<tr><td><b>댓글수준</b></td>");
	out.println("<td>"+rset.getInt(7)+"<input type=hidden name=lv value="+rset.getInt(7)+"></td></tr>");
	out.println("<tr><td><b>댓글 내 순서</b></td>");
	out.println("<td>"+rset.getInt(8)+"<input type=hidden name=recnt value="+rset.getInt(8)+"></td></tr>");
	out.println("<tr><td><b>첨부파일</b></td><td>");
	if(rset.getString(9) != null) out.println("<a href='/0706/upload/"+rset.getString(9)+"' download><img src=clip.png>"+rset.getString(9)+"</a><br>");
	if(rset.getString(10) != null) out.println("<a href='/0706/upload/"+rset.getString(10)+"' download><img src=clip.png>"+rset.getString(10)+"</a><br>");
	if(rset.getString(11) != null) out.println("<a href='/0706/upload/"+rset.getString(11)+"' download><img src=clip.png>"+rset.getString(11)+"</a><br>");
	out.println("</td></tr>");
	sql = "update gongji set viewcnt=? where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,rset.getInt(4)+1);
	pstmt.setInt(2,key2);
	pstmt.executeUpdate();
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
<td><input type=button value="삭제" OnClick="submitForm('delete')"></td>
<td><input type=button value="댓글" OnClick="submitForm('reply')"></td>
</tr>
</table>
</FORM>
</center>
<SCRIPT LANGUAGE="javaScript">
function submitForm(mode){
	if(mode == "delete"){
		fm.action = "gongji_delete.jsp?id="+<%=key%>;
		if(confirm("정말 삭제하시겠습니까?") == true) fm.submit();
	} else if(mode == "reply"){
		fm.action = "gongji_reinsert.jsp";
		fm.submit();
	}
}
</SCRIPT>
</body>
</html>