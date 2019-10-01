<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>

<head>

<br>
<style>
.text_border {
	text-shadow: -1px 0 #000000, 0 1px #000000, 1px 0 #000000, 0 -1px #000000;
}
#fixed{
	position:fixed;
	bottom:0%;
	right:0%;			/*브라우저 우하단에 고정*/
	width:fixed;
	padding:5px;
	color:white;
}

th, td {
	padding:5px
}
.outline{
	background-color: #ffffff;
	width: 1000px;
	padding:20px;
	border-radius:20px;
	border: 5px solid gold;	
}
</style>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
</head>
<body background='/0709/background.jpg'>
<%
Calendar cal = Calendar.getInstance();
SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd (E)", Locale.KOREAN);
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

String sql = "";
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
Statement stmt = conn.createStatement();

%>
<center>
<div class='outline' >
<h3>예약상황</h3>
<table style="width:800px" class="table table-sm">
<tr><th>날짜</th>
<th>VIP 룸</th>
<th>일반 룸</th>
<th>합리적인룸</th>
</tr>

<%
	ResultSet rset = stmt.executeQuery("select resv_date, max(room1), max(room2), MAX(room3) FROM (SELECT resv_date, if(room=1, name, NULL) AS room1, if(room=2, name, NULL) AS room2, if(room=3, name, null)AS room3 from resv where resv_date >= CURDATE() order by resv_date) AS T GROUP BY resv_date");
	rset.last();
	String[][] resv_arr=new String[4][rset.getRow()];
	rset.beforeFirst();
	
	int j = 0;
	while(rset.next()) {
		resv_arr[0][j] = rset.getString(1);
		resv_arr[1][j] = rset.getString(2);
		resv_arr[2][j] = rset.getString(3);
		resv_arr[3][j] = rset.getString(4);
		j++;
	}
	
	int l=0;
	
	
	/*for(int p=0; p < resv_arr[0].length; p++) {
		out.println(resv_arr[0][p] +"------"+ resv_arr[1][p] +"------"+ resv_arr[2][p] +"------"+ resv_arr[3][p] + "<br>");
	}*/
	
for (int i=0; i <30; i++){
	
	out.println("<tr>");
	if(cal.get(Calendar.DAY_OF_WEEK) == 1 || cal.get(Calendar.DAY_OF_WEEK) == 7) out.println("<td style='color:#ff0000'>");
	else out.println("<td style='color:#000000'>");
	out.println(dformat.format(cal.getTime()) + "</td>");
	
	if(df.format(cal.getTime()).equals(resv_arr[0][l])) {

		for(j=1; j<4; j++) {
			if(resv_arr[j][l] == null) {out.println("<td><strong><a href='d_02.jsp?resv_date=" + df.format(cal.getTime()) + "&room="+j+"'>예약가능</a></strong></td>"); }
			else {
				if(resv_arr[j][l].length() < 3) resv_arr[j][l] = resv_arr[j][l].substring(0,1) + "*";
				else resv_arr[j][l] = resv_arr[j][l].substring(0,1) + "*" + resv_arr[j][l].substring(resv_arr[j][l].length()-1, resv_arr[j][l].length());
				out.println("<td>" + resv_arr[j][l] + "</td>");
			}
		}
		if(l < resv_arr[0].length - 1)	l++;
		
	}	else {
		for(j=1; j<4; j++) {
			out.println("<td><strong><a href='d_02.jsp?resv_date=" + df.format(cal.getTime()) + "&room="+j+"'>예약가능</a></strong></td>");
		}

	}
	
	cal.add(cal.DATE,+1);
	out.println("</tr>");
} 
//out.println("<td><strong><a href='d_02.jsp?resv_date=" + df.format(cal.getTime()) + "&room="+j+"'>예약가능</a></strong></td>");
%>
</table>
</div>
</center>
</body>
</html>