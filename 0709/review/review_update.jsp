<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String key = request.getParameter("key");
	int key2 = Integer.parseInt(key);
	
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
<html>
<head>
<script src="https://cdn.ckeditor.com/4.12.1/basic/ckeditor.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="jquery.MultiFile.js"></script>

<link type="text/css" rel="stylesheet" href="bootstrap.css">
<SCRIPT LANGUAGE="javaScript">
function submitForm(mode){
	if(mode == "write"){
		fm.action = "review_write.jsp";
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
</SCRIPT>
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
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "select title, date, content, filepath1, filepath2, filepath3 from resort_review where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,key2);
	ResultSet rset = pstmt.executeQuery();
%>
<FORM METHOD=POST name='fm' enctype="multipart/form-data">
<table width=650 class="table table-sm">
<%	
	rset.next();
	out.println("<tr>");
	out.println("<td><b>번호</b></td>");
	out.println("<td><input type=text name=id size=70 maxlength=70 value='"+key2+"' readonly></td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td><b>제목</b></td>");
	out.println("<td><input type=text id=title name=title size=70 maxlength=70 value=\""+rset.getString(1)+"\"></td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td><b>일자</b></td>");
	out.println("<td>"+rset.getDate(2)+"</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td><b>내용</b></td>");
	out.println("<td><textarea style='width:500px; height:250px;' id=content name=content cols=70 row=600>"
												+rset.getString(3)+"</textarea>"); %>
<script>
		CKEDITOR.replace( 'content' );
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
</script></td><%
	out.println("</tr>");
	out.println("<tr><td><b>첨부파일</b></td><td>");
	if(rset.getString(4) != null) out.println("<div id='rm1'><img src=clip.png>"+rset.getString(4)
		+"<input type='hidden' name='file1' value='"+rset.getString(4)+"'> &nbsp;<input type=image src=remove.png onClick='javascript:delItem1();'></div>");
	else out.println("<input type='file'  name='file1' onchange='checkFile(this);'/><br>");
	if(rset.getString(5) != null) out.println("<div id='rm2'><img src=clip.png>"+rset.getString(5)
		+"<input type='hidden' name='file2' value='"+rset.getString(5)+"'> &nbsp;<input type=image src=remove.png onClick='javascript:delItem2();'></div>");
	else out.println("<input type='file'  name='file2' onchange='checkFile(this);'/><br>");
	if(rset.getString(6) != null) out.println("<div id='rm3'><img src=clip.png>"+rset.getString(6)
		+"<input type='hidden' name='file3' value='"+rset.getString(6)+"'> &nbsp;<input type=image src=remove.png onClick='javascript:delItem3();'></div>");
	else out.println("<input type='file'  name='file3' onchange='checkFile(this);'/><br>");
	out.println("</td></tr>");
	rset.close();
	pstmt.close();
	conn.close();
%>
</table>
<table width=850>
<tr>
<td width=750></td>
<td><input type=button class="btn btn-warning btn-lg" value="취소" OnClick="location.href='review_list.jsp'"></td>
<td><input type=button class="btn btn-primary btn-lg" value="쓰기" OnClick="submitForm('write')"></td>
</tr>
</table>
</FORM>
</div>
</center>
<script>
function delItem1(){
document.getElementById('rm1').innerHTML = "<input type='file'  name='file1' onchange='checkFile(this);'/><br>"; 
}
function delItem2(){
document.getElementById('rm2').innerHTML = "<input type='file'  name='file2' onchange='checkFile(this);'/><br>"; 
}
function delItem3(){
document.getElementById('rm3').innerHTML = "<input type='file'  name='file3' onchange='checkFile(this);'/><br>"; 
}
</script>
</body>
</html>