<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.net.*" %>
<%@ page import = "javax.xml.parsers.*, org.w3c.dom.*" %>
<html>
<head>
</head>
<body>
<h1>와이파이</h1>
<%
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	
	Document doc = docBuilder.parse(new File("/var/lib/tomcat8/webapps/ROOT/0730/wifi.xml"));
	
	Element root = doc.getDocumentElement();
	
	NodeList tag_address = doc.getElementsByTagName("소재지지번주소");
	NodeList tag_address_new = doc.getElementsByTagName("소재지도로명주소");
	NodeList tag_lat = doc.getElementsByTagName("위도");
	NodeList tag_lng = doc.getElementsByTagName("경도");

	out.println("<table cellspacing=1 width=800 border=1>");
	out.println("<tr>");
	out.println("<td width=100>순번</td>");
	out.println("<td width=500>소재지지번주소</td>");
	out.println("<td width=100>위도</td>");
	out.println("<td width=100>경도</td>");
	out.println("</tr>");
	
	//out.println(tag_address.getLength());			// 24010
	
	for(int i=0; i<tag_address.getLength(); i++) {
		out.println("<tr>");
		out.println("<td>"+i+"</td>");
		try {
			out.println("<td>"+tag_address.item(i).getFirstChild().getNodeValue()+"</td>");
		} catch (Exception e) {
			out.println("<td>"+tag_address_new.item(i).getFirstChild().getNodeValue()+"</td>");
		}
		out.println("<td>"+tag_lat.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("<td>"+tag_lng.item(i).getFirstChild().getNodeValue()+"</td>");
		out.println("</tr>");
	}
	out.println("</table>");

%>
</body>
</html>