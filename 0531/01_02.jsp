<%@ page import="java.sql.*, javax.mail.*, javax.mail.internet.*"
			contentType="text/html; charset=UTF-8" %>		<!--import 할수도 있다-->
<HTML>
<BODY>
	<% String myUrl = "http://www.kopo.ac.kr"; %>	<!--링크 문자열로 선언-->
	<a href="<%= myUrl %>">Hello</a> World.			<!--대입한다-->
</BODY>
</HTML>