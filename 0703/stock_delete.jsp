<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String key = request.getParameter("key");
	long key2 = Long.parseLong(key);
	String product = request.getParameter("product");
	if(product.contains("<")||product.contains(">")) {product = product.replace("<", "&lt");product = product.replace(">", "&gt");}
	String product2=new String(product.getBytes("8859_1"),"utf-8");
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
</head>
<body>
<center>
<h1><b>㈜트와이스 재고 현황 -상품삭제</b></h1><br>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;	
	String sql = "";

	sql = "select photo from stock where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setLong(1,key2);
	ResultSet rset2 = pstmt.executeQuery();
	while(rset2.next()){
		String path1 = "/var/lib/tomcat8/webapps/ROOT" + rset2.getString(1);
		File file1 = new File(path1);
		if(file1.exists() == true) file1.delete();
	}
	sql = "delete from stock where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setLong(1,key2);
	pstmt.executeUpdate();
	out.println("<h1>["+product2+"] 상품이 삭제되었습니다.</h1>");
	
	
	rset2.close();
	conn.close();
	
%>
<br><br><br><br><br><input type=button value="목록으로" class="btn btn-primary btn-lg" style="font-size:5em" OnClick="location.href='stock_list.jsp'">
</center>
</body>
</html>