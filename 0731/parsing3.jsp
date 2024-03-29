<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ page import= "org.apache.http.HttpEntity" %>
<%@ page import= "org.apache.http.HttpResponse" %>
<%@ page import= "org.apache.http.NameValuePair" %>
<%@ page import= "org.apache.http.ParseException" %>
<%@ page import= "org.apache.http.client.HttpClient" %>
<%@ page import= "org.apache.http.client.entity.UrlEncodedFormEntity" %>
<%@ page import= "org.apache.http.client.methods.HttpGet" %>
<%@ page import= "org.apache.http.client.methods.HttpPost" %>
<%@ page import= "org.apache.http.impl.client.DefaultHttpClient" %>
<%@ page import= "org.apache.http.message.BasicNameValuePair" %>
<%@ page import= "org.apache.http.params.HttpConnectionParams" %>
<%@ page import= "org.apache.http.util.EntityUtils" %>
<%@ page import= "org.apache.http.conn.ClientConnectionManager" %>
<%@ page import= "org.apache.http.params.HttpParams" %>
<%@ page import= "org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.sql.*,javax.naming.*" %>
<%@ page import = "javax.xml.parsers.*,org.w3c.dom.*" %>

<html>
<head>
<%!
DefaultHttpClient client;

public DefaultHttpClient getThreadSafeClient() {
	if (client != null)
		return client;
	client = new DefaultHttpClient();
	ClientConnectionManager mgr = client.getConnectionManager();
	HttpParams params = client.getParams();
	client = new DefaultHttpClient(new ThreadSafeClientConnManager(params, mgr.getSchemeRegistry()), params);
	return client;	
}

public String goLogin() {
	return goXML ("http://192.168.23.110:8080/0731/login.jsp",true);
}

public String goXML(String getURL) {
	return goXML(getURL, false);
}


public String goXML(String getURL, Boolean loginFlag) {
	String Result = null;
	HttpClient client = getThreadSafeClient();
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if (loginFlag) {
		nameValuePairs.add(new BasicNameValuePair("username", "kopoctc"));
		nameValuePairs.add(new BasicNameValuePair("userpasswd", "kopoctc"));
	}
	
	try {
		post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
		HttpResponse responsePost = null;
		
		responsePost = client.execute(post);
		HttpEntity resEntity = responsePost.getEntity();
		
		if (resEntity != null) {
			Result = EntityUtils.toString(resEntity).trim();
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		
	}
	return Result;
}
%>
</head>
<body>
<h1>성적 조회</h1>
<%
	String ret=goLogin();
	ret=goXML("http://192.168.23.110:8080/0731/loginxml.jsp");
	
	try {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		
		DocumentBuilder builder = factory.newDocumentBuilder();
		ByteArrayInputStream is = new ByteArrayInputStream(ret.getBytes("utf-8"));
		Document doc = builder.parse(is);

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
	} catch(Exception e) {
		e.printStackTrace();
		out.println(e.toString());
	}
%>
</body>
</html>