<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.*, java.util.Date" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<%
	String loginOK=null;
	String jumpURL="hpd.gif";
	
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
<script src="https://cdn.ckeditor.com/4.12.1/basic/ckeditor.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src='jquery.MultiFile.js' type="text/javascript" language="javascript"></script>

<link type="text/css" rel="stylesheet" href="bootstrap.css">

<SCRIPT LANGUAGE="javaScript" type='text/javascript'>
function submitForm(mode){
	fm.action = "gongji_write.jsp?key=INSERT";
	var title = document.getElementById("title").value.trim();
	var editor_val = CKEDITOR.instances.content.getData();
    if(title == "") alert('제목을 입력하세요');
	else if(document.getElementById("title").value.length > 70) alert('70자 미만으로 제목을 써주세요.');
	else if (editor_val == '') {
		alert('내용을 입력하세요') ;
		return false ;
	} else if (CKEDITOR.instances.content.getData().length > 400) {
		alert('400자 미만으로 글을 써주세요. ' + '현재 글자 수 : ' + CKEDITOR.instances.content.getData().length) ;
		return false ;
	}		
	else fm.submit();
}


function checkFile(f){
	// files 로 해당 파일 정보 얻기.
	var file = f.files;

	if(file[0].size > 1024 * 1024 * 5){
		// 용량 초과시 경고후 해당 파일의 용량도 보여줌
		alert('5MB 이하 파일만 등록할 수 있습니다.\n\n' + '현재파일 용량 : ' + (Math.round(file[0].size / 1024 / 1024 * 100) / 100) + 'MB');
		f.outerHTML = f.outerHTML;
		return;
    } 
}

</script>
<style>
.ck.ck-editor {
    max-width: 500px;
}
.ck-editor__editable {
    min-height: 300px;
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
}</style>
</head>
<body background='/0709/background.jpg'>
<center>
<br><div class='outline'>
<%
	SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String created = sdt.format(new Date());
%>
<h3>글쓰기</h3>
<FORM METHOD=POST name='fm' enctype="multipart/form-data" >
<table width=650  class="table table-sm">

<tr>
<td><b>번호</b></td>
<td>신규(insert)<input type=hidden name=id value='INSERT' ></td>
</tr>
<tr>
<td><b>제목</b></td>
<td><input type=text id=title name=title size=70 maxlength=70 ></td>
</tr>
<tr>
<td><b>일자</b></td>
<%
	out.println("<td>"+created+"</td>");
%>
</tr>
<tr>
<td><b>내용</b></td>
<td><textarea style='width:500px; height:550px;' id=content name=content cols=70 row=600></textarea>
<script>
		CKEDITOR.replace('content');

window.onload = function() {            
    CKEDITOR.instances.content.on('key',function(event){
		var left = 37;
		var up = 38;
		var right = 39;
		var down = 40;
        var deleteKey = 46;
        var backspaceKey = 8;
		var textLimit = 400;
        var keyCode = event.data.keyCode;
        if (keyCode === deleteKey || keyCode === backspaceKey || keyCode === left || keyCode === up || keyCode === right || keyCode === down)
            return true;
        else
        {
            if (CKEDITOR.instances.content.getData().length >= textLimit) return false;
        }
    }); 
};
</script>
</td>
</tr>
<tr>
<td><b>파일 업로드</b></td>
<td><input type="file"  name="file1" onchange="checkFile(this);"/><br>
<input type="file" name="file2" onchange="checkFile(this);"/><br><input type="file" name="file3" onchange="checkFile(this);"/>
<!--<input type="file" id="file" name="files" multiple="multiple" class="multi maxsize-5120" maxlength="3" />-->
</td>

</tr>
</table>
<table width=850>
<tr>
<td width=800></td>
<td><input type=button class="btn btn-warning btn-lg" value="취소" OnClick="location.href='gongji_list.jsp'"></td>
<td><input type=button class="btn btn-primary btn-lg" value="쓰기" OnClick="submitForm('write')"></td>
</tr>
</table>
</FORM>
</div>
</center>
</body>
</html>