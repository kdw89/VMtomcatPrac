<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.text.*, java.util.*, java.util.Date" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<%	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopo03", "root", "kopo03");
	PreparedStatement pstmt = null;
	String sql = "SELECT id from stock";
	pstmt = conn.prepareStatement(sql);
	ResultSet rset = pstmt.executeQuery();
	
	Long temp;
	List idValues = new ArrayList<Long>();
	while(rset.next()){
		temp = rset.getLong(1);
		idValues.add(temp);
	}
%>
<SCRIPT LANGUAGE="javaScript">
	function onlyNumber(event){				//숫자만 입력
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			return false;
	}
 
	function removeChar(event) {			//문자 제거
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}
	function fnc(value, min, max) 			//숫자 최소, 최대값
	{
		if(parseInt(value) < min || isNaN(value)) 
			return min; 
		else if(parseInt(value) > max) 
			return 9999999999999; 
		else return value;
	}
	function fnc2(value, min, max) 			//숫자 최소, 최대값
	{
		if(parseInt(value) < min || isNaN(value)) 
			return min; 
		else if(parseInt(value) > max) 
			return max; 
		else return value;
	}
	
function isSame() {
    var thirteen = document.getElementById("id").value;
    if (thirteen.length < 13) {
		document.getElementById('idchk').style.color='red';
        document.getElementById('idchk').innerHTML='상품번호는 13자리만 입력 가능합니다. 현재 자리 수 : ' + thirteen.length;
    } else if (thirteen.length > 13) {
		document.getElementById('idchk').style.color='red';
        document.getElementById('idchk').innerHTML='상품번호는 13자리만 입력 가능합니다.';
	} else {
		document.getElementById('idchk').style.color='blue';
        document.getElementById('idchk').innerHTML='상품번호가 13자리입니다.';
	}
}

function checkFile(f){
	// files 로 해당 파일 정보 얻기.
	var file = f.files;

	// file[0].name 은 파일명 입니다.
	// 정규식으로 확장자 체크
	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)) {
		alert('gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + file[0].name);
		f.outerHTML = f.outerHTML;
		return;
	}
	if(file[0].size > 1024 * 1024 * 5){
		// 용량 초과시 경고후 해당 파일의 용량도 보여줌
		alert('5MB 이하 파일만 등록할 수 있습니다.\n\n' + '현재파일 용량 : ' + (Math.round(file[0].size / 1024 / 1024 * 100) / 100) + 'MB');
		f.outerHTML = f.outerHTML;
		return;
    } else if (f.files && f.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#UploadedImg').attr('src', e.target.result);			//업로드 그림 미리보기
        }
        reader.readAsDataURL(f.files[0]);
    }
}

function submitForm(mode){
	fm.action = "stock_write.jsp";
	var list = "<%=idValues%>";
	var newList = list.split(", ");
	var id = document.getElementById("id").value.trim();
	var product = document.getElementById("product").value.trim();
	var inven = document.getElementById("inven").value.trim();
	var detail = document.getElementById("detail").value.trim();
	var file = document.getElementById("file").value.trim();
	if(id == "") alert('상품번호를 입력하세요');
	else if(newList.includes(id)) alert('상품번호가 중복입니다. 확인하세요.');
	else if(id < 1000000000000) alert('상품번호를 13자리로 입력해주세요');
	else if(product == "") alert('상품이름을 입력하세요');
	else if(inven == "") alert('재고 현황을 입력하세요');
	else if(detail == "") alert('상품설명을 입력하세요');
	else if(document.getElementById("detail").value.length > 100) alert('상품설명은 100자 이내로 해주세요. 현재 글자수 : '+document.getElementById("detail").value.length);
	else if(file == "") alert('상품사진을 입력하세요');
	else fm.submit();
}
</SCRIPT>
<style>
#fixed{
	position:fixed;
	bottom:3%;
	right:3%;			/*브라우저 우하단에 고정*/
	width:fixed;
	padding:5px;
	color:white;
	}
</style>
</head>
<body>
<center>
<h1><b>㈜트와이스 재고 현황 -상품등록</b></h1><br>
<%
	SimpleDateFormat sdt=new SimpleDateFormat("yyyy-MM-dd");
	String created = sdt.format(new Date());
%>
<FORM METHOD=POST name='fm' enctype="multipart/form-data" autocomplete="off">
<table class="table table-striped" style="font-size:2em; table-layout:fixed">

<tr>
<td width=25%><b>상품 번호</b></td>
<td><input type=number id=id name=id value='숫자' min=1 max=9999999999999 onkeydown='return onlyNumber(event)' onkeyup='this.value = fnc(this.value, 1, 9999999999999)' 
onfocusout='removeChar(event)' onkeypress='removeChar(event)' oninput="isSame()" autofocus>&nbsp;&nbsp;<span id="idchk"></span></td>
</tr>
<tr>
<td><b>상품명</b></td>
<td><input type=text id=product name=product size=70 maxlength=70 ></td>
</tr>
<tr>
<td><b>재고 현황</b></td>
<td><input type=number id=inven name=inven min=0 onkeydown='return onlyNumber(event)' onkeyup='this.value = fnc2(this.value, 0, 65535)' 
onfocusout='removeChar(event)' onkeypress='removeChar(event)'></td>
</tr>
<tr>
<td><b>상품등록일</b></td>
<%
	out.println("<td>"+created+"</td>");
%>
</tr>
<tr>
<td><b>재고등록일</b></td>
<%
	out.println("<td>"+created+"</td>");
%>
</tr>
<tr>
<td><b>상품설명</b></td>
<td><textarea style='width:60%; height:30%;' id=detail name=detail cols=70 row=600></textarea></td>
</tr>
<tr>
<td><b>상품사진</b></td>
<td><img id="UploadedImg" src="/0703/img/noimg.png" width='20%' height='auto'><br>
<input type=file id=file name=file accept='image/*' onchange="checkFile(this);"></td>
</tr>
</table>
<div id=fixed><input type=button value="취소" class='btn btn-danger btn-lg' style="font-size:5em" OnClick="location.href='stock_list.jsp'">
<input type=button value="쓰기" class='btn btn-success btn-lg' style="font-size:5em" OnClick="submitForm('write')"></div>

</FORM>
</center>
</body>
</html>