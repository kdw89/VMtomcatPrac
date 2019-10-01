<%@ page language="java" contentType="application/json; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>
<%
  response.setHeader("Access-Control-Allow-Origin","*");    //cross-origin 에러를 막을 수 있다?
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	PreparedStatement pstmt = null;

	String sql = "select * from examtable";
	pstmt = conn.prepareStatement(sql);

	ResultSet rset = pstmt.executeQuery();
  int cnt=0;
  out.print("[");             //json 포맷에 맞게 적당히 써준다
	while(rset.next()) {
    if(cnt == 0) out.print("{\"name\": \""+rset.getString(1)+"\", ");
    else out.print(", {\"name\": \""+rset.getString(1)+"\", ");
    out.print("\"studentid\": \""+rset.getString(2)+"\", ");
    out.print("\"kor\": \""+rset.getString(3)+"\", ");
    out.print("\"eng\": \""+rset.getString(4)+"\", ");
    out.print("\"mat\": \""+rset.getString(5)+"\"}");
    cnt++;
	}
  out.print("]");


	pstmt.close();
	conn.close();

%>
