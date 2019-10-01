<%@ page errorPage="error.jsp" import="java.io.*"
 contentType="text/html; charset=UTF-8" %>
<%
	String fromTemp = request.getParameter("from");
	String cntTemp = request.getParameter("cnt");		//get방식으로 숫자 수신
%>
<HTML>
<HEAD>
<%
File f = new File("/var/lib/tomcat8/webapps/ROOT/0531/전국무료와이파이표준데이터.txt");
BufferedReader br = new BufferedReader(new FileReader(f));		//파일 입력, 절대경로로 지정

String readtxt = "";

//한줄을 먼저 읽어야 필드명을 알 수 있다.
if((readtxt=br.readLine())==null) {
out.println("빈 파일입니다");	//빈 파일일 경우
return;
}
	
String[] field_name = readtxt.split("\t");	//필드명을 탭에 따라 나눠준다

//융합기술 우리집 위도경도, 지도에서 알아보기
double lat = 37.3860521;
double lng = 127.1214038;

int fromPT = Integer.parseInt(fromTemp);		//int형으로는 받을수 없어서
int cntPT = Integer.parseInt(cntTemp);			//String형으로 받은 뒤 변환해주었다

int LineCnt=0;	//줄수 카운트
out.println("<TABLE border=1>");			//out.printf는 동작하지 않았다
	out.println("<TR align=center>");
	out.println("<TD>" +"번호"+ "</TD>");
	out.println("<TD>" +field_name[9]+ "</TD>");
	out.println("<TD>" +field_name[12]+ "</TD>");
	out.println("<TD>" +field_name[13]+ "</TD>");
	out.println("<TD>" +"거리"+ "</TD>");			//표 상단
	out.println("</TR>");
while((readtxt=br.readLine()) != null) {
	LineCnt++;
	if(LineCnt < fromPT) continue;			//표의 시작위치까지 continue하고
	if(LineCnt > fromPT+cntPT) break;		//cnt만큼 출력 뒤 break로 테이블 닫아준다
	String[] field = readtxt.split("\t");	//필드를 탭에 따라 나눠준다
	double dist=Math.sqrt(Math.pow(Double.parseDouble(field[12])-lat,2) 
		+ Math.pow(Double.parseDouble(field[13])-lng,2));	//거리계산
	out.println("<TR>");
	out.println("<TD align=center>" +LineCnt+ "</TD>");
	out.println("<TD>" +field[9]+ "</TD>");
	out.println("<TD>" +field[12]+ "</TD>");
	out.println("<TD>" +field[13]+ "</TD>");
	out.println("<TD>" +dist+ "</TD>");				//표 value값들
	out.println("</TR>");
}
out.println("</TABLE>");
br.close();
%>
</HEAD>
<BODY>
</BODY>
</HTML>