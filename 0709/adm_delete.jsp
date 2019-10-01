<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String resv_date = request.getParameter("resv_date");
	String room = request.getParameter("room");
%>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	
	String sql = "delete from resv where resv_date=? and room=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,resv_date);
	pstmt.setString(2,room);
	pstmt.executeUpdate();

	pstmt.close();
	conn.close();

%>
<script>location.href = "adm_allview.jsp"; </script>
</body>
</html>