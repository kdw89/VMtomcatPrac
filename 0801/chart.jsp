<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*,java.net.*,java.lang.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>


<html>
<head>
</head>
<body>
<%

	JSONParser parser = new JSONParser();

 
	URL oracle = new URL("https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=k1e9kW482chvY8gw05YdMJOJguVf5cYJ&searchdate=20190722&data=AP01"); // URL to Parse
	URLConnection yc = oracle.openConnection();
	BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
	
	String inputLine;
	while ((inputLine = in.readLine()) != null) {               
		JSONArray a = (JSONArray) parser.parse(inputLine);

		for (Object o : a) {
			JSONObject tutorials = (JSONObject) o;

			String id = (String) tutorials.get("cur_unit");
			out.println("Post cur_unit : " + id + "<br>");

			String title = (String) tutorials.get("ttb");
			out.println("Post ttb : " + title + "<br>");
		}
	}
	in.close();

%>
</body>
</html>