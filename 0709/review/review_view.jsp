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
<style>
#fixed{
	position:fixed;
	bottom:0%;
	right:0%;			/*브라우저 우하단에 고정*/
	width:fixed;
	padding:5px;
	color:white;
}
td {
	padding:5px
}
.outline{
	background-color: #ffffff;
	width: 1000px;
	padding:20px;
	border-radius:20px;
	border: 5px solid gold;	
}
</style>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
</head>
<body background='/0709/background.jpg'>

<center>
<br><div class='outline' >
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "select id, title, date, viewcnt, content, rootid, relevel, recnt, filepath1, filepath2, filepath3 from resort_review where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,key2);
	ResultSet rset = pstmt.executeQuery();
%>
<FORM METHOD=POST name='fm'>
<table class="table table-sm">
<%
	rset.next();
	out.println("<tr><td width='15%'><b>번호</b></td>");
	out.println("<td>"+rset.getInt(1)+"</td></tr>");
	out.println("<tr><td><b>제목</b></td>");
	out.println("<td>"+rset.getString(2)+"</td></tr>");
	out.println("<tr><td><b>일자</b></td>");
	out.println("<td>"+rset.getDate(3)+"</td></tr>");
	out.println("<tr><td><b>조회수</b></td>");
	out.println("<td>"+(rset.getInt(4)+1)+"</td></tr>");
	out.println("<tr><td><b>내용</b></td>");
	out.println("<td style='height:400px; word-break: break-all'>");

	if(rset.getString(9) != null && rset.getString(9).matches(".*(?i).jpg|.*(?i).jpeg|.*(?i).png|.*(?i).gif")) out.println("<div style='text-align:center;'><img style='max-width:700px;' src='/0709/review/upload/"+rset.getString(9)+"' ><br></div>");
	if(rset.getString(10) != null && rset.getString(10).matches(".*(?i).jpg|.*(?i).jpeg|.*(?i).png|.*(?i).gif")) out.println("<div style='text-align:center;'><img style='max-width:700px;' src='/0709/review/upload/"+rset.getString(10)+"' ><br></div>");
	if(rset.getString(11) != null && rset.getString(11).matches(".*(?i).jpg|.*(?i).jpeg|.*(?i).png|.*(?i).gif")) out.println("<div style='text-align:center;'><img style='max-width:700px;' src='/0709/review/upload/"+rset.getString(11)+"' ><br></div>");
	
	out.println("<br>"+rset.getString(5)+"</td></tr>");

	//out.println("<tr><td><b>원글</b></td>");
	out.println("<input type=hidden name=key value="+rset.getInt(6)+">");
	//out.println("<tr><td><b>댓글수준</b></td>");
	out.println("<input type=hidden name=lv value="+rset.getInt(7)+">");
	//out.println("<tr><td><b>댓글 내 순서</b></td>");
	out.println("<input type=hidden name=recnt value="+rset.getInt(8)+">");
	out.println("<tr><td><b>첨부파일</b></td><td>");
	if(rset.getString(9) != null) out.println("<a href='/0709/review/upload/"+rset.getString(9)+"' download><img src=clip.png>"+rset.getString(9)+"</a><br>");
	if(rset.getString(10) != null) out.println("<a href='/0709/review/upload/"+rset.getString(10)+"' download><img src=clip.png>"+rset.getString(10)+"</a><br>");
	if(rset.getString(11) != null) out.println("<a href='/0709/review/upload/"+rset.getString(11)+"' download><img src=clip.png>"+rset.getString(11)+"</a><br>");
	out.println("</td></tr>");
	sql = "update resort_review set viewcnt=? where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,rset.getInt(4)+1);
	pstmt.setInt(2,key2);
	pstmt.executeUpdate();
	rset.close();
	pstmt.close();
	conn.close();
%>
</table>
<table width=850>
<tr>
<td width=750></td>
<td><input type=button class="btn btn-warning btn-lg" value="목록" OnClick="location.href='review_list.jsp'"></td>

<%
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null) {
		
		return;
	}
	if(!loginOK.equals("yes")) {
		
		return;
	} else {
		out.println("<td><input type=button class='btn btn-primary btn-lg' value='수정' OnClick=location.href='review_update.jsp?key="+key+"'></td>" +
		"<td><input type=button class='btn btn-danger btn-lg' value='삭제' OnClick=submitForm('delete')></td>" +
		"<td><input type=button class='btn btn-success btn-lg' value='댓글' OnClick=submitForm('reply')></td>");
	}
%>


</tr>
</table>
</div>
</FORM>
</center>
<SCRIPT LANGUAGE="javaScript">
function submitForm(mode){
	if(mode == "delete"){
		fm.action = "review_delete.jsp?id="+<%=key%>;
		if(confirm("정말 삭제하시겠습니까?") == true) fm.submit();
	} else if(mode == "reply"){
		fm.action = "review_reinsert.jsp";
		fm.submit();
	}
}
</SCRIPT>
</body>
</html>