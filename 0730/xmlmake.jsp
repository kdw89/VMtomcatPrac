<?xml version="1.0" encoding="UTF-8"?>
<%@ page contentType="text/xml; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	PreparedStatement pstmt = null;
	
	String sql = "select * from examtable";
	pstmt = conn.prepareStatement(sql);
	
	ResultSet rset = pstmt.executeQuery();
	
	out.println("<datas>");
	while(rset.next()) {
		out.println("<data>");
		
		out.println("<name>"+rset.getString(1)+"</name>");
		out.println("<studentid>"+rset.getString(2)+"</studentid>");
		out.println("<kor>"+rset.getString(3)+"</kor>");
		out.println("<eng>"+rset.getString(4)+"</eng>");
		out.println("<mat>"+rset.getString(5)+"</mat>");
		
		out.println("</data>");
	}
	
	out.println("</datas>");
	
	pstmt.close();
	conn.close();
%>