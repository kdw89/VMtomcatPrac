<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String key = request.getParameter("key");
	Long key2 = Long.parseLong(key);
%>
<html>
<head>
<SCRIPT LANGUAGE="javaScript">
	function onlyNumber(event){				//숫자만 입력
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	}
 
	function removeChar(event) {			//문자 제거
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	function fnc(value, min, max) 			//숫자 최소, 최대값
	{
		if(parseInt(value) < min || isNaN(value)) 
			return min; 
		else if(parseInt(value) > max) 
			return 0; 
		else return value;
	}
	
function submitForm(mode){
	fm.action = "stock_write.jsp?key=UPDATE";
	var inven = document.getElementById("inven").value.trim();
	if(inven == "") alert('재고 현황을 입력하세요');
	else fm.submit();
}
</SCRIPT>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
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
<body>
<center>
<h1><b>㈜트와이스 재고 현황 -재고수정</b></h1><br>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "SELECT id, product, inven, take_inven, product_regist, detail, photo from stock where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setLong(1,key2);
	ResultSet rset = pstmt.executeQuery();
	Statement stmt = conn.createStatement();
%>
<FORM METHOD=POST name='fm'>
<table class="table table-striped" style="font-size:2em; table-layout:fixed" autocomplete="off">
<%	
	rset.next();
	out.println("<tr><td width='25%'><b>상품 번호</b></td>");
	out.println("<td>"+rset.getLong(1)+"<input type=hidden name=id value="+rset.getLong(1)+" readonly>"+"</td></tr>");
	out.println("<tr><td><b>상품명</b></td>");
	out.println("<td>"+rset.getString(2)+"</td></tr>");
	out.println("<tr><td><b>재고 현황</b></td>");
	out.println("<td><input type=number id=inven name=inven value="+rset.getInt(3)
		+" min=0 onkeydown='return onlyNumber(event)' onkeyup='this.value = fnc(this.value, 0, 65535)' onfocusout='removeChar(event)' onkeypress='removeChar(event)'></td></tr>");
	out.println("<tr><td><b>상품등록일</b></td>");
	out.println("<td>"+rset.getDate(4)+"</td></tr>");
	out.println("<tr><td><b>재고등록일</b></td>");
	out.println("<td>"+rset.getDate(5)+"</td></tr>");
	out.println("<tr><td><b>상품설명</b></td>");
	out.println("<td>"+rset.getString(6)+"</td></tr>");
	out.println("<tr><td><b>상품사진</b></td>");
	out.println("<td><img src='"+rset.getString(7)+"' width='40%' height='auto'></td></tr>");
	rset.close();
	stmt.close();
	conn.close();
%>
</table>
<div id=fixed><input type=button value="취소" class="btn btn-warning btn-lg" style="font-size:5em" OnClick="location.href='stock_list.jsp'">
<input type=button value="쓰기" class="btn btn-primary btn-lg" style="font-size:5em" OnClick="submitForm('write')"></div>
</FORM>
</center>
</body>
</html>