<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String name = request.getParameter("username");
	String password = request.getParameter("userpasswd");		//패러미터 수신
%>
<HTML>
<HEAD>
	<TITLE></TITLE>
</HEAD>
<BODY>
	이름 : <%= name %><br>
	비밀번호 : <%= password %><br>		<!--수신된 패러미터 출력-->
</BODY>
</HTML>