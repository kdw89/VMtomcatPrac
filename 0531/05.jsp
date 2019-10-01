<%@ page contentType="text/html; charset=UTF-8" %>
<HTML>
<HEAD>
</HEAD>
<BODY>
<%
String arr[] = new String[]{"111","222","333"};		//배열
String str="abc,efg,hij";				// , 로 연결된 문자열
String str_arr[] = str.split(",");		// , 로 분할하여 배열로
%>
arr[0]:<%=arr[0] %><br>
arr[1]:<%=arr[1] %><br>
arr[2]:<%=arr[2] %><br>			<!--배열 출력-->
str_arr[0]:<%=str_arr[0] %><br>
str_arr[1]:<%=str_arr[1] %><br>
str_arr[2]:<%=str_arr[2] %><br>			<!--문자열을 분할한 배열-->
Good..
</BODY>
</HTML>