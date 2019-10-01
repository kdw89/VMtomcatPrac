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
<%
	int iauto=5000;
	String s_url="resort_req.jsp";
	
	String cflag = request.getParameter("flag");
	
	if(cflag == null) cflag="0";
	
	int icnt = Integer.parseInt(cflag)+1;
	
	if(icnt > 10) icnt=1;
	s_url= String.format("%s?flag=%d", s_url, icnt);
%>
<script>
function refresh_start() {
	location.href='<%=s_url%>'
}
</script>
</head>
<body>
<center>
<%


	String ret = goLogin("http://192.168.23.110:8080/0709/adm_loginck.jsp","id","admin","pw","1111");
	ret=goXML("http://192.168.23.110:8080/0709/adm_allview.jsp");
	
	String ret2 = goLogin("http://192.168.23.105:8080/VB_Ubuntu/jsp/chapter9_resort/admin/login_check.jsp", "id", "id", "pw", "pw");
    ret2 = goXML("http://192.168.23.105:8080/VB_Ubuntu/jsp/chapter9_resort/admin/reserve_list.jsp");	//별자리조트
		
	String ret3 = goLogin("http://35.190.225.81:8080/WebServer/Lecture11_Practice_Resort/Admin/adm_loginck.jsp", "id", "admin", "passwd", "admin");
	ret3 = goXML("http://35.190.225.81:8080/WebServer/Lecture11_Practice_Resort/Admin/adm_allview.jsp");	 //고부리조트
	
	String ret4 = goLogin("http://192.168.23.94:8080/0709_resort/adm_login_ck.jsp","id","admin","passwd","adad");
	ret4 = goXML("http://192.168.23.94:8080/0709_resort/d_01.jsp"); //해파리조트
	
	String ret5 = goLogin("http://192.168.23.92:8080/190709HomePage/adm_loginck.jsp", "id", "admin", "passwd", "1111");
	ret5 = goXML("http://192.168.23.92:8080/190709HomePage/adm_allview.jsp"); //항아리조트
	
	String ret6=goLogin("http://tarae.tk:8080/web/chap9/index.jsp?pageValue=adm_login.jsp&jump=main.jsp", "inputEmail", "giosun2", "inputPassword", "940926");
	ret6 = goXML("http://tarae.tk:8080/web/chap9/index.jsp?pageValue=adm_allview.jsp");	//????
	
	int cnt = 0;
	Pattern p = Pattern.compile("예약가능");
	Matcher m = p.matcher(ret);
	while (m.find()) {
		cnt++;
	}
	
	int cnt2 = 0;
	Pattern p2 = Pattern.compile("예약가능");
	Matcher m2 = p2.matcher(ret2);
	while (m2.find()) {
		cnt2++;
	}
	
	int cnt3 = 0;
	Pattern p3 = Pattern.compile("예약가능");
	Matcher m3 = p3.matcher(ret3);
	while (m3.find()) {
		cnt3++;
	}
	
	int cnt4 = 0;
	Pattern p4 = Pattern.compile("예약가능");
	Matcher m4 = p4.matcher(ret4);
	while (m4.find()) {
		cnt4++;
	}
	
	int cnt5 = 0;
	Pattern p5 = Pattern.compile("예약가능");
	Matcher m5 = p5.matcher(ret5);
	while (m5.find()) {
		cnt5++;
	}
	
	int cnt6 = 0;
	Pattern p6 = Pattern.compile("예약가능");
	Matcher m6 = p6.matcher(ret6);
	while (m6.find()) {
		cnt6++;
	}
	
	SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	Calendar cal = Calendar.getInstance();
%>
<table border=1>
<tr><th>리조트명</th><th>빈방</th><th>조회시간</th></tr>
<%
	out.println("<tr>");
	out.println("<td>개구리조트</td>");
	out.println("<td>"+cnt+"</td>");
	out.println("<td>"+dformat.format(cal.getTime())+"</td>");
	out.println("</tr>");

	out.println("<tr>");
	out.println("<td>별자리조트</td>");
	out.println("<td>"+cnt2+"</td>");
	out.println("<td>"+dformat.format(cal.getTime())+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td>고부리조트</td>");
	out.println("<td>"+cnt3+"</td>");
	out.println("<td>"+dformat.format(cal.getTime())+"</td>");
	out.println("</tr>");

	out.println("<tr>");
	out.println("<td>해파리조트</td>");
	out.println("<td>"+cnt4+"</td>");
	out.println("<td>"+dformat.format(cal.getTime())+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td>항아리조트</td>");
	out.println("<td>"+cnt5+"</td>");
	out.println("<td>"+dformat.format(cal.getTime())+"</td>");
	out.println("</tr>");
	
	out.println("<tr>");
	out.println("<td>noname리조트</td>");
	out.println("<td>"+cnt6+"</td>");
	out.println("<td>"+dformat.format(cal.getTime())+"</td>");
	out.println("</tr>");
%>
</table>
</center>
<script>
var timer = setInterval('refresh_start()', <%=iauto%>);
</script>
</body>
</html>