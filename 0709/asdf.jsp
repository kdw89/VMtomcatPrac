<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8"%>
<html>
  <head>
    <title>Simple Map</title>
    <meta charset="utf-8">

<style>
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

@font-face {
	font-family:maple;
	src:url("maplestory.ttf") format("truetype");
	font-weight: normal;
	font-style: normal;
}

body {
	font-family:maple;
	font-size:1em;
}
</style>
</head>
<body background='/0709/background.jpg'>
<center>
<br>
<div class='outline' >
<table style="width:800px">
	<tbody>
		<tr>
		<td colspan=3 style="text-align:center">
			<h3>대중교통이용</h3>
		</td>
	</tr>
				<tr><td colspan=3><hr></td></tr>
		<tr>
			<td width=100>지하철</td>
			<td width=200><span class="badge badge-warning">분당선</span></td>
			<td width=500 style="font-family:maple; font-size:1em;">서현역 4번 출구(AK프라자 2번 출구)에서 성남교육지원청 방향으로 도보 3분</td>
		</tr>
			<tr><td colspan=3><hr></td></tr>
		<tr>
			<td rowspan=3>버스</td>
			<td>
			<p><span class="badge badge-primary">일반</span> 116, 222</p>
			<p><span class="badge badge-danger">직행</span> 3500 이용시</p>
			</td>
			<td>서현역,AK프라자 정류장(분당구청 방향) 하차. 분당구청 방향으로 직진 후 성남교육지원청 방향으로 우회전하여 도보 2분</td>
		</tr>
					<td colspan=2><hr></td>
		<tr>
			<td>
			<p><span class="badge badge-primary">일반</span> 116, 222</p>
			<p><span class="badge badge-danger">직행</span> 3500</p>
			<p><span class="badge badge-success">마을</span> 3-1, 32, 71,</p>
			<p>74, 602, 602-1,</p>
			<p>602-1C, 602-2</p>
			<p>이용시</p>
			</td>
			<td>서현역,AK프라자 정류장(이매촌 방향) 하차. 분당구청 방향으로 직진 후 성남교육지원청 방향으로 우회전하여 도보 2분</td>
		</tr>
	</tbody>
</table>
</div>
</center>
<div id=fixed><a href='d_01.jsp' target=main><img width=200 src='/0709/image/back.png'></a></div>
 </body>

</html>