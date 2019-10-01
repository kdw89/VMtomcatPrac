<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page errorPage="error.jsp" %>
<%
	String key = request.getParameter("key");
	String u_id = request.getParameter("id");
	String u_inven = request.getParameter("inven");
	if(u_inven == null) u_inven = "0";
%>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	PreparedStatement pstmt = null;
	if(key == null) key = "";
	
	if(key.equals("UPDATE")){						//재고수정부분
		if(u_id.contains("<")||u_id.contains(">")) {u_id = u_id.replace("<", "&lt");u_id = u_id.replace(">", "&gt");}
		if(u_inven.contains("<")||u_inven.contains(">")) {u_inven = u_inven.replace("<", "&lt");u_inven = u_inven.replace(">", "&gt");}
		String sql = "update stock set inven=?, take_inven=now() where id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,u_inven);
		pstmt.setString(2,u_id);
		pstmt.executeUpdate();
	} else {
	
		String saveDir = application.getRealPath("/0703/img/");
		int maxSize = 1024*1024*100;
		String encType = "UTF-8";

		MultipartRequest multipartRequest
		= new MultipartRequest(request, saveDir, maxSize, encType, new DefaultFileRenamePolicy());		//이때 파일이 업로드
		
		String id = multipartRequest.getParameter("id");
		String product = multipartRequest.getParameter("product");
		String inven = multipartRequest.getParameter("inven");
		String detail = multipartRequest.getParameter("detail");		//멀티파트 요소 불러오기
		
		if(id.contains("<")||id.contains(">")) {id = id.replace("<", "&lt");id = id.replace(">", "&gt");}
		if(product.contains("<")||product.contains(">")) {product = product.replace("<", "&lt");product = product.replace(">", "&gt");}
		if(inven.contains("<")||inven.contains(">")) {inven = inven.replace("<", "&lt");inven = inven.replace(">", "&gt");}
		if(detail.contains("<")||detail.contains(">")) {detail = detail.replace("<", "&lt");detail = detail.replace(">", "&gt");}
		
		String sql = "insert into stock (id, product, inven, take_inven, product_regist, detail, photo) values(?,?,?, now(), now(),?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,id);
		pstmt.setString(2,product);
		pstmt.setString(3,inven);
		pstmt.setString(4,detail);
		String imgPath = "/0703/img/"+multipartRequest.getOriginalFileName("file");			//db에 파일의 경로 입력
		pstmt.setString(5,imgPath);
		pstmt.executeUpdate();
	}
	
	pstmt.close();
	conn.close();
%>
<script>location.href = "stock_list.jsp"; </script>
</body>
</html>