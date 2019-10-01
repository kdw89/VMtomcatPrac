<%@ page contentType="text/html; charset=utf-8"%>
<HTML>
<HEAD>
<TITLE>세션 가져오기</TITLE>
</HEAD>
<BODY>
<%
	String id = null;
	id = (String)session.getAttribute("session_id");
	out.println(id);
%>
</BODY>
</HTML>