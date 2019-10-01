<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*,java.net.*,java.lang.*" %>
<%@ page import="java.util.regex.*" %>
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

public String goLogin(String getURL) {
	return goXML (getURL,true);
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
		nameValuePairs.add(new BasicNameValuePair("id", "idValue"));
		nameValuePairs.add(new BasicNameValuePair("pw", "pwValue"));
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
<%
	String ret = goLogin("");
	//out.println(ret);
	ret=goXML("https://www.naver.com/");
	//out.println(ret);
	
	int cnt = 0;
	Pattern p = Pattern.compile("src=");
	Matcher m = p.matcher(ret);
	while (m.find()) {
		cnt++;
	}
	
	int cnt2 = 0;
	Pattern p2 = Pattern.compile("정치");
	Matcher m2 = p2.matcher(ret);
	while (m.find()) {
		cnt2++;
	}
	out.println("<h2>src= : "+cnt+" 개</h2>");
	out.println("<h2>정치 : "+cnt2+" 개</h2>");
%>
</body>
</html>