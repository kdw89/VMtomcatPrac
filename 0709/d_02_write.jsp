<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String name = request.getParameter("name");
	name=new String(name.getBytes("8859_1"),"utf-8");
	
	String resv_date = request.getParameter("resv_date");
	resv_date=new String(resv_date.getBytes("8859_1"),"utf-8");
	
	String room = request.getParameter("room");
	room=new String(room.getBytes("8859_1"),"utf-8");
	
	String addr = request.getParameter("addr");
	addr=new String(addr.getBytes("8859_1"),"utf-8");
	
	if(addr.contains("<")) addr = addr.replace("<", "&lt");
	if(addr.contains(">")) addr = addr.replace(">", "&gt");
	
	
	String telnum = request.getParameter("telnum");
	telnum=new String(telnum.getBytes("8859_1"),"utf-8");
	
	
	String id_name = request.getParameter("id_name");
	id_name=new String(id_name.getBytes("8859_1"),"utf-8");
	
	if(id_name.contains("<")) id_name = id_name.replace("<", "&lt");
	if(id_name.contains(">")) id_name = id_name.replace(">", "&gt");
	
	String comment = request.getParameter("comment");
	comment=new String(comment.getBytes("8859_1"),"utf-8");
	
	if(comment.contains("<")) comment = comment.replace("<", "&lt");
	if(comment.contains(">")) comment = comment.replace(">", "&gt");
	
%>
<html>
<head>
</head>
<body>
<%
	try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	
	String sql = "insert into resv (name, resv_date, room, addr, telnum, id_name, comment, write_date, processing) values(?, ?, ?, ?, ?, ?, ?, now(), 1)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,name);
	pstmt.setString(2,resv_date);
	pstmt.setString(3,room);
	pstmt.setString(4,addr);
	pstmt.setString(5,telnum);
	pstmt.setString(6,id_name);
	pstmt.setString(7,comment);
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	} catch (Exception e) {
		out.println("<script>alert('이미 예약된 날짜/방입니다.')");
		out.println("location.href='d_01.jsp';</script>");
	}
%>
<script>location.href = "d_01.jsp"; </script>
</body>
</html>