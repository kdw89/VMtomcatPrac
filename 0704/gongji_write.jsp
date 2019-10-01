<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>

<%
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String root = request.getParameter("root");
	String level = request.getParameter("level");
	String recnt = request.getParameter("recnt");
	if(recnt == null) recnt = "0";
	int recnt2 = Integer.parseInt(recnt);
	
	if(title == null) out.println("<script>location.href = 'gongji_list.jsp'; </script>");
	if(content == null) out.println("<script>location.href = 'gongji_list.jsp'; </script>");
	
	if(title.contains("<")) title = title.replace("<", "&lt");
	if(content.contains("<")) content = content.replace("<", "&lt");
	if(title.contains(">")) title = title.replace(">", "&gt");
	if(content.contains(">")) content = content.replace(">", "&gt");
	
	String [] injectionCodes = { "'", "--", "--, #", "/* */", "'or 1=1--", "-1 or", "-1' or", "../", "win.ini", "\""};
	for (int i = 0; i < injectionCodes.length; i++) {
		if(title.contains(injectionCodes[i])){
		title.replaceAll(injectionCodes[i], "");
	}}
	for (int i = 0; i < injectionCodes.length; i++) {
		if(content.contains(injectionCodes[i])){
		content.replaceAll(injectionCodes[i], "");
	}}
	String title2=new String(title.getBytes("8859_1"),"utf-8");
	String content2=new String(content.getBytes("8859_1"),"utf-8");

%>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	
	if(id.equals("INSERT")){
		String sql = "insert into gongji (title, content, date) values(?, ?, now())";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,title2);
		pstmt.setString(2,content2);
		pstmt.executeUpdate();
		if(root == null){
			sql = "update gongji set rootid=LAST_INSERT_ID(), relevel=?, recnt=? where id=LAST_INSERT_ID()";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,level);
			pstmt.setString(2,recnt);
			pstmt.executeUpdate();
		} else {
	/*
			sql = "select relevel, recnt from gongji where rootid=? and recnt >= ? order by recnt asc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,root);
			pstmt.setString(2,recnt);
			ResultSet rset = pstmt.executeQuery();
			int temp=0;
			while(rset.next()){
				if(temp < rset.getInt(1)) {temp = rset.getInt(1);}
				else if(temp > rset.getInt(1)) {
					recnt2 = rset.getInt(2);
					break;
				}
				else if(Integer.parseInt(level)<rset.getInt(1)) break;
				recnt2 = rset.getInt(2)+1;
			}
	*/		
			sql = "update gongji set rootid=?, relevel=?, recnt=? where id=LAST_INSERT_ID()";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,root);
			pstmt.setString(2,level);
			pstmt.setInt(3,recnt2);
			pstmt.executeUpdate();
			
			
			sql = "update gongji set recnt=recnt+1 where rootid=? and recnt >=? and not(id = LAST_INSERT_ID())";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,root);
			pstmt.setInt(2,recnt2);
			pstmt.executeUpdate();
		}
	} else {
		String sql = "update gongji set title=?, content=? where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,title2);
		pstmt.setString(2,content2);
		pstmt.setString(3,id);
		pstmt.executeUpdate();
	}

	pstmt.close();
	conn.close();
%>
<script>location.href = "gongji_list.jsp"; </script>
</body>
</html>