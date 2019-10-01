<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*,java.util.Date" %>
<%@ page errorPage="error.jsp" %>
<html>

<head>
<%
	String resv_date = request.getParameter("resv_date");
	String room = request.getParameter("room");
	if(room == null) room = "";
	
	
	String loginOK=null;
	String jumpURL="adm_login.jsp?jump=adm_allview.jsp";
	
	loginOK = (String)session.getAttribute("login_ok");
	if(loginOK==null) {
		response.sendRedirect(jumpURL);
		return;
	}
	if(!loginOK.equals("yes")) {
		response.sendRedirect(jumpURL);
		return;
	}
%>

<script type="text/javascript">

function checkDate(){
	var today = new Date();
	today.setHours(9,0,0,0);
	var roomdate = document.getElementById("date").valueAsDate;
	console.log(today);
	console.log(roomdate);
	var dayafter30 = new Date();
	dayafter30 = dayafter30.setDate(today.getDate() + 29);
	var result = roomdate < today;
	if(roomdate < today) { 
		if(document.getElementById("date").value != "")	alert('오늘 이전 날짜는 입력이 불가능합니다.'); 
		document.getElementById("date").value = "";
	}
	if(roomdate >= dayafter30) { 
		alert('30일 이후 날짜는 입력이 불가능합니다.'); 
		document.getElementById("date").value = "";
	}
}

  function characterCheck() {
            var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식 구문
            var obj = document.getElementsByName("name")[0];
            if (RegExp.test(obj.value)) {
                alert("이름에 특수문자는 입력하실 수 없습니다.");
                obj.value = obj.value.substring(0, obj.value.length - 1);//특수문자를 지우는 구문
            }
        }

</script>

<style>
.text_border {
	text-shadow: -1px 0 #000000, 0 1px #000000, 1px 0 #000000, 0 -1px #000000;
}
#fixed{
	position:fixed;
	bottom:0%;
	right:0%;			/*브라우저 우하단에 고정*/
	width:fixed;
	padding:5px;
	color:white;
}

td {
	padding:5px
}
.outline{
	background-color: #ffffff;
	width: 1000px;
	padding:20px;
	border-radius:20px;
	border: 5px solid gold;	
}
</style>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<%

SimpleDateFormat dformat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREAN);
Date today = new Date();
String today_chk = dformat.format(today);

Calendar cal = Calendar.getInstance();
cal.add(cal.DATE,+29);
String after30days = dformat.format(cal.getTime());

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	Statement stmt = conn.createStatement();
	
	ResultSet rset = stmt.executeQuery("select name, addr, telnum, id_name, comment, write_date, processing from resv where resv_date='"+resv_date+"' and room="+room);
	
	String name = "";
	String addr = "";
	String telnum = "";
	String id_name = "";
	String comment = "";
	String write_date = "";
	int processing = 0;
	
	if(rset.next()) {
		name = rset.getString(1);
		addr = rset.getString(2);
		telnum = rset.getString(3);
		id_name = rset.getString(4);
		comment = rset.getString(5);
		write_date = rset.getString(6);
		processing = rset.getInt(7);
	}

%>
</head>
<body background='/0709/background.jpg'>
<br>
<center>

<div class='outline' >
<h3>예약하기</h3>
<form METHOD=POST name='fm' autocomplete='off'>
<table style="width:800px" class="table table-sm">
<tr><td width=100>성명</td>

<td width=700><input type=text name="name" value='<%=name%>' maxlength='20' style="font-size: large; width:600px; height:40px;" onpaste="javascript:return false;" onkeyup="characterCheck()" onkeydown="characterCheck()" required></td>

</tr>
<tr><td>예약일자</td>

<td><input type=date id="date" name="resv_date" style="font-size: large; width:300px; height:40px;" 
						min='<%=today_chk%>' max='<%=after30days%>' onchange="return checkDate();" value='<%=resv_date%>' readonly required></td>

</tr>
<tr><td>예약방</td>

<td><select style="font-size:large; text-align:center; width:200px; height:40px;" disabled required>
		<option value="">방 종류</option>
		<option value="1" <%if(room.equals("1")) out.println("selected");%> >VIP 룸</option>
		<option value="2" <%if(room.equals("2")) out.println("selected");%> >일반 룸</option>
		<option value="3" <%if(room.equals("3")) out.println("selected");%> >합리적인룸</option>
		</select><input type="hidden" name="room" id="room" value="<%=room%>"></td>

</tr>
<tr><td>주소</td>

<td><input type=text name="addr" value='<%=addr%>' style="font-size: large; width:600px; height:40px;" required></td>

</tr>
<tr><td>전화번호</td>

<td><input type=text name="telnum" id="telnum" value='<%=telnum%>' maxlength="13" style="font-size: large; width:300px; height:40px;" required></td>

</tr>
<tr><td>입금자명</td>

<td><input type=text name="id_name" value='<%=id_name%>' style="font-size: large; width:600px; height:40px;" required></td>

</tr>
<tr><td>남기실말</td>

<td><input type=text name="comment" value='<%=comment%>' style="font-size: large; width:600px; height:40px;" required></td>

</tr>
<tr><td>접수일자</td>

<td><input type=text name="write_date" value='<%=write_date%>' style="font-size: large; width:600px; height:40px;" readonly required></td>

</tr>
<tr><td>진행상황</td>

<td><select name="processing" style="font-size:large; text-align:center; width:200px; height:40px;" required>
		<option value="">진행상황</option>
		<option value="1" <%if(processing == 1) out.println("selected");%> >예약완료</option>
		<option value="2" <%if(processing == 2) out.println("selected");%> >입금완료</option>
		<option value="3" <%if(processing == 3) out.println("selected");%> >환불요청</option>
		</select></td>

</tr>
<tr style='text-align:center'>
<td colspan=2>
<a style="font-size: large; text-align:center; height:40px;" class="btn btn-primary btn-lg" href="adm_allview.jsp">관리자페이지</a>
<input style="font-size: large; text-align:center; width:100px; height:40px;" class="btn btn-success btn-lg" type="submit" formaction="adm_update.jsp" value="수정">
<input style="font-size: large; text-align:center; width:100px; height:40px;" class="btn btn-danger btn-lg" type="submit" formaction="adm_delete.jsp" value="삭제"></td>
</tr>
</table>
</div>
<script>
      function autoHypenPhone(str) {
  str = str.replace(/[^0-9]/g, '');
  var tmp = '';
  if (str.length < 4) {
    return str;
  } else if (str.length < 7) {
    tmp += str.substr(0, 3);
    tmp += '-';
    tmp += str.substr(3);
    return tmp;
  } else if (str.length < 11) {
    tmp += str.substr(0, 3);
    tmp += '-';
    tmp += str.substr(3, 3);
    tmp += '-';
    tmp += str.substr(6);
    return tmp;
  } else {
    tmp += str.substr(0, 3);
    tmp += '-';
    tmp += str.substr(3, 4);
    tmp += '-';
    tmp += str.substr(7);
    return tmp;
  }
  return str;
}

var cellPhone = document.getElementById('telnum');
cellPhone.oninput = function (event) {
  event = event || window.event;
  var _val = this.value.trim();
  this.value = autoHypenPhone(_val);
};
</script>
</form>
</center>
</body>
</html>