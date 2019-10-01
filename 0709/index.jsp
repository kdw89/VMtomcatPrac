<meta charset="utf-8">

<HTML>
<HEAD>
<title>개구리조트</title>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<%@ page import="java.net.*"%>
<meta name="viewport" content="user-scalable=no, width=device-width" />
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<link rel="apple-touch-icon" sizes="192x192" href="192.png">
<meta http_equiv="Caghe-Control" content="no-cache" />
<script language='javascript' type='text/javascript'>
var orientationEvent;
var uAgent=navigator.userAgent.toLowerCase();
var mobilePhones='android';
if(uAgent.indexOf(mobilePhones)!=-1){
	orientationEvent="resize";
}
else orientationEvent="orientationchange";


window.addEventListener(orientationEvent, function()
{
	// alert("회전했어요");
	location.href='#';
}, false);

var prevScreen=0;
var sv_prevScreen=0;
function prevShow()
{
	ScreenShow(prevScreen);
}

var muCnt = 5;
var scCnt = 14;

function fncShow(pos)
{
	var i = 0;
	for(i=0; i<scCnt; i++)
	{
		var obj = document.getElementById("s"+i);
		obj.style.display = 'none';
		
		var f1 = document.getElementById('iframe1');
		f1.src = f1.src;
		var f2 = document.getElementById('iframe2');
		f2.src = f2.src;
		var f3 = document.getElementById('iframe3');
		f3.src = f3.src;
		var f4 = document.getElementById('iframe4');
		f4.src = f4.src;
	}
	for(i=0; i<muCnt; i++)
	{
		var obj = document.getElementById("menu"+i);
		var obj2 = document.getElementById("m"+i);
		if(i==pos)
		{
			obj.style.display = '';
			obj2.style.background="#009090";
		}
		else
		{
			obj.style.display = 'none';
			obj2.style.background="#409000";
		}
	}
}

var scCnt = 14;
var ScrObj;

var timer1;

function ScrAnimation() {
	var offset = -50;
	
	if(parseInt(ScrObj.style.left) >10)
	{
		ScrObj.style.left = parseInt(ScrObj.style.left) + offset + "px";
		timer1 = setTimeout("ScrAnimation()", 1);
	}
	else {
		ScrObj.style.left=0;
		clearTimeout(timer1);
	}
}

function ScreenShow(pos)
{
	var i = 0;
	
	for(i=0; i<muCnt; i++)
	{
		var obj = document.getElementById("menu"+i);
		obj.style.display = 'none';
	}
	
	for(i=0; i<scCnt; i++)
	{
		var obj = document.getElementById("s"+i);
		if(i == pos)
		{
			prevScreen = sv_prevScreen;
			sv_prevScreen = i;
			
			obj.style.display = '';
			
			obj.style.position="absolute";
			obj.style.top=35;
			obj.style.left=screen.width;
			obj.style.height=screen.height-120;
			
			ScrObj=obj;
			ScrAnimation();
		}
		else
		{
			obj.style.display='none';
		}
	}
}

</script>

		<link type="text/css" rel="stylesheet" href="bootstrap.min.css">
<link type="text/css" rel="stylesheet" href="bootstrap.css">
<link type="text/css" rel="stylesheet" href="table.css">
<style>
.map {
	position:relative;
	border:3px solid lightgray;
	}
.map > p {
	position:absolute;	/*절대 배치*/
	height:20px;
	width:15px;
	}
	
@font-face {
	font-family:maple;
	src:url("maplestory.ttf") format("truetype");
	font-weight: 100;
	font-style: normal;
}

