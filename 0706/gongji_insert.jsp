<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.*, java.util.Date" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<script src="https://cdn.ckeditor.com/4.12.1/standard/ckeditor.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src='jquery.MultiFile.js' type="text/javascript" language="javascript"></script>
<link type="text/css" rel="stylesheet" href="bootstrap.css">

<SCRIPT LANGUAGE="javaScript" type='text/javascript'>
function submitForm(mode){
	fm.action = "gongji_write.jsp?key=INSERT";
	var title = document.getElementById("title").value.trim();
	var editor_val = CKEDITOR.instances.content.getData();		//에디터 내 입력된값
    if(title == "") alert('제목을 입력하세요');
	else if (editor_val == '') {
		alert('내용을 입력하세요') ;
		return false ;
	} else fm.submit();
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
}</style>
</head>
<body>
<center>

<%
	SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	String created = sdt.format(new Date());
%>
<FORM METHOD=POST name='fm' enctype="multipart/form-data" >
<table width=650 class="table table-sm">

<tr>
<td width='15%'><b>번호</b></td>
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
		CKEDITOR.replace( 'content' );				//에디터 적용
</script>
</td>
</tr>
<tr>
<td><b>파일 업로드</b></td>
<td><input type="file"  name="file1" onchange="checkFile(this);"/><br>			<!--파일 3개-->
<input type="file" name="file2" onchange="checkFile(this);"/><br><input type="file" name="file3" onchange="checkFile(this);"/>
</td>

</tr>
</table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp'"></td>
<td><input type=button value="쓰기" OnClick="submitForm('write')"></td>
</tr>
</table>
</FORM>
</center>
</body>
</html>