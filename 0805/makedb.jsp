<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*,java.util.Date" %>
<html>
<head>
<%
	try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	stmt.execute("create table resort_room(" 
						+ "server_num int not null primary key, " 
						+ "login_url varchar(100), " 
						+ "uName varchar(20), " 
						+ "uValue varchar(20), " 
						+ "pName varchar(20), " 
						+ "pValue varchar(20), " 
						+ "adm_allview_url varchar(100), " 
						+ "empty_room int, " 
						+ "last_req_time datetime, " 
						+ "last_proc_flag boolean) DEFAULT CHARSET=utf8");		//테이블 생성문
						
	stmt.execute("insert into resort_room (server_num, login_url, uName, uValue, pName, pValue, adm_allview_url) "+
		"values(1,'http://192.168.23.110:8080/0709/adm_loginck.jsp' ,'id','admin','pw','1111','http://192.168.23.110:8080/0709/adm_allview.jsp')");
	
	stmt.execute("insert into resort_room (server_num, login_url, uName, uValue, pName, pValue, adm_allview_url) "+
		"values(2,'http://192.168.23.105:8080/VB_Ubuntu/jsp/chapter9_resort/admin/login_check.jsp' ,'id','admin','passwd','admin','http://192.168.23.105:8080/VB_Ubuntu/jsp/chapter9_resort/admin/reserve_list.jsp')");
	
	stmt.execute("insert into resort_room (server_num, login_url, uName, uValue, pName, pValue, adm_allview_url) "+
		"values(3,'http://35.190.225.81:8080/WebServer/Lecture11_Practice_Resort/Admin/adm_loginck.jsp' ,'id','admin','passwd','admin','http://35.190.225.81:8080/WebServer/Lecture11_Practice_Resort/Admin/adm_allview.jsp')");
	
	stmt.execute("insert into resort_room (server_num, login_url, uName, uValue, pName, pValue, adm_allview_url) "+
		"values(4,'http://192.168.23.94:8080/0709_resort/adm_login_ck.jsp' ,'id','admin','passwd','adad','http://192.168.23.94:8080/0709_resort/d_01.jsp')");
	
	stmt.execute("insert into resort_room (server_num, login_url, uName, uValue, pName, pValue, adm_allview_url) "+
		"values(5,'http://192.168.23.92:8080/190709HomePage/adm_loginck.jsp' ,'id','admin','passwd','1111','http://192.168.23.92:8080/190709HomePage/adm_allview.jsp')");
	
	stmt.execute("insert into resort_room (server_num, login_url, uName, uValue, pName, pValue, adm_allview_url) "+
		"values(6,'http://tarae.tk:8080/web/chap9/index.jsp?pageValue=adm_login.jsp&jump=main.jsp' ,'inputEmail','giosun2','inputPassword','940926','http://tarae.tk:8080/web/chap9/index.jsp?pageValue=adm_allview.jsp')");
	
	
	out.println("<h1>테이블 생성 완료</h1>");

	stmt.close();
	conn.close();
	} catch (Exception e) {
			out.println("<h1>이미 테이블이 존재합니다.</h1>");
	}
	
%>
</head>
<body>

</body>
</html>