<%@ page contentType="text/html; charset=UTF-8" %>
<HTML>
<HEAD>
<%! //함수나 변수 선언시 !
private String call1(){
	String a = "abc";
	String b = "efg";
	return (a+b);		//합친 문자열 리턴
}
private Integer call2(){
	Integer a = 1;
	Integer b = 2;
	return (a+b);		//덧셈 리턴
}
%>
</HEAD>
<BODY>
String연산:<%=call1()%><br>
Integer연산:<%=call2()%><br>	<!--펑션 호출, 결과 출력-->
Good...
</BODY>
</HTML>