<%@ page contentType="text/html; charset=UTF-8" %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<%
String arr[] = new String[]{"111","222","333"};
try {
	out.println(arr[4]+"<br>");			//arr[4] 항목은 없기때문에 에러
} catch(Exception e) {
	out.println("error==>"+e+"<========<br>");
}
%>
Good..
</BODY>
</HTML>