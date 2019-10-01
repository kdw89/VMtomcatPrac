<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page errorPage="error.jsp" %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<%
String arr[] = new String[]{"111","222","333"};

	out.println(arr[4]+"<br>");
%>			//try~ catch를 선언않으면 에러 발생시 위에 선언된 error.jsp로 이동한다
Good..
</BODY>
</HTML>