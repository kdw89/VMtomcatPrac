<%@ page contentType="text/html; charset=UTF-8" %>
<HTML>
<HEAD>
<%!
private class AA{
	private int Sum(int i, int j){
		return i + j;
	}						//덧셈을 수행하는 클래스
}
AA aa = new AA();
%>
</HEAD>
<BODY>
<% out.println("2+3=" + aa.Sum(2,3));%><br>
Good..							<!--클래스 호출-->
</BODY>
</HTML>