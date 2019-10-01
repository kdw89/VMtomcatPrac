<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String id = request.getParameter("id");
	String root = request.getParameter("key");
	String recnt = request.getParameter("recnt");
%>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "delete from gongji where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,id);
	pstmt.executeUpdate();
	
	sql = "update gongji set recnt=recnt-1 where rootid=? and recnt >=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,root);
	pstmt.setString(2,recnt);
	pstmt.executeUpdate();

	pstmt.close();
	conn.close();
%>
<script>location.href = "gongji_list.jsp"; </script>
</body>
</html>