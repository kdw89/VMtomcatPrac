<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<html>
<head>
<meta charset="utf-8">
<title>탑 메뉴</title>
<style type='text/css'>
td { font-size:20; text-align:center; }
b { font-size:20; text-align:center; }
a:link { text-decoration:none; }
a:visited { text-decoration:none; }
a:hover { text-decoration:none; }
a:active { text-decoration:none; }
body {
background-image:url('/0709/image/frame.png');
background-repeat:no-repeat;
background-size:100% 100%;
}
span { font-weight: 900;
	color: #000000;}
	
#fixed{
	position:fixed;
	top:0%;
	right:0%;
	width:fixed;
	padding:5px;
	color:black;
}
</style>
<script language='javascript' type='text/javascript'>
var muCnt = 5;

function fncShow(pos){
	var i = 0;
	for(i; i<muCnt; i++) {
		var obj = document.getElementById("menu" + i);
		var img = "/0709/btn/m" + i;
		if(i ==  pos) {
			obj.style.display = '';
			document.getElementById('m'+i).src=img+'1.png';
		}else{
			obj.style.display = 'none';
			document.getElementById('m'+i).src=img+'0.png';
		}
	}
}
function fncHide(pos){
	var obj = document.getElementById("menu"+pos);
	obj.style.display = 'none';
}
</script>
</head>
<body>

<center>
<table cellpadding = '0' cellspacing = '1' border = '0' width='850'>
<td width=300><a href='main.jsp' target='main'><img src='/0709/logo.png' width='280' height='120' border='0'></a>
</td>
<td>
<table cellpadding='0' cellspacing='1' border='0' width='800' height='50'>
	<tr height='50'>
		<td width='150' onmouseover='fncShow(0);' ><img id='m0' src="/0709/btn/m00.png"></td>
		<td width='150' onmouseover='fncShow(1);' ><img id='m1' src="/0709/btn/m10.png"></td>
		<td width='150' onmouseover='fncShow(2);' ><img id='m2' src="/0709/btn/m20.png"></td>
		<td width='150' onmouseover='fncShow(3);' ><img id='m3' src="/0709/btn/m30.png"></td>
		<td width='150' onmouseover='fncShow(4);' ><img id='m4' src="/0709/btn/m40.png"></td>			<!--이미지 메뉴-->
	</tr>
<tr height='30'>
<td colspan='6'>
 <table id='menu0' style='display:none;' height='30'>
  <tr>
      <td width='20' ></td>
      <td width='600' style='text-align:left;' >
           |<a href='main.jsp' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 개구리조트 </span>
           </a>
           |<a href='a_01.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> VIP룸 </span>
           </a>
           |<a href='a_02.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 일반룸 </span>
           </a>
           |<a href='a_03.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 합리적인룸 </span> <!--글자 메뉴-->
           </a>|
        </td>
    </tr>
</table>
 <table id='menu1' style='display:none;' height='30'>
  <tr>
      <td width='100' ></td>
      <td width='500' style='text-align:left;' >
           |<a href='b_01.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 찾아오는 길 </span>
           </a>
           |<a href='b_02.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 대중교통 </span>
           </a>
           |<a href='b_03.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 자가용이용 </span>
           </a>|
        </td>
    </tr>
</table>
 <table id='menu2' style='display:none;' height='30'>
  <tr>
      <td width='250' ></td>
      <td width='400' style='text-align:left;' >
           |<a href='c_01.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 개구리마을 </span>
           </a>
           |<a href='c_02.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 중앙공원 </span>
           </a>
           |<a href='c_03.html' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 남한산성 </span>
           </a>|
        </td>
    </tr>
</table>
 <table id='menu3' style='display:none;'  height='30'>
  <tr>
      <td width='950' ></td>
      <td width='600' style='text-align:left;' >
           |<a href='d_01.jsp' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 예약상황 </span>
           </a>
           |<a href='d_02.jsp' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 예약하기 </span>
           </a>
           |<!--<a href='adm/adm_allview.jsp' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 관리자페이지 </span>
           </a>
           |<a href='adm/adm_logout.jsp' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 관리자로그아웃 </span>
           </a>|-->
        </td>
    </tr>
</table>
 <table id='menu4' style='display:none;' height='30'>
  <tr>
      <td width='790' ></td>
      <td width='250' style='text-align:left;' >
           |<a href='gongji/gongji_list.jsp' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 리조트소식 </span>
           </a>
           |<a href='review/review_list.jsp' target=main>
           <span onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000'> 이용후기  </span>
           </a>|
        </td>
    </tr>
</table>
</td></table></table>
<%
	String loginOK=null;
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null) {
		out.println("<span id=fixed><a href='adm_allview.jsp' style='color:black;' onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000' target=main>administrator</a></span>");
		return;
	}
	else if(!loginOK.equals("yes")) {
		out.println("<span id=fixed><a href='adm_allview.jsp' style='color:black;' onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000' target=main>administrator</a></span>");
		return;
	} else {
		out.println("<span id=fixed><a href='adm_allview.jsp' style='color:black;' onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000' target=main>administrator</a><br>"+
					"<a href='adm_logout.jsp' style='color:black;' onmouseover=this.style.color='#ff0000' onmouseout=this.style.color='#000000' target=main>logout</a></span>");
	}
	
%>
</body>
</html>