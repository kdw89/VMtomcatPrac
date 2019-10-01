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

public String goLogin(String getURL, String id, String idValue, String pw, String pwValue) {
	return goXML (getURL ,id, idValue, pw, pwValue, true);
}

public String goXML(String getURL) {
	return goXML(getURL, "", "", "", "", false);
}


public String goXML(String getURL, String id, String idValue, String pw, String pwValue, Boolean loginFlag) {
	String Result = null;
	HttpClient client = getThreadSafeClient();
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 100000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 100000);
	HttpPost post = new HttpPost(getURL);
	
	List <NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
	if (loginFlag) {
		nameValuePairs.add(new BasicNameValuePair(id, idValue));
		nameValuePairs.add(new BasicNameValuePair(pw, pwValue));
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
	String ret = goLogin("http://192.168.23.110:8080/0709/adm_loginck.jsp","id","admin","pw","1111");
	//out.println(ret);
	ret=goXML("http://192.168.23.110:8080/0709/adm_allview.jsp");
	//out.println(ret);
	
	int cnt = 0;
	Pattern p = Pattern.compile("예약가능");
	Matcher m = p.matcher(ret);
	while (m.find()) {
		cnt++;
	}
	out.println("<h2>개구리조트 예약가능 방수 : "+cnt+" 개</h2>");
%>
</body>
</html>