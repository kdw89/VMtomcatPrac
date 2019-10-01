<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%
	String key = request.getParameter("key");
	int key2 = Integer.parseInt(key);
	String loginOK=null;
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<style>

td {
	padding:5px
}
</style>
</head>
<body>

<center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "select id, title, date, viewcnt, content, filepath1, filepath2, filepath3 from resort_gongji where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,key2);
	ResultSet rset = pstmt.executeQuery();
%>
<h3>글보기</h3>
<FORM METHOD=POST name='fm'>
<table class="table table-sm">
<%
	rset.next();
	out.println("<tr><td width='20%'><b>번호</b></td>");
	out.println("<td>"+rset.getInt(1)+"</td></tr>");
	out.println("<tr><td><b>제목</b></td>");
	out.println("<td style='word-break: break-all'>"+rset.getString(2)+"</td></tr>");
	out.println("<tr><td><b>일자</b></td>");
	out.println("<td>"+rset.getDate(3)+"</td></tr>");
	out.println("<tr><td><b>조회수</b></td>");
	out.println("<td>"+(rset.getInt(4)+1)+"</td></tr>");
	out.println("<tr><td><b>내용</b></td>");
	out.println("<td style='height:100%; word-break: break-all'>");
	
	
	if(rset.getString(6) != null && rset.getString(6).matches(".*(?i).jpg|.*(?i).jpeg|.*(?i).png|.*(?i).gif")) out.println("<div style='text-align:center;'><img style='width:80%;' src='upload/"+rset.getString(6)+"' ><br></div>");
	if(rset.getString(7) != null && rset.getString(7).matches(".*(?i).jpg|.*(?i).jpeg|.*(?i).png|.*(?i).gif")) out.println("<div style='text-align:center;'><img style='width:80%;' src='upload/"+rset.getString(7)+"' ><br></div>");
	if(rset.getString(8) != null && rset.getString(8).matches(".*(?i).jpg|.*(?i).jpeg|.*(?i).png|.*(?i).gif")) out.println("<div style='text-align:center;'><img style='width:80%;' src='upload/"+rset.getString(8)+"' ><br></div>");
	
	out.println("<br>"+rset.getString(5)+"</td></tr>");

	
	out.println("<tr><td><b>첨부파일</b></td><td>");
	if(rset.getString(6) != null) out.println("<a href='upload/"+rset.getString(6)+"' download><img src=clip.png>"+rset.getString(6)+"</a><br>");
	if(rset.getString(7) != null) out.println("<a href='upload/"+rset.getString(7)+"' download><img src=clip.png>"+rset.getString(7)+"</a><br>");
	if(rset.getString(8) != null) out.println("<a href='upload/"+rset.getString(8)+"' download><img src=clip.png>"+rset.getString(8)+"</a><br>");
	out.println("</td></tr>");
	sql = "update resort_gongji set viewcnt=? where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,rset.getInt(4)+1);
	pstmt.setInt(2,key2);
	pstmt.executeUpdate();
	rset.close();
	pstmt.close();
	conn.close();
%>
</table>
<table width=100%>
<tr>
<td width=80%></td>
<td><input type=button class="btn btn-primary btn-lg" value="목록" OnClick="location.href='gongji_list_m.jsp'"></td>

<%
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null) {
		
		return;
	}
	if(!loginOK.equals("yes")) {
		
		return;
	} else {
		out.println("<td><input type=button class='btn btn-warning btn-lg' value='수정' OnClick=location.href='gongji_update.jsp?key="+key+"'></td>" +
						"<td><input type=button class='btn btn-danger btn-lg' value='삭제' OnClick=submitForm('delete')></td>");
	}
%>
</tr>
</table>
</FORM>
</center>
<SCRIPT LANGUAGE="javaScript">
function submitForm(mode){
	if(mode == "delete"){
		fm.action = "gongji_delete.jsp?id="+<%=key%>;
		if(confirm("정말 삭제하시겠습니까?") == true) fm.submit();
	}
}
</SCRIPT>
</body>
</html>