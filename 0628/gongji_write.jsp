<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	if(title == null) out.println("<script>location.href = 'gongji_list.jsp'; </script>");
	if(content == null) out.println("<script>location.href = 'gongji_list.jsp'; </script>");
	
	if(title.contains("<")) title = title.replace("<", "&lt");
	if(content.contains("<")) content = content.replace("<", "&lt");
	if(title.contains(">")) title = title.replace(">", "&gt");
	if(content.contains(">")) content = content.replace(">", "&gt");					//태그 적용 막자
	
	String [] injectionCodes = { "'", "--", "--, #", "/* */", "'or 1=1--", "-1 or", "-1' or", "../", "win.ini", "\""};
	for (int i = 0; i < injectionCodes.length; i++) {
		if(title.contains(injectionCodes[i])){
		title.replaceAll(injectionCodes[i], "");
	}}
	for (int i = 0; i < injectionCodes.length; i++) {
		if(content.contains(injectionCodes[i])){
		content.replaceAll(injectionCodes[i], "");					//인젝션을 막으려는 몸부림
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
	
	if(id.equals("INSERT")){			//입력
		String sql = "insert into gongji (title, content, date) values(?, ?, curdate())";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,title2);
		pstmt.setString(2,content2);
		pstmt.executeUpdate();
	} else {							//수정
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
<script>location.href = "gongji_list.jsp"; </script>  		<!--리스트로 바로이동-->
</body>
</html>