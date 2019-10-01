<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*,java.net.*,java.lang.*" %>
<html>
<head>
<%
	int iauto=2000;
	String s_url="autoreq.jsp";
	
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
iAuto : <%=iauto%><br>
flag : <%=cflag%><br>
</center>
<script>
var timer = setInterval('refresh_start()', <%=iauto%>);
</script>
</body>
</html>