<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.util.*" %>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%
	
	String saveDir = application.getRealPath("/0706/upload/");
	int maxSize = 1024*1024*100;
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
		= new MultipartRequest(request, saveDir, maxSize, encType, new DefaultFileRenamePolicy());	//파일부터 업로드
	
	id = multipartRequest.getParameter("id");
	title = multipartRequest.getParameter("title");
	content = multipartRequest.getParameter("content");
	
	root = multipartRequest.getParameter("root");
	level = multipartRequest.getParameter("level");
	recnt = multipartRequest.getParameter("recnt");					//값들을 받자
	if(recnt == null) recnt = "0";
	recnt2 = Integer.parseInt(recnt);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	
	if(id.equals("INSERT") == false) {			//수정일 때...
		sql = "select filepath1, filepath2, filepath3 from gongji where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		ResultSet rset = pstmt.executeQuery();					//기존 파일과 새 파일을 검사하여, 이름, 경로를 갱신하는 부분
		rset.next();
		if(multipartRequest.getParameter("file1") != null) filename1 = multipartRequest.getParameter("file1");
		else if (multipartRequest.getFilesystemName("file1") == null) {
			String path1 = "/var/lib/tomcat8/webapps/ROOT/0706/upload/" + rset.getString(1);
			File file1 = new File(path1);
			if(file1.exists() == true) file1.delete();
			filename1 = null;
		} else filename1 = multipartRequest.getFilesystemName("file1");
		
		if(multipartRequest.getParameter("file2") != null) filename2 = multipartRequest.getParameter("file2");
		else if (multipartRequest.getFilesystemName("file2") == null) {
			String path2 = "/var/lib/tomcat8/webapps/ROOT/0706/upload/" + rset.getString(2);
			File file2 = new File(path2);
			if(file2.exists() == true) file2.delete();
			filename2 = null;
		} else filename2 = multipartRequest.getFilesystemName("file2");
		
		if(multipartRequest.getParameter("file3") != null) filename3 = multipartRequest.getParameter("file3");
		else if (multipartRequest.getFilesystemName("file3") == null) {
			String path3 = "/var/lib/tomcat8/webapps/ROOT/0706/upload/" + rset.getString(3);
			File file3 = new File(path3);
			if(file3.exists() == true) file3.delete();
			filename3 = null;
		} else filename3 = multipartRequest.getFilesystemName("file3");				//파일 3개
		rset.close();

	} else {
		filename1 = multipartRequest.getFilesystemName("file1");
		filename2 = multipartRequest.getFilesystemName("file2");
		filename3 = multipartRequest.getFilesystemName("file3");
	}
	
	if(title == null) out.println("<script>location.href = 'gongji_list.jsp'; </script>");
	if(content == null) out.println("<script>location.href = 'gongji_list.jsp'; </script>");
	
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
		sql = "insert into gongji (title, content, date, filepath1, filepath2, filepath3) values(?, ?, now(), ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,title);
		pstmt.setString(2,content);
		pstmt.setString(3,filename1);
		pstmt.setString(4,filename2);
		pstmt.setString(5,filename3);				//게시물 입력
		pstmt.executeUpdate();
		if(root == null){
			sql = "update gongji set rootid=LAST_INSERT_ID(), relevel=?, recnt=? where id=LAST_INSERT_ID()";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,level);
			pstmt.setString(2,recnt);			//댓글 없는 새글은 입력된 게시물의 id를 불러와 0을 추가
			pstmt.executeUpdate();
		} else {
			sql = "update gongji set rootid=?, relevel=?, recnt=? where id=LAST_INSERT_ID()";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,root);
			pstmt.setString(2,level);
			pstmt.setInt(3,recnt2);
			pstmt.executeUpdate();				//게시물에 대댓글 검사를 위한 원글번호 등을 추가 
			
			sql = "update gongji set recnt=recnt+1 where rootid=? and recnt >=? and not(id = LAST_INSERT_ID())";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,root);
			pstmt.setInt(2,recnt2);				//밀린 댓글들에 recnt 1씩 추가
			pstmt.executeUpdate();
		}
	} else {
		sql = "update gongji set title=?, content=?, filepath1=?, filepath2=?, filepath3=? where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,title);
		pstmt.setString(2,content);
		pstmt.setString(3,filename1);
		pstmt.setString(4,filename2);			//업데이트(수정)
		pstmt.setString(5,filename3);
		pstmt.setString(6,id);
		pstmt.executeUpdate();
	}

	pstmt.close();
	conn.close();
	

%>
<script>location.href = "gongji_list.jsp"; </script>
</body>
</html>