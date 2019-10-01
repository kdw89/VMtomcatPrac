<%@ page contentType="text/html; charset=utf-8"%>
<%
	String myName = "Hong.SJCU";
	Cookie cookieName = new Cookie("name", myName);
	cookieName.setMaxAge(-1);	//브라우저 켜있을때 까지
	response.addCookie(cookieName);	//response객체에 보내야 사용가능함

%>
<HTML>
<HEAD>
<TITLE>쿠키 저장</TITLE>
</HEAD>
<BODY>JSP 쿠키사용</BODY>
</HTML>