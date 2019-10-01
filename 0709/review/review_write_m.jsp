<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.util.*" %>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page errorPage="error.jsp" %>
<%
	
	String saveDir = application.getRealPath("/0709/review/upload/");
	int maxSize = 1024*1024*16;
	String encType = "UTF-8";
	String id = "";
	String title = "";
	String content = "";
	String root = "";
	String level = "";
	String recnt = "";
	String filename1 = "";
	String filename2 = "";
	String filename3 = "";
	String sql = "";
	int recnt2 = 0;

	MultipartRequest multipartRequest
		= new MultipartRequest(request, saveDir, maxSize, encType, new DefaultFileRenamePolicy());
	
	id = multipartRequest.getParameter("id");
	title = multipartRequest.getParameter("title");
	//title = new String(title.getBytes("8859_1"),"utf-8");
	content = multipartRequest.getParameter("content");
	//content = new String(content.getBytes("8859_1"),"utf-8");
	
	root = multipartRequest.getParameter("root");
	level = multipartRequest.getParameter("level");
	recnt = multipartRequest.getParameter("recnt");
	if(recnt == null) recnt = "0";
	recnt2 = Integer.parseInt(recnt);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	
	if(id.equals("INSERT") == false) {
		sql = "select filepath1, filepath2, filepath3 from resort_review where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		ResultSet rset = pstmt.executeQuery();
		rset.next();
		if(multipartRequest.getParameter("file1") != null) filename1 = multipartRequest.getParameter("file1");
		else if (multipartRequest.getFilesystemName("file1") == null) {
			String path1 = "/var/lib/tomcat8/webapps/ROOT/0709/review/upload/" + rset.getString(1);
			File file1 = new File(path1);
			if(file1.exists() == true) file1.delete();
			filename1 = null;
		} else filename1 = multipartRequest.getFilesystemName("file1");
		
		if(multipartRequest.getParameter("file2") != null) filename2 = multipartRequest.getParameter("file2");
		else if (multipartRequest.getFilesystemName("file2") == null) {
			String path2 = "/var/lib/tomcat8/webapps/ROOT/0709/review/upload/" + rset.getString(2);
			File file2 = new File(path2);
			if(file2.exists() == true) file2.delete();
			filename2 = null;
		} else filename2 = multipartRequest.getFilesystemName("file2");
		
		if(multipartRequest.getParameter("file3") != null) filename3 = multipartRequest.getParameter("file3");
		else if (multipartRequest.getFilesystemName("file3") == null) {
			String path3 = "/var/lib/tomcat8/webapps/ROOT/0709/review/upload/" + rset.getString(3);
			File file3 = new File(path3);
			if(file3.exists() == true) file3.delete();
			filename3 = null;
		} else filename3 = multipartRequest.getFilesystemName("file3");
		rset.close();

	} else {
		filename1 = multipartRequest.getFilesystemName("file1");
		filename2 = multipartRequest.getFilesystemName("file2");
		filename3 = multipartRequest.getFilesystemName("file3");
	}
	
	if(title == null) out.println("<script>location.href = 'review_list.jsp'; </script>");
	if(content == null) out.println("<script>location.href = 'review_list.jsp'; </script>");
	
	if(title.contains("<")) title = title.replace("<", "&lt");
	if(title.contains(">")) title = title.replace(">", "&gt");
	if(content.contains("<!")) content = content.replace("<!", "&lt;&#33;");
	
%>
<html>
<head>
</head>
<body>
<%

	
	if(id.equals("INSERT")){
		sql = "insert into resort_review (title, content, date, filepath1, filepath2, filepath3) values(?, ?, now(), ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,title);
		pstmt.setString(2,content);
		pstmt.setString(3,filename1);
		pstmt.setString(4,filename2);
		pstmt.setString(5,filename3);
		pstmt.executeUpdate();
		if(root == null){
			sql = "update resort_review set rootid=LAST_INSERT_ID(), relevel=?, recnt=? where id=LAST_INSERT_ID()";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,level);
			pstmt.setString(2,recnt);
			pstmt.executeUpdate();
		} else {
			sql = "update resort_review set rootid=?, relevel=?, recnt=? where id=LAST_INSERT_ID()";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,root);
			pstmt.setString(2,level);
			pstmt.setInt(3,recnt2);
			pstmt.executeUpdate();
			
			sql = "update resort_review set recnt=recnt+1 where rootid=? and recnt >=? and not(id = LAST_INSERT_ID())";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,root);
			pstmt.setInt(2,recnt2);
			pstmt.executeUpdate();
		}
	} else {
		sql = "update resort_review set title=?, content=?, filepath1=?, filepath2=?, filepath3=? where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,title);
		pstmt.setString(2,content);
		pstmt.setString(3,filename1);
		pstmt.setString(4,filename2);
		pstmt.setString(5,filename3);
		pstmt.setString(6,id);
		pstmt.executeUpdate();
	}


	pstmt.close();
	conn.close();
	
	

%>
<script>location.href = "review_list_m.jsp"; </script>
</body>
</html>