body {
	font-family:maple;
	font-size:2em;
}
</style>
</HEAD>
<BODY background='background.jpg' onresize='hide();'>
<center>
<div id="container" style="width:device-width; height:device-height;">
	<div id="header1" style="background-color:#409000; height:35px; width:10%; float:left; vertical-align:middle;" onclick='prevShow();'><center><img src='m_img/backarr.png'></center></div>
	<div id="header2" style="background-color:#409000; height:35px; width:80%; float:left; vertical-align:middle;"><center><img src='m_img/title.png'></center></div>
	<div id="header3" style="background-color:#409000; height:35px; width:10%; float:left; vertical-align:middle;" onclick='ScreenShow(0);'><center><img src='m_img/home.png'></center></div>
	
	<div id="menu0" style="background-color:#009090; color:#eeeeee; display:none; text-align:left; padding:5%;">
	<br><br>리조트소개<br><hr>
		<li onclick='ScreenShow(0);'> 개구리조트</li><hr>
		<li onclick='ScreenShow(1);'> VIP룸</li><hr>
		<li onclick='ScreenShow(2);'> 일반룸</li><hr>
		<li onclick='ScreenShow(3);'> 합리적인룸</li><br>
	</div>
	<div id="menu1" style="background-color:#009090; color:#eeeeee; display:none; text-align:left; padding:5%;">
	<br><br>찾아오기<br><hr>
		<li onclick='ScreenShow(4);'> 찾아오는 길</li><hr>
		<li onclick='ScreenShow(5);'> 대중교통</li><hr>
		<li onclick='ScreenShow(6);'> 자가용이용</li><br>
	</div>
	<div id="menu2" style="background-color:#009090; color:#eeeeee; display:none; text-align:left; padding:5%;">
	<br><br>주변여행지<br><hr>
		<li onclick='ScreenShow(7);'> 개구리마을</li><hr>
		<li onclick='ScreenShow(8);'> 중앙공원</li><hr>
		<li onclick='ScreenShow(9);'> 남한산성</li><br>
	</div>
	<div id="menu3" style="background-color:#009090; color:#eeeeee; display:none; text-align:left; padding:5%;">
	<br><br>예약하기<br><hr>
		<li onclick='ScreenShow(10);'> 예약상황</li><hr>
		<li onclick='ScreenShow(11);'> 예약하기</li><br>
	</div>
	<div id="menu4" style="background-color:#009090; color:#eeeeee; display:none; text-align:left; padding:5%;">
	<br><br>리조트소식<br><hr>
		<li onclick='ScreenShow(12);'> 리조트소식</li><hr>
		<li onclick='ScreenShow(13);'> 이용후기</li><br>
	</div>
	
	<div id="s0">
  		<!----------	메인메뉴 ---------------------->
<div class="card bg-dark text-white">
  <img class="card-img" src="trump.png" alt="Card image">
  <div class="card-img-overlay" style="text-align:left">
    <!--<h3 class="card-title">개구리조트</h3>-->
    <p class="card-text">"고품격 Refresh의 개구리조트" </p>
    <!--<p class="card-text">별거 없는 시설을 갖춘 사계절 종합리조트입니다.</p>-->
  </div>
</div>	
	<br>
<%
	Cookie[] cookies = request.getCookies();
	if(cookies != null) {
	for (int i = 0; i < cookies.length; i++)
	{
		Cookie thisCookie = cookies[i];
		if("recentVisit".equals(thisCookie.getName()))
		{
			out.println("<h4>최근 방문일은 ("+URLDecoder.decode(thisCookie.getValue(), "UTF-8")+") 입니다.</h4><br>");
		}
	}
	}
%>
<div class="card-group">
  <div class="card">
    <img class="card-img-top" src="ban2.jpg" alt="Card image cap">
    <div class="card-body">
      <h5 class="card-title">아늑한 침실</h5>
      <p class="card-text">아무튼 아기자기하게 꾸며놨습니다.</p>
      <p class="card-text"><small class="text-muted">아무튼!</small></p>
    </div>
  </div>
  <div class="card">
    <img class="card-img-top" src="ban3.jpg" alt="Card image cap">
    <div class="card-body">
      <h5 class="card-title">주변경관</h5>
      <p class="card-text">산책로가 있고.. 마스코트도 있고...<br>많은 휴양수단을 마련하였습니다.</p>
      <p class="card-text"><small class="text-muted">사실 별거 없습니다.<br>잘못했습니다.</small></p>
    </div>
  </div>
  <div class="card">
    <img class="card-img-top" src="ban1.gif" alt="Card image cap">
    <div class="card-body">
      <h5 class="card-title">욕실 온수 제공</h5>
      <p class="card-text">무려 온수가 제공됩니다. <br>1872년, Heinzmann에 의해 행해진 실험에서 매우 천천히 온도가 올라가는 물에서 정상적인 개구리가 탈출을 시도하지 않았다고 하네요.</p>
      <p class="card-text"><small class="text-muted">응 안물<br>"..."</small></p>
    </div>
  </div>
</div>
<br>
<div class="card" style="width:fixed;">
  <div class="card-header">
    개구리 蛙 / frog
  </div>
  <div class="card-body">
    <blockquote class="blockquote mb-0">
      <p>대표적인 양서류 중 하나. 고어로는 '머구리(마구리)'라 했으며, 사투리로 '개구락지'라고도 하기도 한다.
