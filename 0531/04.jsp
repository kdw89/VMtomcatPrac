<%@ page contentType="text/html; charset=UTF-8" %>
<HTML>
<HEAD>
<%!
String str="abcdfeffasdsd";		//문자열 선언
int str_len = str.length();		//문자열 길이
String str_sub = str.substring(5);		//5번째부터 마지막까지 출력(0번째부터 시작)
int str_loc = str.indexOf("cd");		//cd가 위치한 인덱스
String strL = str.toLowerCase();		//소문자화
String strU = str.toUpperCase();		//대문자화
%>
</HEAD>
<BODY>
Str:<%=str %><br>
str_len:<%=str_len %><br>
str_sub:<%=str_sub %><br>
str_loc:<%=str_loc %><br>
strL:<%=strL %><br>
strU:<%=strU %><br>		<!--출력-->
Good..
</BODY>
</HTML>