<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String id = request.getParameter("id");
%>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	
	String sql = "select filepath1, filepath2, filepath3 from resort_gongji where id= ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,id);
	ResultSet rset = pstmt.executeQuery();
	while(rset.next()){
		String path1 = "/var/lib/tomcat8/webapps/ROOT/0709/gongji/upload/" + rset.getString(1);
		String path2 = "/var/lib/tomcat8/webapps/ROOT/0709/gongji/upload/" + rset.getString(2);
		String path3 = "/var/lib/tomcat8/webapps/ROOT/0709/gongji/upload/" + rset.getString(3);
		File file1 = new File(path1);
		if(file1.exists() == true) file1.delete();
		File file2 = new File(path2);
		if(file2.exists() == true) file2.delete();
		File file3 = new File(path3);
		if(file3.exists() == true) file3.delete();
	}
	
	sql = "delete from resort_gongji where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,id);
	pstmt.executeUpdate();
	
	rset.close();
	pstmt.close();
	conn.close();
	

%>
<script>location.href = "gongji_list.jsp"; </script>
</body>
</html>