<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*" %>
<%@ page errorPage="error.jsp" %>
<%
	String key = request.getParameter("key");
	int key2 = Integer.parseInt(key);
%>
<html>
<head>
<script src="https://cdn.ckeditor.com/4.12.1/standard/ckeditor.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="jquery.MultiFile.js"></script>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<SCRIPT LANGUAGE="javaScript">
function submitForm(mode){
	if(mode == "write"){
		fm.action = "gongji_write.jsp";
		var title = document.getElementById("title").value.trim();
		var editor_val = CKEDITOR.instances.content.getData();
		if(title == "") alert('제목을 입력하세요');
		else if (editor_val == '') {
		alert('내용을 입력하세요') ;
		return false ;
		} else fm.submit();
	} else if(mode == "delete"){
		fm.action = "gongji_delete.jsp";
		if(confirm("정말 삭제하시겠습니까?") == true) fm.submit();
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
}</style>
</head>
<body>
<center>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "select title, date, content, filepath1, filepath2, filepath3 from gongji where id=?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1,key2);
	ResultSet rset = pstmt.executeQuery();
%>
<FORM METHOD=POST name='fm' enctype="multipart/form-data">
<table width=650 class="table table-sm">
<%	
	rset.next();
	out.println("<tr>");
	out.println("<td width='15%'><b>번호</b></td>");
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
	out.println("</td></tr>");							//이미 존재하는 첨부파일을 제거, 재등록하는곳
	rset.close();
	pstmt.close();
	conn.close();
%>
</table>
<table width=650>
<tr>
<td width=600></td>
<td><input type=button value="취소" OnClick="location.href='gongji_list.jsp'"></td>
<td><input type=button value="쓰기" OnClick="submitForm('write')"></td>
<td><input type=button value="삭제" OnClick="submitForm('delete')"></td>
</tr>
</table>
</FORM>
</center>
<script>
function delItem1(){
document.getElementById('rm1').innerHTML = "<input type='file'  name='file1' onchange='checkFile(this);'/><br>"; 		//첨부파일 제거 펑션
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