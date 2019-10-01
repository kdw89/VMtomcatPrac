<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String key = request.getParameter("key");
	int key2 = Integer.parseInt(key);
%>
<html>
<head>
<SCRIPT LANGUAGE="javaScript">
function submitForm(mode){
	if(mode == "write"){
		fm.action = "gongji_write.jsp";
		var title = document.getElementById("title").value.trim();
		var content = document.getElementById("content").value.trim();
		if(title == "") alert('제목을 입력하세요');
		else if(content == "") alert('내용을 입력하세요');
		else fm.submit();
	}else if(mode == "delete"){
		fm.action = "gongji_delete.jsp";
		fm.submit();
	}

}
</SCRIPT>
</head>
<body>
<center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "select title, date, content from gongji where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,key2);
	ResultSet rset = pstmt.executeQuery();
%>
<FORM METHOD=POST name='fm'>
<table width=650 border=1 cellspacing=0 cellpadding=5>
<%	
	rset.next();
	out.println("<tr>");
	out.println("<td><b>번호</b></td>");
	out.println("<td><input type=text name=id size=70 maxlength=70 value='"+key2+"' readonly></td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td><b>제목</b></td>");
	out.println("<td><input type=text id=title name=title size=70 maxlength=70 value=\""+rset.getString(1)+"\"></td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td><b>일자</b></td>");
	out.println("<td>"+rset.getDate(2)+"</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td><b>내용</b></td>");
	out.println("<td><textarea style='width:500px; height:250px;' id=content name=content cols=70 row=600>"
												+rset.getString(3)+"</textarea></td>");
	out.println("</tr>");
	rset.close();
	pstmt.close();
	conn.close();
%>
</table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp'"></td>
<td><input type=button value="쓰기" OnClick="submitForm('write')"></td>
<td><input type=button value="삭제" OnClick="submitForm('delete')"></td>
</tr>
</table>
</FORM>
</center>
</body>
</html>