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
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<style>
th {
	background-color:#005f5f;
	color:white;
}
</style>
</head>
<body style="text-align:center;">
<h1>날씨</h1>
<%

	try {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse("http://www.kma.go.kr/wid/queryDFS.jsp?gridx=61&gridy=123");


		String seq="";
		String hour="";
		String day="";
		String temp="";
		String tmx="";
		String tmn="";
		String sky="";
		String pty="";
		String wfKor="";
		String wfEn="";
		String pop="";
		String r12="";
		String s12="";
		String ws="";
		String wd="";
		String wdKor="";
		String wdEn="";
		String reh="";
		String r06="";
		String s06="";
		
		
		out.println("<table class='table table-sm'>");
		out.println("<tr>");
		//out.println("<th>seq</th>");
		out.println("<th>시간</th>");	//hour
		//out.println("<th>day</th>");
		out.println("<th>기온</th>");	//temp
		out.println("<th>최고온도</th>");	//tmx
		out.println("<th>최저온도</th>");	//tmn
		//out.println("<th>하늘상태</th>");	//sky
		//out.println("<th>강수상태</th>");	//pyt
		out.println("<th>날씨</th>");		//wfKor
		//out.println("<th>날씨(En)</th>");	//wfEng
		out.println("<th>강수확률</th>");	//pop
		out.println("<th>12시간<br>예상강수량</th>");		//r12
		out.println("<th>12시간<br>예상적설량</th>");		//s12
		out.println("<th>풍속</th>");			//ws
		//out.println("<th>풍향(num)</th>");			//wd
		out.println("<th>풍향</th>");		//wdKor
		//out.println("<th>풍향(En)</th>");		//wdEn
		out.println("<th>습도</th>");		//reh
		out.println("<th>6시간<br>예상강수량</th>");		//r06
		out.println("<th>6시간<br>예상적설량</th>");		//s06
		out.println("<tr>");
		
		Element root = doc.getDocumentElement();
		NodeList tag_001 = doc.getElementsByTagName("data");
		
		for(int i=0; i<tag_001.getLength(); i++) {
			Element elmt = (Element)tag_001.item(i);
			
			seq=tag_001.item(i).getAttributes().getNamedItem("seq").getNodeValue();
			hour=elmt.getElementsByTagName("hour").item(0).getFirstChild().getNodeValue();
			day=elmt.getElementsByTagName("day").item(0).getFirstChild().getNodeValue();
			temp=elmt.getElementsByTagName("temp").item(0).getFirstChild().getNodeValue();
			tmx=elmt.getElementsByTagName("tmx").item(0).getFirstChild().getNodeValue();
			tmn=elmt.getElementsByTagName("tmn").item(0).getFirstChild().getNodeValue();
			sky=elmt.getElementsByTagName("sky").item(0).getFirstChild().getNodeValue();
			pty=elmt.getElementsByTagName("pty").item(0).getFirstChild().getNodeValue();
			wfKor=elmt.getElementsByTagName("wfKor").item(0).getFirstChild().getNodeValue();
			wfEn=elmt.getElementsByTagName("wfEn").item(0).getFirstChild().getNodeValue();
			pop=elmt.getElementsByTagName("pop").item(0).getFirstChild().getNodeValue();
			r12=elmt.getElementsByTagName("r12").item(0).getFirstChild().getNodeValue();
			s12=elmt.getElementsByTagName("s12").item(0).getFirstChild().getNodeValue();
			ws=elmt.getElementsByTagName("ws").item(0).getFirstChild().getNodeValue();
			wd=elmt.getElementsByTagName("wd").item(0).getFirstChild().getNodeValue();
			wdKor=elmt.getElementsByTagName("wdKor").item(0).getFirstChild().getNodeValue();
			wdEn=elmt.getElementsByTagName("wdEn").item(0).getFirstChild().getNodeValue();
			reh=elmt.getElementsByTagName("reh").item(0).getFirstChild().getNodeValue();
			r06=elmt.getElementsByTagName("r06").item(0).getFirstChild().getNodeValue();
			s06=elmt.getElementsByTagName("s06").item(0).getFirstChild().getNodeValue();
			
			switch(wfKor){
				case "맑음":
					if(Integer.parseInt(hour) < 7 || Integer.parseInt(hour) > 19) {
						wfKor = "<img src='icon/clear_n.png'>";
					} else {
						wfKor = "<img src='icon/clear.png'>";
					}
					break;
				case "구름 조금":
					if(Integer.parseInt(hour) < 7 || Integer.parseInt(hour) > 19) {
						wfKor = "<img src='icon/partlycloudy_n.png'>";
					} else {
						wfKor = "<img src='icon/partlycloudy.png'>";
					}
					break;
				case "구름 많음":
					if(Integer.parseInt(hour) < 7 || Integer.parseInt(hour) > 19) {
						wfKor = "<img src='icon/mostlycloudy_n.png'>";
					} else {
						wfKor = "<img src='icon/mostlycloudy.png'>";
					}
					break;
				case "흐림":
					wfKor = "<img src='icon/cloudy.png'>";
					break;
				case "비":
					wfKor = "<img src='icon/rainy.png'>";
					break;
				case "눈/비":
					wfKor = "<img src='icon/rainsnow.png'>";
					break;
				case "눈":
					wfKor = "<img src='icon/snowy.png'>";
					break;
			}
			
			if(Double.parseDouble(tmx) < -273) tmx = "-";
			if(Double.parseDouble(tmn) < -273) tmn = "-";
			
			switch(day){
				case "0":
					hour = "오늘 " + hour + "시";
					break;
				case "1":
					hour = "내일 " + hour + "시";
					break;
				case "2":
					hour = "모레 " + hour + "시";
					break;
			}
			
			switch(sky){
				case "1":
					sky = "맑음";
					break;
				case "2":
					sky = "구름조금";
					break;
				case "3":
					sky = "구름많음";
					break;
				case "4":
					sky = "흐림";
					break;
			}
			
			switch(pty){
				case "0":
					pty = "없음";
					break;
				case "1":
					pty = "비";
					break;
				case "2":
					pty = "비/눈";
					break;
				case "3":
					pty = "눈/비";
					break;
				case "4":
					pty = "눈";
					break;
			}
			
			switch(wdKor) {
				case "동":
					wdKor = "<img src='icon/east.png'>";
					break;
				case "서":
					wdKor = "<img src='icon/west.png'>";
					break;
				case "남":
					wdKor = "<img src='icon/south.png'>";
					break;
				case "북":
					wdKor = "<img src='icon/north.png'>";
					break;
				case "북동":
					wdKor = "<img src='icon/northeast.png'>";
					break;
				case "북서":
					wdKor = "<img src='icon/northwest.png'>";
					break;
				case "남동":
					wdKor = "<img src='icon/southeast.png'>";
					break;
				case "남서":
					wdKor = "<img src='icon/southwest.png'>";
					break;
			}
			
			out.println("<tr>");
			//out.println("<td>"+seq+"</td>");
			out.println("<td>"+hour+"</td>");
			//out.println("<td>"+day+"</td>");
			out.println("<td>"+temp+" ℃</td>");
			out.println("<td>"+tmx+" ℃</td>");
			out.println("<td>"+tmn+" ℃</td>");
			//out.println("<td>"+sky+"</td>");
			//out.println("<td>"+pty+"</td>");
			out.println("<td>"+wfKor+"</td>");
			//out.println("<td>"+wfEn+"</td>");
			out.println("<td>"+pop+" %</td>");
			out.println("<td>"+r12+" mm</td>");
			out.println("<td>"+s12+" mm</td>");
			out.println("<td>"+String.format("%.1f", Double.parseDouble(ws))+" m/s</td>");
			//out.println("<td>"+wd+"</td>");
			out.println("<td>"+wdKor+"</td>");
			//out.println("<td>"+wdEn+"</td>");
			out.println("<td>"+reh+" %</td>");
			out.println("<td>"+r06+" mm</td>");
			out.println("<td>"+s06+" mm</td>");
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