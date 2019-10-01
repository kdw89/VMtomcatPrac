<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String key = request.getParameter("key");
	try {
	long key2 = Long.parseLong(key);
%>
<html>
<head>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<SCRIPT LANGUAGE="javaScript">
function fnc(value, min, max) 			//숫자 최소, 최대값
{
	if(parseInt(value) < min || isNaN(value)) 
		return min; 
	else if(parseInt(value) > max) 
		return null; 
	else return value;
}
	
function submitForm(mode){
	if(mode == "update"){
		fm.action = "stock_update.jsp";
		fm.submit();
	}else if(mode == "delete"){
		fm.action = "stock_delete.jsp";
		if(confirm("정말 삭제하시겠습니까?") == true) fm.submit();
	}
}
</SCRIPT>
<style>
#fixed{
	position:fixed;
	bottom:3%;
	right:3%;			/*브라우저 우하단에 고정*/
	width:fixed;
	padding:5px;
	color:white;
}
</style>
</head>
<body onload="document.search.reset();">
<center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "SELECT id, product, inven, take_inven, product_regist, detail, photo from stock where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setLong(1,key2);
	ResultSet rset = pstmt.executeQuery();
%>
<h1><b>㈜트와이스 재고 현황 -상품상세</b></h1><br>
<form name="search" action='stock_view.jsp' method='POST' class="form-inline" autocomplete="off">
	<input type=number name=key class="form-control" min=1 style="font-size: 2em; width:60%; height:2em;" onkeyup='this.value = fnc(this.value, 1, 99999999999999)' autofocus>
	<input type=submit value="검색" class="btn btn-primary btn-lg" style="font-size: 3em;">
</form>
<FORM METHOD=POST name='fm'>
<table class="table table-striped" style="font-size:2em; table-layout:fixed">
<%
	rset.next();
	out.println("<tr><td align=center width='25%'><b>상품 번호</b></td>");
	out.println("<td>"+rset.getLong(1)+"<input type=hidden name=key value='"+rset.getLong(1)+"' readonly></td></tr>");
	out.println("<tr><td align=center><b>상품명</b></td>");
	out.println("<td>"+rset.getString(2)+"<input type=hidden name=product value='"+rset.getString(2)+"' readonly></td></tr>");
	out.println("<tr><td align=center><b>재고 현황</b></td>");
	out.println("<td>"+rset.getInt(3)+"</td></tr>");
	out.println("<tr><td align=center><b>상품등록일</b></td>");
	out.println("<td>"+rset.getDate(4)+"</td></tr>");
	out.println("<tr><td align=center><b>재고등록일</b></td>");
	out.println("<td>"+rset.getDate(5)+"</td></tr>");
	out.println("<tr><td align=center><b>상품설명</b></td>");
	out.println("<td>"+rset.getString(6).replace("\r\n","<br>")+"</td></tr>");
	out.println("<tr><td align=center><b>상품사진</b></td>");
	out.println("<td><img src='"+rset.getString(7)+"' width='40%' height='auto'></td></tr>");
	String product = rset.getString(2).replace(" ", "%20");
	rset.close();
	pstmt.close();
	conn.close();
	
%>
</table>
<div id=fixed><input type=button value="재고목록" class="btn btn-primary btn-lg" style="font-size:5em" OnClick="location.href='stock_list.jsp'"><br>
<input type=button value='상품삭제' class='btn btn-danger btn-lg' style='font-size:5em' OnClick="submitForm('delete')"><br>
<input type=button value='재고수정' class='btn btn-success btn-lg' style='font-size:5em' OnClick="submitForm('update')"><br>
<%
} catch (Exception e) {
		RequestDispatcher dispatcher = request.getRequestDispatcher("search_error.jsp");
        dispatcher.forward(request, response);
	}
%>
</div>
</FORM>
</center>
</body>
</html>