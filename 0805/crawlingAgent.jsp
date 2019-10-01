<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*,java.net.*,java.lang.*, java.util.Date" %>
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
	HttpConnectionParams.setConnectionTimeout(client.getParams(), 1000);
	HttpConnectionParams.setSoTimeout(client.getParams(), 1000);
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

public int crawlServer(int server_num) {
	
	String sql = "";
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
		//Statement stmt = conn.createStatement();

		sql = "select login_url, uName, uValue, pName, pValue, adm_allview_url from resort_room where server_num=? and last_proc_flag=0";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,server_num);
		ResultSet rset = pstmt.executeQuery();
		if(rset.next()) {
			String ret = goLogin(rset.getString(1), rset.getString(2), rset.getString(3), rset.getString(4), rset.getString(5));
			ret = goXML(rset.getString(6));
			int cnt = 0;
			Pattern p = Pattern.compile("예약가능");
			Matcher m = p.matcher(ret);
			while (m.find()) {
				cnt++;
			}
			sql = "update resort_room set empty_room=?, last_req_time=now(2), last_proc_flag=1 where server_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,cnt);
			pstmt.setInt(2, server_num);
			pstmt.execute();
			pstmt.close();
			conn.close();
			return cnt;
		}
	} catch (Exception e) {
		try {
			conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
			sql = "update resort_room set last_proc_flag=? where server_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 0);
			pstmt.setInt(2, server_num);
			pstmt.execute();
			pstmt.close();
			conn.close();
			return 0;
		} catch (Exception f) {
			return 0;
		}
	}
	return 0;
}

%>
<%
	int iauto=10000;
	String s_url="crawlingAgent.jsp";
	
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
	String sql = "";
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	
	sql = "select last_proc_flag from resort_room";
	pstmt = conn.prepareStatement(sql);
	ResultSet rset = pstmt.executeQuery();
	int server_cnt = 0;
	while(rset.next()) {
		if(rset.getInt(1) == 1) server_cnt++;
	}
	
	if(server_cnt == 6) {
		sql = "update resort_room set last_proc_flag=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, 0);
		pstmt.execute();
	}
	
	long first = System.currentTimeMillis();
	
	for(int i=1; i<=6; i++) {
		out.println(crawlServer(i));
	}
	
	
	long second = System.currentTimeMillis();
	long diff = second - first;
	
	
	out.println("<time>"+diff/1000.0 + "초</time>");
	ServletContext c_time = this.getServletContext();
	c_time.setAttribute("time",diff/1000.0);
	conn.close();
	pstmt.close();
%>
<script>
var timer = setInterval('refresh_start()', <%=iauto%>);
</script>
</body>
</html>