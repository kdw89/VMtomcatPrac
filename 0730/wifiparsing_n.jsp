<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page import = "javax.xml.parsers.* ,org.w3c.dom.*, javax.xml.xpath.*, org.xml.sax.InputSource" %>
<!--xml파일을 읽어오기 위해서 위 xml과 w3c를 import하는 것이 반드시 필요합니다.-->
<html>
<head>
</head>
<body>
<h1 align=center>공공 와이파이 조회</h1>
<%
	//파싱을 위한 준비과정
	DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
	
	//파일을 읽을 때 서버 내부의 local path(전체경로적기)로 지정합니다.
	//이 문장이 xml을 파싱합니다. 이를 위해 위에서 임포트한 문장을 기억할 것!
	Document doc = docBuilder.parse(new File("/var/lib/tomcat8/webapps/ROOT/0730/wifi.xml"));
	//xml정규화
	doc.getDocumentElement().normalize();
	
	//XPath 생성, XPath는 XML 노드들을 CSS 다루듯이 쉽게 다루도록 도와주는 API 입니다.
	XPath xpath = XPathFactory.newInstance().newXPath();
	
	Element root = doc.getDocumentElement();	//root태그를 가져져오지만 여기서 쓰이는 곳은 없습니다.
	
	NodeList tag_local = doc.getElementsByTagName("소재지지번주소");	
	NodeList tag_local_new = doc.getElementsByTagName("소재지도로명주소");
	NodeList tag_lat = doc.getElementsByTagName("위도");	
	NodeList tag_lng = doc.getElementsByTagName("경도");	
		
    //테이블 형태로 데이터 출력
	out.println("<table cellspacing=1 width=700 border=1 align=center>");
	out.println("<tr>");
	out.println("<th width=50>순번</th>");
	out.println("<th width=450>소재지지번주소</th>");
	out.println("<th width=100>위도</th>");
	out.println("<th width=100>경도</th>");
	out.println("</tr>");
	
	for(int i = 0; i < tag_local.getLength(); i++){
		out.println("<tr>");
		out.println("<td align=center>"+i+"</td>");
		//실제 노드만 취급합니다.
		if(tag_local.item(i).getNodeType()!=Node.ELEMENT_NODE){
			continue;			
		}
		//데이터는 getTextContent() 메소드를 사용하든, getNodeValue() 메소드를 사용하든 출력 결과는 같습니다.
		//xml의 소재지지번주소 컬럼의 값이 null인 경우 읽어오다가 오류가 발생합니다.
		//이때 if문으로 제어가 되지 않아 try catch 를 통해 잡았습니다.
		//아래 내용은 소재지지번주소가 없을 경우 소재지도로명주소 컬럼값을 읽어오도록 한 것 입니다.
		try{
			out.println("<td>"+tag_local.item(i).getFirstChild().getTextContent()+"</td>");
		}catch(Exception e){
			out.println("<td>"+tag_local_new.item(i).getFirstChild().getTextContent()+"</td>");
		}
		out.println("<td align=center>"+tag_lat.item(i).getFirstChild().getTextContent()+"</td>");
		out.println("<td align=center>"+tag_lng.item(i).getFirstChild().getTextContent()+"</td>");
		out.println("</tr>");
	}
	
	out.println("</table>");
%>
</body>
</html>