<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>
<%@ page import = "javax.xml.parsers.*, org.w3c.dom.*" %>

<html>
<head>
</head>
<body>
<h1>성적 조회</h1>
<%
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	
	Document doc = docBuilder.parse(new File("/var/lib/tomcat8/webapps/ROOT/0730/testdata.xml"));
	
	Element root = doc.getDocumentElement();
	NodeList tag_name = doc.getElementsByTagName("name");
	NodeList tag_studentid = doc.getElementsByTagName("studentid");
	NodeList tag_kor = doc.getElementsByTagName("kor");
	NodeList tag_eng = doc.getElementsByTagName("eng");
	NodeList tag_mat = doc.getElementsByTagName("mat");

	out.println("<table cellspacing=1 width=500 border=1>");
	out.println("<tr>");
	out.println("<td width=100>이름</td>");
	out.println("<td width=100>학번</td>");
	out.println("<td width=100>국어</td>");
	out.println("<td width=100>영어</td>");
	out.println("<td width=100>수학</td>");
	out.println("</tr>");
	
	for(int i=0; i<tag_name.getLength(); i++) {
		out.println("<tr>");
		out.println("<td width=100>"+tag_name.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_studentid.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_kor.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_eng.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td width=100>"+tag_mat.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("</tr>");
	}
	
	
	out.println("</table>");

%>
<% out.println("<p>bufferSize: " + out.getBufferSize() + " remaining: " + out.getRemaining() + " used: " + (out.getBufferSize() - out.getRemaining()) + " autoFlush: " + out.isAutoFlush() + "</p><br>"); %>
</body>
</html>