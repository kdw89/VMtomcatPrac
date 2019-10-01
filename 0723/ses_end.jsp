<%@ page contentType="text/html; charset=utf-8"%>
<HTML>
<HEAD>
<TITLE>세션 종료</TITLE>
</HEAD>
<BODY>
<%
	session.invalidate();
%>
</BODY>
</HTML>