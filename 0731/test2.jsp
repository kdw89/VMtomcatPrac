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
%>

</head>
<body>
<%
String getURL = "http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123";
String Result = null;
HttpClient client = getThreadSafeClient();
HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
HttpPost post = new HttpPost(getURL);

List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
if (false) {
	nameValuePairs.add(new BasicNameValuePair("input1", "kopoctc"));
}


post.setEntity(new UrlEncodedFormEntity(nameValuePairs));
HttpResponse responsePost = null;

responsePost = client.execute(post);
HttpEntity resEntity = responsePost.getEntity();

if (resEntity != null) {
	Result = EntityUtils.toString(resEntity).trim();
}
%>
</body>
</html>