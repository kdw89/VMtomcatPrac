<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<html>
<head>
<script>
function submitForm(mode){
	fm.action = "B_02.jsp";
	var name = document.getElementById("name").value.trim();
	var age = document.getElementById("age").value.trim();
	if(name == "") alert('후보를 선택하세요');
	else if(age == "") alert('연령대를 선택하세요');
	else fm.submit();
}
</script>
<title>투ㅡ표</title>
</head>
<body>
<center>
<a href=A_01.jsp><img src='./image/a0.png'/></a>
<a href=B_01.jsp><img src='./image/b1.png'/></a>
<a href=C_01.jsp><img src='./image/c0.png'/></a>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from hubo");			//후보를 조회해서
%>
<br><br><br><br><br>
<table border="1">
<form method=post name='fm'><tr>
<td><select name="id" id="name" style="font-size: large; text-align:center; width:150px; height:40px;"><option value="">후보</option>
<%
	while (rset.next()) {
		out.println("<option value="+Integer.toString(rset.getInt(1))+">"+Integer.toString(rset.getInt(1))
				+"번 "+rset.getString(2)+"</option>");				//select 옵션으로
	}
	rset.close();
	stmt.close();
	conn.close();
%>
</select></td>
	<td><select name="age" id="age" style="font-size: large; text-align:center; width:100px; height:40px;">
		<option value="">연령대</option>			
		<option value="10">10대</option>
		<option value="20">20대</option>
		<option value="30">30대</option>
		<option value="40">40대</option>			<!--연령은 그냥 넣어주었다-->
		<option value="50">50대</option>
		<option value="60">60대</option>
		<option value="70">70대</option>
		<option value="80">80대</option>
		<option value="90">90대</option>
		</select></td>
	<td><input style="font-size: large; text-align:center; width:100px; height:40px;" type="button" name="vote" value="투표" OnClick="submitForm()"></td>
</tr></form>							<!--폼 제출-->
</table>
</center>
</body>
</html>