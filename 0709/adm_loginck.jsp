<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>

</HEAD>
<BODY>
<center>
<%
	request.setCharacterEncoding("utf-8");
	
	String jump = request.getParameter("jump");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	boolean bPassChk=false;
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	PreparedStatement pstmt = null;
	
	String sql = "select id, pw from resort_adm where id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,id);
	
	ResultSet rset = pstmt.executeQuery();
	
	if(rset.next()) {
		if(id.equals(rset.getString(1)) && pw.equals(rset.getString(2))) {
			bPassChk=true;
		} else {
			bPassChk=false;
		}
	}
	if(bPassChk) {
		session.setAttribute("login_ok","yes");
		session.setAttribute("login_id",id);

		response.sendRedirect(jump);
	} else {
		out.println("<h2>아이디 또는 패스워드 오류.</h2>");
		out.println("<input type=button value='로그인' OnClick=\"location.href='adm_login.jsp?jump="+jump+"'\">");
	}
%>
</center>
</BODY>
</HTML>