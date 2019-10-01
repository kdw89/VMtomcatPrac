<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
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
<title>공사현황</title>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<style>
th {
	background-color:#005f5f;
	color:white;
}

/* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
</style>
</head>
<body style="text-align:center;">
<h1>공사현황</h1>

<%
	String LatLng = "";
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document doc = builder.parse("http://openapi.its.go.kr:8082/api/NEventIdentity?key=1498271446332&ReqType=2&MinX=127.100000&MaxX=128.890000&MinY=34.100000%20&MaxY=39.100000&type=its");
		
		Element root = doc.getDocumentElement();
		
		
		NodeList tag_type = doc.getElementsByTagName("type");
		NodeList tag_eventid = doc.getElementsByTagName("eventid");
		NodeList tag_eventtype = doc.getElementsByTagName("eventtype");		
		NodeList tag_coordx = doc.getElementsByTagName("coordx");
		NodeList tag_coordy = doc.getElementsByTagName("coordy");
		NodeList tag_lanesblocktype = doc.getElementsByTagName("lanesblocktype");
		NodeList tag_lanesblocked = doc.getElementsByTagName("lanesblocked");
		NodeList tag_eventstartday = doc.getElementsByTagName("eventstartday");
		NodeList tag_eventendday = doc.getElementsByTagName("eventendday");
		NodeList tag_eventstarttime = doc.getElementsByTagName("eventstarttime");
		NodeList tag_eventendtime = doc.getElementsByTagName("eventendtime");
		NodeList tag_eventstatusmsg = doc.getElementsByTagName("eventstatusmsg");
		NodeList tag_expectedcnt = doc.getElementsByTagName("expectedcnt");
		NodeList tag_expecteddetourmsg = doc.getElementsByTagName("expecteddetourmsg");
		NodeList tag_eventdirection = doc.getElementsByTagName("eventdirection");
		
		String type = "";
		String eventid = "";
		String eventtype = "";
		String coordx = "";
		String coordy = "";
		String lanesblocktype = "";
		String lanesblocked = "";
		String eventstartday = "";
		String eventendday = "";
		String eventstarttime = "";
		String eventendtime = "";
		String eventstatusmsg = "";
		String expectedcnt = "";
		String expecteddetourmsg = "";
		String eventdirection = "";
		
		String cluster = "";
		
%>
<form action='map.jsp' method='POST'>
<%
		out.println("<table class='table table-sm'>");
		out.println("<tr>");
		out.println("<th>번호</th>");	
		out.println("<th>도로정보</th>");	// type(its : 국도 / ex : 고속도로 / police : 경찰청)
		out.println("<th>공사 고유 식별번호</th>");
		out.println("<th>공사정보유형</th>");
		out.println("<th>경도좌표</th>");
		out.println("<th>위도좌표</th>");
		out.println("<th>공사로 인한 차로 차단 방법</th>");  // lanesblocktype ( 0 : 통제없음 / 1 : 갓길통제/ 2 : 차로부분통제 / 3 : 전면통제 )
		out.println("<th>공사로 인해 차단된 차로 수</th>");
		out.println("<th>공사 시작일</th>");
		out.println("<th>공사 종료일</th>");
		out.println("<th>공사 실제 개시 시간</th>");
		out.println("<th>공사 실제 종료 시간</th>");
		out.println("<th>공사 상황정보 메시지</th>");
		out.println("<th>우회정보개수</th>");
		out.println("<th>우회정보 메시지</th>");
		out.println("<th>진행방향</th>");
		out.println("<th>지도보기</th>");
		out.println("<tr>");
			
		for(int i=0; i<tag_eventid.getLength(); i++) {
			out.println("<tr>");
			out.println("<td>"+(i+1)+"</td>");
			
			if(tag_type.item(i).getFirstChild() == null) {}
			else type = tag_type.item(i).getFirstChild().getNodeValue();
			if(tag_eventid.item(i).getFirstChild() == null) {}
			else eventid = tag_eventid.item(i).getFirstChild().getNodeValue();
			if(tag_eventtype.item(i).getFirstChild() == null) {}
			else eventtype = tag_eventtype.item(i).getFirstChild().getNodeValue();
			if(tag_coordx.item(i).getFirstChild() == null) {}
			else coordx = tag_coordx.item(i).getFirstChild().getNodeValue();
			if(tag_coordy.item(i).getFirstChild() == null) {}
			else coordy = tag_coordy.item(i).getFirstChild().getNodeValue();
			if(tag_lanesblocktype.item(i).getFirstChild() == null) {}
			else lanesblocktype = tag_lanesblocktype.item(i).getFirstChild().getNodeValue();
			if(tag_lanesblocked.item(i).getFirstChild() == null) {}
			else lanesblocked = tag_lanesblocked.item(i).getFirstChild().getNodeValue();
			if(tag_eventstartday.item(i).getFirstChild() == null) {}
			else eventstartday = tag_eventstartday.item(i).getFirstChild().getNodeValue();
			if(tag_eventendday.item(i).getFirstChild() == null) {}
			else eventendday = tag_eventendday.item(i).getFirstChild().getNodeValue();
			if(tag_eventstarttime.item(i).getFirstChild() == null) {}
			else eventstarttime = tag_eventstarttime.item(i).getFirstChild().getNodeValue();
			if(tag_eventendtime.item(i).getFirstChild() == null) {}
			else eventendtime = tag_eventendtime.item(i).getFirstChild().getNodeValue();
			if(tag_eventstatusmsg.item(i).getFirstChild() == null) {}
			else eventstatusmsg = tag_eventstatusmsg.item(i).getFirstChild().getNodeValue();
			if(tag_expectedcnt.item(i).getFirstChild() == null) {}
			else expectedcnt = tag_expectedcnt.item(i).getFirstChild().getNodeValue();
			if(tag_expecteddetourmsg.item(i).getFirstChild() == null) {}
			else expecteddetourmsg = tag_expecteddetourmsg.item(i).getFirstChild().getNodeValue();
			if(tag_eventdirection.item(i).getFirstChild() == null) {}
			else eventdirection = tag_eventdirection.item(i).getFirstChild().getNodeValue();
			
			switch(type) {
				case "its":
					out.println("<td>국도</td>");
					break;
				case "ex":
					out.println("<td>고속도로</td>");
					break;
				case "police":
					out.println("<td>경찰청</td>");
					break;
				default :
					out.println("<td></td>");
					break;
			}
			out.println("<td>"+eventid+"</td>");
			out.println("<td>"+eventtype+"</td>");
			out.println("<td>"+coordx+"</td>");
			out.println("<td>"+coordy+"</td>");
			
			if(i == 0) cluster = cluster + "{lat: "+coordy+", lng: "+coordx+"}";
			else cluster = cluster + ",{lat: "+coordy+", lng: "+coordx+"}";
			
			switch(lanesblocktype) {
				case "0":
					out.println("<td>통제없음</td>");
					break;
				case "1":
					out.println("<td>갓길통제</td>");
					break;
				case "2":
					out.println("<td>차로부분통제</td>");
					break;
				case "3":
					out.println("<td>전면통제</td>");
					break;
				default : 
					out.println("<td></td>");
					break;
			}
			out.println("<td>"+lanesblocked+"</td>");
			out.println("<td>"+eventstartday+"</td>");
			out.println("<td>"+eventendday+"</td>");
			out.println("<td>"+eventstarttime+"</td>");
			out.println("<td>"+eventendtime+"</td>");
			out.println("<td>"+eventstatusmsg+"</td>");
			out.println("<td>"+expectedcnt+"</td>");
			out.println("<td>"+expecteddetourmsg+"</td>");
			out.println("<td>"+eventdirection+"</td>");
			out.println("<input type=hidden name=focus value='"+cluster+"'>");
			out.println("<td><a href='map.jsp?lat="+coordy+"&lng="+coordx+"' class='btn btn btn-primary' target='_blank'>지도보기</a></td>");
			out.println("</tr>");
		}
	out.println("<input type=hidden name=cluster value='"+cluster+"'>");
	out.println("<input type=submit class='btn btn btn-primary btn-lg' value='전체보기'>");
	out.println("</table>");
%>
</form>
</body>
</html>