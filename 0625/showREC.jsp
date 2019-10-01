<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%
	String studentId = request.getParameter("studentId"); //get방식으로 숫자 수신
	try {
%>
<html>
<head>
<script>
	function mySubmit(index) {				//폼에 submit 두 개 적용

		if(index == 1) {
			document.myForm.action='updateDB.jsp';
			var name = document.getElementById("name").value.trim();
			if(name == "") alert('이름을 입력하세요');
			else myForm.submit();
		}
		if(index == 2) {
			document.myForm.action='deleteDB.jsp';
			myForm.submit();
		}
	}
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
	function fnc(value, min, max) 			//숫자 최대값
	{
		if(parseInt(value) < 0 || isNaN(value)) 
			return 0; 
		else if(parseInt(value) > max) 
			return max; 
		else return value;
	}
</script>
</head>
<body>
<h1>성적 조회 후 정정/삭제<h1>
<form method="post" action="showREC.jsp">
<table>
<tr><td>조회할 학번 : </td>
<td><input type="text" name="studentId" onkeydown='return onlyNumber(event)' onkeyup='this.value = fnc(this.value, 0, 9999999)' onfocusout='removeChar(event)' onkeypress='removeChar(event)'></td>
<td><input type="submit" value="조회"></td></tr>
</table>
</form>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	if(studentId.isEmpty()) {
		studentId = "1";
	}
	ResultSet rset = stmt.executeQuery("select * from examtable where studentid =" + studentId);
%>
<form name ="myForm" method="post">
<Table>
<%
	if (!rset.next()){
		out.println("<tr><td>이름</td><td><input type=text name=name value="+ "다시" +" readonly></td></tr>");
		out.println("<tr><td>학번</td><td><input type=text name=studentid value="+ "검색하여" +" readonly></td></tr>");
		out.println("<tr><td>국어</td><td><input type=text name=kor value="+ "주십시오" +" readonly></td></tr>");
		out.println("<tr><td>영어</td><td><input type=text name=eng value='' readonly></td></tr>");
		out.println("<tr><td>수학</td><td><input type=text name=mat value='' readonly></td></tr>");		//잘못된 검색 처리
	} else {
	out.println("<tr><td>이름</td><td><input type=text id='name' name='name' value='"+ rset.getString(1) +"' size=20 maxlength=10></td></tr>");
	out.println("<tr><td>학번</td><td><input type=text name='studentid' value='"+ rset.getInt(2) +"' readonly></td></tr>");
	out.println("<tr><td>국어</td><td><input type=text name=kor value='"+ rset.getInt(3) 
	+"' maxlength=3 onkeydown='return onlyNumber(event)' onkeyup='this.value = fnc(this.value, 0, 100)' onfocusout='removeChar(event)' onkeypress='removeChar(event)'></td></tr>");
	out.println("<tr><td>영어</td><td><input type=text name=eng value='"+ rset.getInt(4) 
	+"' maxlength=3 onkeydown='return onlyNumber(event)' onkeyup='this.value = fnc(this.value, 0, 100)' onfocusout='removeChar(event)' onkeypress='removeChar(event)'></td></tr>");
	out.println("<tr><td>수학</td><td><input type=text name=mat value='"+ rset.getInt(5) 
	+"' maxlength=3 onkeydown='return onlyNumber(event)' onkeyup='this.value = fnc(this.value, 0, 100)' onfocusout='removeChar(event)' onkeypress='removeChar(event)'></td></tr>");
	out.println("</Table><input type=button value=수정 onClick='mySubmit(1)'>" +
					"<input type=button value=삭제 onClick='mySubmit(2)'></form>");				//재검색, 수정, 삭제
	}
	rset.close();
	stmt.close();
	conn.close();
	
	} catch (Exception e) {
			out.println("<h1>테이블이 없는데요</h1>");
	}
%>
</body>
</html>