<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String id = request.getParameter("id");
	String root = request.getParameter("key");
	String relevel = request.getParameter("lv");
	String recnt = request.getParameter("recnt");
	int recnt2 = Integer.parseInt(recnt);
	int relevel2 = Integer.parseInt(relevel);
%>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	out.println(id +" "+ root +" "+ recnt + "<br>");
	String sql = "";
	sql = "select relevel, recnt from gongji where rootid=? and recnt > ? order by recnt asc";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,root);
	pstmt.setString(2,recnt);
	ResultSet rset = pstmt.executeQuery();				//지울 게시물에 달린 댓글까지 날려버릴 것이다. 그러기 위한 조사 쿼리
	int temp = 0;
	while(rset.next()){
		out.println(" relevel : " + rset.getInt(1) +" recnt : "+ rset.getInt(2)+ "<br>");
		if(relevel2 >= rset.getInt(1)) break;
		temp++;
	}
	out.println("개수 : " +temp);						//게시글 아래에 달린 댓글의 숫자
	

	sql = "select filepath1, filepath2, filepath3 from gongji where rootid=? AND recnt BETWEEN ? AND ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,root);
	pstmt.setInt(2,recnt2);
	pstmt.setInt(3,recnt2+temp);
	ResultSet rset2 = pstmt.executeQuery();
	while(rset2.next()){
		String path1 = "/var/lib/tomcat8/webapps/ROOT/0706/upload/" + rset2.getString(1);
		String path2 = "/var/lib/tomcat8/webapps/ROOT/0706/upload/" + rset2.getString(2);
		String path3 = "/var/lib/tomcat8/webapps/ROOT/0706/upload/" + rset2.getString(3);
		File file1 = new File(path1);
		if(file1.exists() == true) file1.delete();
		File file2 = new File(path2);
		if(file2.exists() == true) file2.delete();					//댓글들을 포함한 게시글의 첨부파일들도 날려버린다.
		File file3 = new File(path3);
		if(file3.exists() == true) file3.delete();
	}
	
	sql = "delete from gongji where rootid=? and recnt between ? and ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,root);
	pstmt.setString(2,recnt);
	pstmt.setInt(3,recnt2+temp);					//db에서 정보를 날려버린다.
	pstmt.executeUpdate();
	
	sql = "update gongji set recnt=recnt-? where rootid=? and recnt >=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,temp+1);
	pstmt.setString(2,root);
	pstmt.setString(3,recnt);						//잔여 댓글들의 recnt 번호를 땡겨온다
	pstmt.executeUpdate();

	rset2.close();
	rset.close();
	pstmt.close();
	conn.close();
	

%>
<script>location.href = "gongji_list.jsp"; </script>
</body>
</html>