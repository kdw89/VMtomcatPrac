<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*, java.util.Date" %>
<HTML>
<HEAD>
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
	width: 500px;
	padding:20px;
	border-radius:20px;
	border: 5px solid gold;	
}
</style>
<script>
  function characterCheck() {
            var RegExp = /[ \{\}\[\]\/?.,;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=]/gi;//정규식 구문
            var obj = document.getElementsByName("id")[0]
            if (RegExp.test(obj.value)) {
                alert("특수문자는 입력하실 수 없습니다.");
                obj.value = obj.value.substring(0, obj.value.length - 1);//특수문자를 지우는 구문
            }
        }
		
		
function submitForm(mode){
	if(mode == "write"){
		fm.action = "adm_loginck.jsp";
		fm.submit();
	}
}
</script>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
</HEAD>
<BODY background='background.jpg'>
<%
	String jump = request.getParameter("jump");
%>
<center>
<br>
<div class='outline' >
<img src='admlogin.png'>
<form method="post" name='fm' >
<table class='table'>
	<tr>
		<td align=center width=200>아이디</td>
		<td><input type="text" name="id" onpaste="javascript:return false;" onkeyup="characterCheck()" onkeydown="characterCheck()" required></td>
	</tr>
	<tr>
		<td align=center width=200>비밀번호</td>
		<td><input type="password" name="pw"  onpaste="javascript:return false;"></td>
	</tr>
	<tr>
		<td colspan=2 align=center><input type="button" class="btn btn-success btn-lg" value="전송" OnClick="submitForm('write')"></td>
	</tr>
</table>
<input type="hidden" name="jump" value='<%=jump%>'>
</form>
</div>
</center>

</BODY>
</HTML>