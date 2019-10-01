<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>
<TITLE>세션 옵션</TITLE>
</HEAD>
<BODY>
<%
	session.setAttribute("session_id","WAAAAAAAA");
	SimpleDateFormat fmt = new SimpleDateFormat("yy-MM-dd [hh:mm:ss]");
	long createTime = (long)session.getCreationTime();
	long lastTime = (long)session.getLastAccessedTime();
%>
session 생성 시간 ==> <%=fmt.format(new Date(createTime))%><br>
session 마지막 처리 시간 ==> <%=fmt.format(new Date(lastTime))%><br>
session 유지 시간 ==> <%=(int)session.getMaxInactiveInterval()%><br>
session 유지 시간 변경 ==> <%session.setMaxInactiveInterval(50);%><br>
session 값 표시 ==> <%=(String)session.getAttribute("session_id")%><br>
session ID ==> <%=session.getId()%><br>
session 유지 시간 ==> <%=(int)session.getMaxInactiveInterval()%><br>
</BODY>
</HTML>