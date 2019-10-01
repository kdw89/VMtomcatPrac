<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*,java.net.*,java.lang.*" %>
<%@ page import="java.util.regex.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>

<html>
<head>

<%
	int iauto=5000;
	String s_url="emptyRoom.jsp";
	
	String cflag = request.getParameter("flag");
	
	if(cflag == null) cflag="0";
	
	int icnt = Integer.parseInt(cflag)+1;
	
	if(icnt > 10) icnt=1;
	s_url= String.format("%s?flag=%d", s_url, icnt);
%>
<script>
function refresh_start() {
	location.href='<%=s_url%>'
}
</script>
</head>
<body>
<center>
<h1>리조트 빈방정보</h1>
<%
	String sql = "";
	Object time = application.getAttribute("time");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	PreparedStatement pstmt = null;
	sql = "select server_num, empty_room, last_req_time, name from resort_room";
	pstmt = conn.prepareStatement(sql);
	ResultSet rset = pstmt.executeQuery();
	
%>
<table border=1>
<tr><th>리조트명</th><th>빈방</th><th>조회시간</th></tr>
<%

	while(rset.next()){
		out.println("<tr>");
		out.println("<td>"+rset.getString(4)+"</td>");
		out.println("<td>"+rset.getString(2)+"</td>");
		out.println("<td>"+rset.getString(3)+"</td>");
		out.println("</tr>");

	}
	
	rset.close();
	pstmt.close();	
	conn.close();
	stmt.close();

%>
</table>
<%
	out.println("크롤링 시간 : " + time + "초");
%>
</center>
<script>
var timer = setInterval('refresh_start()', <%=iauto%>);
</script>
</body>
</html>