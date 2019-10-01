<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<style>
  table {
    border-top: 1px solid #444444;
	border-left: 1px solid #444444;
	border-right: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }												//스타일 지정
</style>
<script>
function submitForm(mode){
	fm.action = "A_03.jsp";
	var name = document.getElementById("name").value.trim();
    if(name == "") alert('후보명을 입력하세요');
	else fm.submit();
}
function characterCheck() {
            var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식 구문
            var name = document.getElementsByName("name")[0]
            if (RegExp.test(name.value)) {
                alert("특수문자는 입력하실 수 없습니다.");
                name.value = name.value.substring(0, name.value.length - 1);//특수문자를 지우는 구문
            }
        }
</script>
<title>투ㅡ표</title>
</head>
<body>
<center>
<a href=A_01.jsp><img src='./image/a1.png'/></a>
<a href=B_01.jsp><img src='./image/b0.png'/></a>
<a href=C_01.jsp><img src='./image/c0.png'/></a>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	ResultSet rset = stmt.executeQuery("select * from hubo");		//후보 쿼리
%>
<br><br><br>
<table>	
<%
	while (rset.next()) {
		out.println("<form method=post action='A_02.jsp'><tr>");
		out.println("<td width=80><p align=center>기호번호 : </p></td>");
		out.println("<td><input style='text-align:center; width:50px; height:30px;'"
		+" type=text name=id value="+Integer.toString(rset.getInt(1))+" readonly></td>");
		out.println("<td width=80><p align=center>후보명 : </p></td>");
		out.println("<td width=50><p align=center>"+rset.getString(2)+"</p></td>");
		out.println("<td width=30><p align=center></p></td>");
		out.println("<td width=50><p align=center><input type=submit value=삭제></p></td>");
		out.println("</tr></form>");						//삭제를 위한 폼
	}
	rset.close();
	stmt.close();
	conn.close();
%>
<form method=post name='fm'>			<!--추가를 위한 폼-->
	<tr>
		<td width=80><p align=center>기호번호 : </p></td>
		<td><input style="text-align:center; width:50px; height:30px;" type="text" name="id" value="자동" readonly></td>
		<td width=80><p align=center>후보명 : </p></td>
		<td><input style="text-align:center; width:120px; height:30px;" type="text" maxlength=10 name="name" id="name" 
										onpaste="return false;" onkeyup="characterCheck()" onkeydown="characterCheck()"></td>
		<td width=30><p align=center></p></td>
		<td width=50><p align=center><input type="button" name="add" value="추가" OnClick="submitForm()"></p></td>
	</tr></form>
</table>

</center>
</body>
</html>