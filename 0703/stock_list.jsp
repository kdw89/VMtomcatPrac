<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<html>
<head>
<%
	String pageNum = request.getParameter("pageNum");		//페이지 넘버
	int currentPage = 1;
%>
<link type="text/css" rel="stylesheet" href="bootstrap.css">		<!--부트스트랩 사용-->
<script>
	function fnc(value, min, max) 			//숫자 최소, 최대값
	{
		if(parseInt(value) < min || isNaN(value)) 
			return min; 
		else if(parseInt(value) > max) 
			return null; 
		else return value;
	}</script>
<style>
#fixed{
	position:fixed;
	bottom:3%;
	right:3%;			/*브라우저 우하단에 고정*/
	width:fixed;
	padding:5px;
	color:white;
}
.ellipsis {
  text-overflow: ellipsis;
	width:100%;
  white-space: nowrap;
  overflow: hidden;
}
</style>
</head>
<body onload="document.search.reset();">		<!--페이지 불러오면 검색창 비운다-->
<center>
<h1><b>㈜트와이스 재고 현황 -전체현황</b></h1><br>
<form name="search" action='stock_view.jsp' method='POST' class="form-inline" autocomplete="off">
	<input type=number name=key class="form-control" min=1 style="font-size: 2em; width:60%; height:2em;" onkeyup='this.value = fnc(this.value, 1, 99999999999999)' autofocus>
	<input type=submit value="검색" class="btn btn-primary btn-lg" style="font-size: 3em;">			<!--검색창에 숫자 제한-->
</form>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	ResultSet rset2 = stmt.executeQuery("SELECT count(*) from stock");
	rset2.next();
	int total = rset2.getInt(1);
	
	if(pageNum != null)	{
		try{
			currentPage = Integer.parseInt(pageNum);
		} catch(Exception e) {
			out.println("<script>alert('잘못된 접근입니다.'); location.href='stock_list.jsp';</script>");
		}
	}
	if(currentPage < 1) currentPage = 1;
	if(currentPage > (total-1)/20+1) {
		out.println("<script>alert('잘못된 접근입니다.'); location.href='stock_list.jsp';</script>");	//페이지 넘버 잘못 사용시
	}
	int pageListStart = ((currentPage-1)/10)*10+1;		//리스트 시작점
	
	PreparedStatement pstmt = null;
	String sql = "SELECT id, product, inven, take_inven, product_regist from stock order by take_inven desc limit ?, 20";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,((20*currentPage)-20));
	ResultSet rset = pstmt.executeQuery();
	
%>
<table class="table table-hover" style="font-size:2em; table-layout:fixed">		<!--꽉찬 테이블-->
<tr>
<td width=15%><p align=center>상품번호</p></td>
<td ><p align=center>상품명</p></td>
<td width=10%><p align=center>현재 재고수</p></td>
<td width=10%><p align=center>재고파악일</p></td>
<td width=10%><p align=center>상품등록일</p></td>
</tr>
<%
	while (rset.next()) {
		%> <tr onClick=location.href="stock_view.jsp?key=<%=rset.getLong(1)%>">
<%
		out.println("<td><p align=center class='ellipsis'>"+rset.getLong(1)+"</p></td>");
		out.println("<td><p align=center class='ellipsis'><a href='stock_view.jsp?key="+rset.getLong(1)+"'>"
													+rset.getString(2)+"</p></td>");
		out.println("<td><p align=center class='ellipsis'>"+rset.getInt(3)+"</p></td>");
		out.println("<td><p align=center class='ellipsis'>"+rset.getDate(4)+"</p></td>");
		out.println("<td><p align=center class='ellipsis'>"+rset.getDate(5)+"</p></td>");
		out.println("</tr>");
	}
	rset2.close();
	rset.close();
	pstmt.close();
	stmt.close();
	conn.close();
%>
</table>
<%
if (pageListStart != 1) {			//1페이지가 포함되었을땐 <<, <가 나타나지 않는다
	out.println("<a href=stock_list.jsp?pageNum="+1+" class='btn' style='font-size:2em'>&lt;&lt;</a>");	//맨 앞으로
	out.println("<a href=stock_list.jsp?pageNum="+(pageListStart-1)+" class='btn' style='font-size:2em'>&lt;</a>");		//10페이지 전으로
}
for(int i=pageListStart; i<pageListStart+10; i++){		//10개 페이지 링크 출력, 페이지번호와 시작 번호를 매칭...수열
	if((20*pageListStart+(i-pageListStart-1)*20) >= total) break;		//총량을 벗어날 경우 페이지 링크를 더 표시하지 않는다
	if(i == currentPage)	out.println("<a href=stock_list.jsp?pageNum="+(i)+" class='btn btn-success' style='font-size:2em'><b>"+(i)+"</b></a>");
	else	out.println("<a href=stock_list.jsp?pageNum="+(i)+" class='btn btn-info' style='font-size:2em'>"+(i)+"</a>");

}
if (20*pageListStart < total-180) {		//마지막 페이지에서는 >, >>가 안나타나도록
	out.println("<a href=stock_list.jsp?pageNum="+(pageListStart+10)+" class='btn' style='font-size:2em'>&gt;</a>");		//10페이지 뒤로
	if(total%20 == 0) out.println("<a href=stock_list.jsp?pageNum="+(total/20)+" class='btn' style='font-size:2em'>&gt;&gt;</a><br>");
	else out.println("<a href=stock_list.jsp?pageNum="+(total/20+1)+" class='btn' style='font-size:2em'>&gt;&gt;</a><br>");	//마지막 페이지로
}

%><br><br><br>
<div id=fixed><input type=button class="btn btn-primary btn-lg" style="font-size:5em" value="신규" OnClick="window.location='stock_insert.jsp'"></div>

</center>
</body>
</html>