잘 알려져 있지 않은 부분인데, 이빨이 있다. 맨눈으로는 보이지 않고 현미경으로 들여다봐야 보인다. 턱니라고 하는데, 먹이를 잡았을 때 마찰력을 높여 놓치지 않게 해 주는 역할을 한다. 이 턱니는 두꺼비에게는 없어서, 두꺼비와 개구리를 구분하는 방법 중 하나이기도 하다.
조상은 도롱뇽과 함께 게로바트라쿠스로 알려져있다.</p>
      <footer class="blockquote-footer">출처는 <cite title="Source Title">나무위키</cite></footer>
    </blockquote>
  </div>
</div>
					<div style="height:80px;"></div>

		<!-------------------------------->
	</div>
	<div id="s1" style="display:none; width:100%;">
	<!------------빕룸-------------------->
				<div>
					<table>
						<tr>
							<td>
								<div class="container">
									<div class="row">
										<div class="col-md-6">
											<img src="/0709/image/room1.jpg" width=fixed height=auto alt="test" class="img-responsive">
											<div class="carousel-caption text_border">
											  <h1>VIP room</h1>
											</div>
										 </div>
									</div>
								</div>
							</td>
						</tr>
							<tr><td><hr></td></tr>
						<tr>
							<td style="text-align:center">
								<h2>VIP룸</h2>
								최고급이올시다
							</td>
						</tr>
					</table>
					<table class="table">
						<tr>
							<th scope="row">객실정원</th>
							<td>6인</td>
						</tr>
						<tr>
							<th scope="row">객실구성</th>
							<td>방2, 욕실</td>
						</tr>
						<tr>
							<th scope="row">비품</th>
							<td><b>가구류</b> - 침대 / 식탁<br>
								<b>가전류</b> - TV / 냉장고 / 전기밥솥 / 드라이기<br>
								<b>식기류</b> - 후라이팬 / 냄비 / 식기 등<br>
								<b>기타</b> p- 이불 / 요 / 베개 / 타월</td>
						</tr>
					</table>
					<table class="table table-striped">
						<thead>
						<tr>
							<th scope="cols">구분</th>
							<th scope="cols">요금안내</th>
							<th scope="cols">기타사항</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td>비수기</th>
							<td>100,000</th>
							<td>2~5월, 10~11월</th>
						</tr>
						<tr>
							<td>준성수기</th>
							<td>150,000</th>
							<td>6월, 11~1월</th>
						</tr>
						<tr>
							<td>성수기</th>
							<td>200,000</th>
							<td>7~9월</th>
						</tr>
						</tbody>
					</table>
					상세요금은 제시
					</div>
				<div style="height:80px;"></div>
	
	<!-------------------------------->
	</div>
	<div id="s2" style="display:none; width:100%;">
	<!---------------일반룸	----------------->
	
								<div >
							<table>
								<tr>
									<td>
										<div class="container">
											<div class="row">
												<div class="col-md-6">
													<img src="/0709/image/room2.jpg" width=fixed height=auto alt="test" class="img-responsive">
													<div class="carousel-caption text_border">
													  <h1>Normal</h1>
													</div>
												 </div>
											</div>
										</div>
									</td>
								</tr>
									<tr><td><hr></td></tr>
								<tr>
									<td colspan=3 style="text-align:center">
										<h2>일반룸</h2>
										일반룸에 대한 간략한 설명
									</td>
								</tr>
							</table>

							<table class="table">
								<tr>
									<th scope="row">객실정원</th>
									<td>4인</td>
								</tr>
								<tr>
									<th scope="row">객실구성</th>
									<td>방2, 욕실</td>
								</tr>
								<tr>
									<th scope="row">비품</th>
									<td><b>가구류</b> - 침대 / 식탁<br>
										<b>가전류</b> - TV / 냉장고 / 전기밥솥 / 드라이기<br>
										<b>식기류</b> - 후라이팬 / 냄비 / 식기 등<br>
										<b>기타</b> p- 이불 / 요 / 베개 / 타월</td>
								</tr>
							</table>
							<table class="table table-striped">
								<thead>
								<tr>
									<th scope="cols">구분</th>
									<th scope="cols">요금안내</th>
									<th scope="cols">기타사항</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td>비수기</th>
									<td>80,000</th>
									<td>2~5월, 10~11월</th>
								</tr>
								<tr>
									<td>준성수기</th>
									<td>120,000</th>
									<td>6월, 11~1월</th>
								</tr>
								<tr>
									<td>성수기</th>
									<td>160,000</th>
									<td>7~9월</th>
								</tr>
								</tbody>
							</table>
							상세요금은 제시
							</div>
		<div style="height:80px;"></div>
	
	
		<!-------------------------------->
	</div>
	<div id="s3" style="display:none; width:100%;">
	<!-----------------합리적인룸--------------->
	
									<div >
								<table>
									<tr>
										<td>
											<div class="container">
												<div class="row">
													<div class="col-md-6">
														<img src="/0709/image/room3.jpg" width=fixed height=auto alt="test" class="img-responsive">
														<div class="carousel-caption text_border">
														  <h1>Economic</h1>
														</div>
													 </div>
												</div>
											</div>
										</td>
									</tr>
										<tr><td><hr></td></tr>
									<tr>
										<td colspan=3 style="text-align:center">
											<h2>합리적인룸</h2>
											합리적인룸에 대한 간략한 설명
										</td>
									</tr>
								</table>

								<table class="table">
									<tr>
										<th scope="row">객실정원</th>
										<td>2인</td>
									</tr>
									<tr>
										<th scope="row">객실구성</th>
										<td>방1, 욕실</td>
									</tr>
									<tr>
										<th scope="row">비품</th>
										<td><b>가구류</b> - 침대 / 식탁<br>
											<b>가전류</b> - TV / 냉장고 / 전기밥솥 / 드라이기<br>
											<b>식기류</b> - 후라이팬 / 냄비 / 식기 등<br>
											<b>기타</b> p- 이불 / 요 / 베개 / 타월</td>
									</tr>
								</table>
								<table class="table table-striped">
									<thead>
									<tr>
										<th scope="cols">구분</th>
										<th scope="cols">요금안내</th>
										<th scope="cols">기타사항</th>
									</tr>
									</thead>
									<tbody>
									<tr>
										<td>비수기</th>
										<td>50,000</th>
										<td>2~5월, 10~11월</th>
									</tr>
									<tr>
										<td>준성수기</th>
										<td>75,000</th>
										<td>6월, 11~1월</th>
									</tr>
									<tr>
										<td>성수기</th>
										<td>100,000</th>
										<td>7~9월</th>
									</tr>
									</tbody>
								</table>
								상세요금은 제시
								</div>
								<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s4" style="display:none; width:100%;">
		<!---------	찾아오느길----------------------->
								<table >
							<tr>
								<td style="text-align:center">
									<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3170.170491176107!2d127.11908231564452!3d37.38580014221521!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b580343616653%3A0xd7ebad971bbc0d02!2z7ZWc6rWt7Y-066as7YWN64yA7ZWZIOycte2Vqeq4sOyIoOq1kOycoeybkA!5e0!3m2!1sko!2skr!4v1562648204336!5m2!1sko!2skr" 
											width=fixed height=200% frameborder="0" style="border:0" allowfullscreen>지도 로딩중..</iframe>
								</td>
							</tr>
							<tr><td><hr></td></tr>
							<tr>
								<td style="text-align:center">
									<h2>개구리조트</h2>
									<strong>주소 : </strong>경기도 성남시 분당구 황새울로 329번길 5  <br>
									<strong>TEL : </strong> 031-696-8800   <br>
									<strong>FAX : </strong> 031-696-8809	<br>
									
								</td>
							</tr>
						</table>
						<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s5" style="display:none; width:100%;">
	
	<!----------------	대중교통---------------->
							<table>
							<tbody>
								<tr>
								<td colspan=3 style="text-align:center">
									<h3>대중교통이용</h3>
								</td>
							</tr>
										<tr><td colspan=3><hr></td></tr>
								<tr>
									<td width=15%>지하철</td>
									<td width=25%><span class="badge" style="background-color:gold">분당선</span></td>
									<td width=60%>서현역 4번 출구(AK프라자 2번 출구)에서 성남교육지원청 방향으로 도보 3분</td>
								</tr>
									<tr><td colspan=3><hr></td></tr>
								<tr>
									<td rowspan=3>버스</td>
									<td>
									<p><span class="badge" style="background-color:blue">일반</span> 116, 222</p>
									<p><span class="badge" style="background-color:red">직행</span> 3500 이용시</p>
									</td>
									<td>서현역,AK프라자 정류장(분당구청 방향) 하차. 분당구청 방향으로 직진 후 성남교육지원청 방향으로 우회전하여 도보 2분</td>
								</tr>
											<td colspan=2><hr></td>
								<tr>
									<td>
									<p><span class="badge" style="background-color:blue">일반</span> 116, 222</p>
									<p><span class="badge" style="background-color:red">직행</span> 3500</p>
									<p><span class="badge" style="background-color:green">마을</span> 3-1, 32, 71,</p>
									<p>74, 602, 602-1,</p>
									<p>602-1C, 602-2</p>
									<p>이용시</p>
									</td>
									<td>서현역,AK프라자 정류장(이매촌 방향) 하차. 분당구청 방향으로 직진 후 성남교육지원청 방향으로 우회전하여 도보 2분</td>
								</tr>
							</tbody>
						</table>
						<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s6" style="display:none; width:100%;">
		<!------------자가용-------------------->
								<div class='map'>
									<img src='/0709/image/map.png' width=85% height=auto>
									<p style="left:50%; top:40%"><img id=loc1 src='/0709/image/marker_off.png'></p>
									<p style="left:40%; top:45%"><img id=loc2 src='/0709/image/marker_off.png'></p>
									<p style="left:35%; top:70%"><img id=loc3 src='/0709/image/marker_off.png'></p>
									<p style="left:75%; top:65%"><img id=loc4 src='/0709/image/marker_off.png'></p>
									<p style="left:65%; top:20%"><img id=loc5 src='/0709/image/marker_off.png'></p>
									<p style="left:28%; top:50%"><img id=loc6 src='/0709/image/marker_off.png'></p>
								</div>

								<div class="list-group">
								  <a href="#" class="list-group-item list-group-item-action">제휴주차장목록</a>
								  <a href="#" onmouseover=loc1.src='/0709/image/marker_on.png' onmouseout=loc1.src='/0709/image/marker_off.png' 
									class="list-group-item list-group-item-action list-group-item-primary">개구리조트 개굴주차장</a>
								  <a href="#" onmouseover=loc2.src='/0709/image/marker_on.png' onmouseout=loc2.src='/0709/image/marker_off.png' 
									class="list-group-item list-group-item-action list-group-item-success">도마뱀타운 주차장</a>
								  <a href="#" onmouseover=loc3.src='/0709/image/marker_on.png' onmouseout=loc3.src='/0709/image/marker_off.png' 
									class="list-group-item list-group-item-action list-group-item-danger">도롱뇽 공영주차장</a>
								  <a href="#" onmouseover=loc4.src='/0709/image/marker_on.png' onmouseout=loc4.src='/0709/image/marker_off.png' 
									class="list-group-item list-group-item-action list-group-item-warning">왕눈이 주차타워</a>
								  <a href="#" onmouseover=loc5.src='/0709/image/marker_on.png' onmouseout=loc5.src='/0709/image/marker_off.png' 
									class="list-group-item list-group-item-action list-group-item-info">아로미빌딩 민영주차장</a>
								  <a href="#" onmouseover=loc6.src='/0709/image/marker_on.png' onmouseout=loc6.src='/0709/image/marker_off.png' 
									class="list-group-item list-group-item-action list-group-item-dark">케로로주차장</a>
								</div>
								<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s7" style="display:none; width:100%;">
	<!---------개구리마을----------------------->
							
							<div class="card">
						  <div class="card-body">
							<h5 class="card-title">개구리마을</h5>
							<p class="card-text">부산광역시 동래구 명장동에 있는 자연 마을로, 옛날 동래 종합 사회 복지관 일원 골짜기는 저녁이 되면 개구리 소리가 요란하였고, 주민들이 논이나 미나리꽝에서 개구리를 잡아 말려 약재로 팔아 생계를 유지하는 경우가 많아서 마을 이름을 개구리 마을이라고 하였다.</p>
							<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
						  </div>
						  <img class="card-img-bottom" src="/0709/image/frogtown.jpg" alt="Card image cap">
						</div>
						<br>
						<div class="card-columns">
						  <div class="card">
							<img class="card-img-top" src="/0709/image/frogtown2.jpg" alt="Card image cap">
							<div class="card-body"  style="vertical-align:bottom;">
							  <h5 class="card-title">상징물 A</h5>
							  <p class="card-text"> 아무데서나 긁어온 사진인데..뭘 엮어서 만들었을까?</p>
							</div>
						  </div>
						  <div class="card p-3">
							<blockquote class="blockquote mb-0 card-body">
							  <p>개구리는 한때 영양실조와 소화 불량으로 야위고 배가 불록하게 튀어나온 어린이에게 특별히 좋은 약재로 많이 사용되었다.</p>
							  <footer class="blockquote-footer">
								<small class="text-muted">
								  개구리마을의 <cite title="Source Title">[형성 및 변천]</cite>
								</small>
							  </footer>
							</blockquote>
						  </div>
						  <div class="card">
							<img class="card-img-top" src="/0709/image/frogtown3.jpg" alt="Card image cap">
							<div class="card-body">
							  <h5 class="card-title">형성</h5>
							  <p class="card-text">개구리 마을은 부산광역시 동래구 명륜동 온천 입구 사거리에서 시싯골을 지나 마안산 북쪽 고개를 넘어가다 깊은 계곡을 따라 길게 형성된 마을이었다. </p>
							  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
							</div>
						  </div>
						  <div class="card bg-info text-white text-center p-3">
							<blockquote class="blockquote mb-0">
							  <p>6·25 전쟁 때 피난민이 모여 판자촌을 이루어 살던 마을로, 좁은 골짜기의 다랑이 논에 벼와 채소를 심었고, 논 일원에서 자라는 개구리를 잡아 팔아 살았다.</p>
							  <footer class="blockquote-footer">
								<small>
								  Someone famous in <cite title="Source Title">Source Title</cite>
								</small>
							  </footer>
							</blockquote>
						  </div>
						  <div class="card">
							<img class="card-img" src="/0709/image/froghouse2.jpg" alt="Card image">
						  </div>
						  <div class="card p-3 text-right">
							<blockquote class="blockquote mb-0">
							  <p>개구리 마을은 산지 사이에 자리하였다. 남쪽으로는 마안산이 있고, 북쪽으로는 낮은 산이 가로막혀 있으며, 서쪽으로는 남북의 두 산이 연결되던 고개로 시실골이 있다.</p>
							  <footer class="blockquote-footer">
								<small class="text-muted">
								  개구리마을의 <cite title="Source Title">[자연 환경]</cite>
								</small>
							  </footer>
							</blockquote>
						  </div>
						  <div class="card">
							<div class="card-body">
							  <h5 class="card-title">환경</h5>
							  <p class="card-text"> 동쪽은 반송로로 연결되는 경사면이다. 남북으로 산이 있어 공기가 좋은 편이다.</p>
							  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
							</div>
						  </div>
						</div>
						<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s8" style="display:none; width:100%;">
	<!---------------중앙공원----------------->
	
							<div class="card">
						  <div class="card-body">
							<h5 class="card-title">중앙공원</h5>
							<p class="card-text">성남중앙공원(城南中央公園)은 경기도 성남시 분당구 수내동에 위치한 공원이다. 1994년 7월 31일에 개원했다.</p>
							<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
						  </div>
						  <img class="card-img-bottom" src="/0709/image/park.jpg" alt="Card image cap">
						</div>
						<br>
						<div class="card-columns">
						  <div class="card">
							<img class="card-img-top" src="/0709/image/park3.jpg" alt="Card image cap">
							<div class="card-body">
							  <h5 class="card-title">수내중앙공원</h5>
							  <p class="card-text">높이 413.5m의 영장산(靈長山) 자락에 위치해 있으며 본래의 지형과 수림을 최대한 살리고 향토 수종을 새로 심어 자연스러운 경관을 연출하였다.</p>
							</div>
						  </div>
						  <div class="card p-3">
							<blockquote class="blockquote mb-0 card-body">
							  <p>교양시설로는 야외공연장과 무대·동물원 등이 있다. 야외공연장에서는 각종 문화행사와 공연이 열린다. 문화재로 지정된 수내동 가옥을 복원하였으며, 고인돌 정원도 조성되어 있다. </p>
							  <footer class="blockquote-footer">
								<small class="text-muted">
								  Someone famous in <cite title="Source Title">Source Title</cite>
								</small>
							  </footer>
							</blockquote>
						  </div>
						  <div class="card">
							<img class="card-img-top" src="/0709/image/park2.jpg" alt="Card image cap">
							<div class="card-body">
							  <h5 class="card-title">특징</h5>
							  <p class="card-text">호수와 분수·물레방아·잔디광장·상록수광장·역말 광장·황새울광장 등의 조경시설은 물론 배드민턴장과 게이트볼장·기체조장·종합체육시설 등 운동시설이 매우 많다. 이 중에 호수 분당호는 공원을 가로지르며 흐르는 분당천을 끌어들여 조성한 연못이다. </p>
							  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
							</div>
						  </div>
						  <br>
						  <div class="card bg-success text-white text-center p-3">
							<blockquote class="blockquote mb-0">
							  <p>성남중앙공원에 경기도 지정 문화재 기념물 제116호 묘역이 위치해 있다. 이 묘역은 500여년의 역사적 전통문화의 보존과 신도시와의 조화된 휴식공간 및 시민공원으로 쓰이고 있다. </p>
							  <footer class="blockquote-footer">
								<small>
								  Someone famous in <cite title="Source Title">Source Title</cite>
								</small>
							  </footer>
							</blockquote>
						  </div>
						  <div class="card text-center">
							<div class="card-body">
							  <h5 class="card-title">요소</h5>
							  <p class="card-text">수내동 가옥은 한산 이씨 종가이며, 고인돌 정원에는 성남시 곳곳에 있던 10기의 고인돌이 모여 있다. 이 밖에도 정자와 주차장·화장실·시계탑 등의 편의시설이 있다. </p>
							  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
							</div>
						  </div>
						  <div class="card">
							<img class="card-img" src="/0709/image/park4.jpg" alt="Card image">
						  </div>
						  <div class="card p-3 text-right">
							<blockquote class="blockquote mb-0">
							  <p>분당구 중심에 기존지형과 수림대를 최대로 보존한 자연형 근린공원, 능선을 따라 등산로를 개설하고 분당 천변에 산책로를 조성한 산책위주 공원</p>
							  <footer class="blockquote-footer">
								<small class="text-muted">
								  Someone famous in <cite title="Source Title">Source Title</cite>
								</small>
							  </footer>
							</blockquote>
						  </div>
						  <div class="card">
							<div class="card-body">
							  <h5 class="card-title">수내동 가옥</h5>
							  <p class="card-text">한산이씨 수내동 가옥은 조선시대 고가로 경기도 문화재 자료 제78호로 지정되었다. 이 곳은 경기지역 살림집의 한 모습을 잘 반영하고 있다고 한다. 임야와 주거지는 시민휴식공간과 공연장, 감상공간으로 쓰이고 있다.</p>
							  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
							</div>
						  </div>
						</div>
						<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s9" style="display:none; width:100%;">
	<!-------------남한산성------------------->
	
	
			<div class="card">
				  <div class="card-body">
					<h5 class="card-title">남한산성</h5>
					<p class="card-text">경기도 광주시 남한산성면(옛 중부면) 산성리에 위치한 남한산의 산성이다.
					그렇지만 경기도 광주시, 성남시, 하남시에 영역이 걸쳐있기 때문에 광주가 주로 관리하는 편이지만 세 도시가 같이 관리하고 있다고 봐야 한다.
					사적 제57호로 지정되어 경기도에서 도립공원으로 관리하고 있다. 조선 인조 때에 쌓은 성곽이며, 해발 497m의 청량산(淸凉山)을 서쪽 끝으로 하고,
					해발 514m의 벌봉을 동쪽 끝으로 하는 긴 장방형의 돌로 쌓았다. 서쪽은 경사가 가파르고 높아서 험난하며, 다른 쪽은 능선이 긴 반면, 성 안은 낮고 평평한 분지를 이루고 있다.
					북한산성과 함께 한양을 지키는 2대 산성이었다.</p>
					<p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
				  </div>
				  <img class="card-img-bottom" src="/0709/image/namhan0.jpg" alt="Card image cap">
				</div>
				<br>
				<div class="card-columns">
				  <div class="card">
					<img class="card-img-top" src="/0709/image/namhan1.jpg" alt="Card image cap">
					<div class="card-body">
					  <h5 class="card-title">조선시대의 산성</h5>
					  <p class="card-text">백성과 함께 왕조가 대피할 수 있는 조선 왕실의 보장처(保障處, 전쟁 시 임금과 조정이 대피하는 곳)였다.</p>
					</div>
				  </div>
				  <div class="card p-3">
					<blockquote class="blockquote mb-0 card-body">
					  <p>“도성에서부터 약 45 내지 50킬로정도 떨어진 아주 높은 산 위에 있었는데, 가파른 오르막길을 약 15킬로 정도 올라가면 있었다. 
					  그곳은 튼튼한 요새라서 왕이 전쟁 시에 피난하는 곳이었고이 나라의 고관이 살고 있었으며, 
					  항상3년분의 식량이 저장돼 있어 수천 명의사람이 그곳에서 지낼 수 있었다. ”</p>
					  <footer class="blockquote-footer">
						<small class="text-muted">
						  하멜표류기, <cite title="Source Title">하멜</cite>
						</small>
					  </footer>
					</blockquote>
				  </div>
				  <div class="card">
					<img class="card-img-top" src="/0709/image/namhan2.jpg" alt="Card image cap">
					<div class="card-body">
					  <h5 class="card-title">남한산성 행궁</h5>
					  <p class="card-text">현재 사적 제480호이다. 조선시대에는 전국에 20개소 정도의 행궁을 두었는데 그 가운데 남한행궁은 유일하게 종묘와 사직을 두었다.(좌묘우사)</p>
					  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
					</div>
				  </div>
				  <div class="card bg-danger text-white text-center p-3">
					<blockquote class="blockquote mb-0">
					  <p>주요한 전투로는 병자호란에서 인조가 청태종의 군대를 상대로 벌인 농성전</p>
					  <footer class="blockquote-footer">
						<small>
						  Someone famous in <cite title="Source Title">병자호란</cite>
						</small>
					  </footer>
					</blockquote>
				  </div>
				  <div class="card text-center">
					<div class="card-body">
					  <h5 class="card-title">참고</h5>
					  <p class="card-text">남한산성 행궁 바로 옆에 독립운동가 만해 한용운 기념관이 있다.</p>
					  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
					</div>
				  </div>
				  <div class="card">
					<img class="card-img" src="/0709/image/namhan3.jpg" alt="Card image">
				  </div>
				  <div class="card p-3 text-right">
					<blockquote class="blockquote mb-0">
					  <p>성곽길이 좋다. 4성문(좌익문, 우익문, 지화문, 전승문)도 볼거리다.</p>
					  <footer class="blockquote-footer">
						<small class="text-muted">
						  Someone famous in <cite title="Source Title">???</cite>
						</small>
					  </footer>
					</blockquote>
				  </div>
				  <div class="card">
					<div class="card-body">
					  <h5 class="card-title">기타사항</h5>
					  <p class="card-text">2007년 1월 1일부로 남한산성 입장요금이 폐지되었다. 행궁은 어른 2천 원(경기도민은 무료), 주차요금은 승용차 기준 평일 3천 원, 주말 5천 원이다. </p>
					  <p class="card-text"><small class="text-muted">Last updated 3 mins ago</small></p>
					</div>
				  </div>
				</div>
					<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s10" style="display:none; width:100%; height:100%;">
	<!------------나 메뉴 3_2에 대한 화면-------------------->
		<!--<jsp:include page="d_01.jsp"/>-->
	<iframe id=iframe1 src='d_01_m.jsp' width=100% height=100%></iframe>
	<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s11" style="display:none; width:100%; height:100%;">
	<!-------------나 메뉴 3_3에 대한 화면------------------->
	<iframe id=iframe2 src='d_02_m.jsp' width=100% height=100%></iframe>
	<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s12" style="display:none; width:100%; height:100%;">
	<!-------------나 메뉴 4_1에 대한 화면------------------->
	<iframe id=iframe3 src='gongji/gongji_list_m.jsp' width=100% height=100%></iframe>
	<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="s13" style="display:none; width:100%; height:100%;">
	<!--------나 메뉴 4_2에 대한 화면------------------------>
	<iframe id=iframe4 src='review/review_list_m.jsp' width=100% height=100%></iframe>
	<div style="height:80px;"></div>
		<!-------------------------------->
	</div>
	<div id="m0" onclick='fncShow(0);' style="position:fixed; bottom:3px; left:1%; background-color:#409000; height:80px; width:18%; float:left;">
		<center><img src="m_btn/menu_1.png" height=85%></center>
	</div>
	<div id="m1" onclick='fncShow(1);' style="position:fixed; bottom:3px; left:21%; background-color:#409000; height:80px; width:18%; float:left;">
		<center><img src="m_btn/menu_2.png" height=85%></center>
	</div>
	<div id="m2" onclick='fncShow(2);' style="position:fixed; bottom:3px; left:41%; background-color:#409000; height:80px; width:18%; float:left;">
		<center><img src="m_btn/menu_3.png" height=85%></center>
	</div>
	<div id="m3" onclick='fncShow(3);' style="position:fixed; bottom:3px; left:61%; background-color:#409000; height:80px; width:18%; float:left;">
		<center><img src="m_btn/menu_4.png" height=85%></center>
	</div>
	<div id="m4" onclick='fncShow(4);' style="position:fixed; bottom:3px; left:81%; background-color:#409000; height:80px; width:18%; float:left;">
		<center><img src="m_btn/menu_5.png" height=85%></center>
	</div>
</div>
</center>
<script type="text/javascript">
function hide(){
	if(window.innerHeight < 500 && window.orientation == 0){
		document.getElementById("m0").style.display="none";
		document.getElementById("m1").style.display="none";
		document.getElementById("m2").style.display="none";
		document.getElementById("m3").style.display="none";
		document.getElementById("m4").style.display="none";
	} else {
		document.getElementById("m0").style.display="";
		document.getElementById("m1").style.display="";
		document.getElementById("m2").style.display="";
		document.getElementById("m3").style.display="";
		document.getElementById("m4").style.display="";
	}
}
</script>
</BODY>
</HTML>