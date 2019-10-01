<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>
<%
	String loginOK=null;
	String jumpURL="adm_login.jsp?jump=adm_allview.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null) {
		response.sendRedirect(jumpURL);
		return;
	}
	if(!loginOK.equals("yes")) {
		response.sendRedirect(jumpURL);
		return;
	}
	
	out.println("<script>parent.menu.location.reload();</script>");
	Calendar cal = Calendar.getInstance();
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd (E)", Locale.KOREAN);
	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREAN);
	String[][] resv_arr=new String[4][30];
	String sql = "";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
%>
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
</HEAD>
<BODY background='/0709/background.jpg'>
<center>
<br>
<div class='outline' >
<h3>예약상황-admin</h3>
<table style="width:800px" class="table table-sm">
<tr><th>날짜</th>
<th>VIP 룸</th>
<th>일반 룸</th>
<th>합리적인룸</th>
</tr>
<%
for (int i=0; i <30; i++){
	out.println("<tr>");
	if(cal.get(Calendar.DAY_OF_WEEK) == 1 || cal.get(Calendar.DAY_OF_WEEK) == 7) out.println("<td style='color:#ff0000'>");
	else out.println("<td style='color:#000000'>");
	out.println(dformat.format(cal.getTime()) + "</td>");
	resv_arr[0][i] = dformat.format(cal.getTime());
	
	ResultSet rset1 = stmt.executeQuery("select name from resv where resv_date='"+dformat.format(cal.getTime())+"' and room=1");
	if(rset1.next()) { 
		resv_arr[1][i] = "<a href='adm_oneview.jsp?resv_date="+df.format(cal.getTime())+"&room=1'>"+rset1.getString(1)+"<br>";
	
	}
	else resv_arr[1][i] = "<strong><a href='d_02.jsp?resv_date=" + df.format(cal.getTime()) + "&room=1'>예약가능</a></strong>";
	out.println("<td>"+resv_arr[1][i]+"</td>");
	
	ResultSet rset2 = stmt.executeQuery("select name from resv where resv_date='"+dformat.format(cal.getTime())+"' and room=2");
	if(rset2.next()) {
		
		resv_arr[2][i] = "<a href='adm_oneview.jsp?resv_date="+df.format(cal.getTime())+"&room=2'>"+rset2.getString(1)+"<br>";
		
	}
	else resv_arr[2][i] = "<strong><a href='d_02.jsp?resv_date=" + df.format(cal.getTime()) + "&room=2'>예약가능</a></strong>";
	out.println("<td>"+resv_arr[2][i]+"</td>");
	
	ResultSet rset3 = stmt.executeQuery("select name from resv where resv_date='"+dformat.format(cal.getTime())+"' and room=3");
	if(rset3.next()) {
		
		resv_arr[3][i] = "<a href='adm_oneview.jsp?resv_date="+df.format(cal.getTime())+"&room=3'>"+rset3.getString(1)+"<br>";
		
	}
	else resv_arr[3][i] = "<strong><a href='d_02.jsp?resv_date=" + df.format(cal.getTime()) + "&room=3'>예약가능</a></strong>";
	out.println("<td>"+resv_arr[3][i]+"</td>");
	
	cal.add(cal.DATE,+1);
	out.println("</tr>");
}
%>

</table>
</div>
</center>
</BODY>
</HTML>