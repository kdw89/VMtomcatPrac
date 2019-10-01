<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<%@ page errorPage="error.jsp" %>
<html>

<head>
<meta name="viewport" content="user-scalable=no, width=device-width" />
<br>
<style>
.text_border {
	text-shadow: -1px 0 #000000, 0 1px #000000, 1px 0 #000000, 0 -1px #000000;
}
th, td {
	padding:5px
}
.outline{
	background-color: #ffffff;
	width: 100%;
}
</style>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
</head>
<body>
<%
Calendar cal = Calendar.getInstance();
SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd (E)", Locale.KOREAN);
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREAN);
String[][] resv_arr=new String[4][30];
String sql = "";
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
Statement stmt = conn.createStatement();


%>
<center>
<h3>예약상황</h3>
<table style="width:fixed" class="table table-sm">
<tr><th>날짜</th>
<th>VIP 룸</th>
<th>일반 룸</th>
<th>합리적인룸</th>
</tr>

<%
for (int i=0; i <30; i++){
	out.println("<tr>");
	if(cal.get(Calendar.DAY_OF_WEEK) == 1 || cal.get(Calendar.DAY_OF_WEEK) == 7) out.println("<td style='color:#ff0000' width='31%'>");
	else out.println("<td style='color:#000000' width='31%'>");
	out.println(dformat.format(cal.getTime()) + "</td>");
	resv_arr[0][i] = dformat.format(cal.getTime());
	
	ResultSet rset1 = stmt.executeQuery("select name from resv where resv_date='"+dformat.format(cal.getTime())+"' and room=1");
	if(rset1.next()) { 
		
		if(rset1.getString(1).length() < 3) resv_arr[1][i] = rset1.getString(1).substring(0,1) + "*";
		else resv_arr[1][i] = rset1.getString(1).substring(0,1) + "*" + rset1.getString(1).substring(rset1.getString(1).length()-1, rset1.getString(1).length());
	
	}
	else resv_arr[1][i] = "<strong><a href='d_02_m.jsp?resv_date=" + df.format(cal.getTime()) + "&room=1'>예약가능</a></strong>";
	out.println("<td width='23%'>"+resv_arr[1][i]+"</td>");
	
	ResultSet rset2 = stmt.executeQuery("select name from resv where resv_date='"+dformat.format(cal.getTime())+"' and room=2");
	if(rset2.next()) {
		
		if(rset2.getString(1).length() < 3) resv_arr[2][i] = rset2.getString(1).substring(0,1) + "*";
		else resv_arr[2][i] = rset2.getString(1).substring(0,1) + "*" + rset2.getString(1).substring(rset2.getString(1).length()-1, rset2.getString(1).length());
		
	}
	else resv_arr[2][i] = "<strong><a href='d_02_m.jsp?resv_date=" + df.format(cal.getTime()) + "&room=2'>예약가능</a></strong>";
	out.println("<td width='23%'>"+resv_arr[2][i]+"</td>");
	
	ResultSet rset3 = stmt.executeQuery("select name from resv where resv_date='"+dformat.format(cal.getTime())+"' and room=3");
	if(rset3.next()) {
		
		if(rset3.getString(1).length() < 3) resv_arr[3][i] = rset3.getString(1).substring(0,1) + "*";
		else resv_arr[3][i] = rset3.getString(1).substring(0,1) + "*" + rset3.getString(1).substring(rset3.getString(1).length()-1, rset3.getString(1).length());
		
	}
	else resv_arr[3][i] = "<strong><a href='d_02_m.jsp?resv_date=" + df.format(cal.getTime()) + "&room=3'>예약가능</a></strong>";
	out.println("<td width='23%'>"+resv_arr[3][i]+"</td>");
	
	cal.add(cal.DATE,+1);
	out.println("</tr>");
}
%>

</table>

</center>
</body>
</html>