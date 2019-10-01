<!DOCTYPE html>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<%@ page import="java.net.*"%>
<meta charset="utf-8">
<html>
	<head>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
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
	</head>
		<body background='/0709/background.jpg'>
		<center><br>
		<div class='outline' >
		
<div class="card bg-dark text-white">
  <img class="card-img" src="trump.png" alt="Card image">
  <div class="card-img-overlay" style="text-align:left">
    <h3 class="card-title">개구리조트</h3>
    <p class="card-text">"고품격 Refresh를 제공하는 생활 속의 리조트"를 컨셉으로 개발된 개구리조트는 </p>
    <p class="card-text">별거 없는 시설을 갖춘 사계절 종합리조트입니다.</p>
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

<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style='background-color:black; width:600px; height:auto'>
  <ol class="carousel-indicators">
    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
	    <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
		    <li data-target="#carouselExampleIndicators" data-slide-to="4"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="5"></li>
  </ol>
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img style="margin: auto" src="/0709/image/home1.jpg" class="d-block w-30" alt="...">
	  <div class="carousel-caption d-none d-md-block text_border">
    <h5>개굴</h5>
    <p>개굴개굴....</p>
  </div>
    </div>
    <div class="carousel-item">
      <img style="margin: auto" src="/0709/image/home2.jpg" class="d-block w-30" alt="...">
	  <div class="carousel-caption d-none d-md-block text_border">
    <h5>이벤트</h5>
    <p>~07/10 까지 할인 -5%</p>
  </div>
    </div>
    <div class="carousel-item">
      <img style="margin: auto" src="/0709/image/home3.jpg" class="d-block w-30" alt="...">
	  <div class="carousel-caption d-none d-md-block text_border">
    <h5>풍광</h5>
    <p>개굴개굴개굴개굴<br>개굴개굴개굴개굴개굴개굴</p>
  </div>
    </div>

    <div class="carousel-item">
      <img style="margin: auto" src="/0709/image/lobby.jpg" class="d-block w-30" alt="...">
	  <div class="carousel-caption d-none d-md-block text_border">
    <h5>개굴</h5>
    <p>개굴개굴....</p>
  </div>
    </div>
    <div class="carousel-item">
      <img style="margin: auto" src="/0709/image/pond.jpg" class="d-block w-30" alt="...">
	  <div class="carousel-caption d-none d-md-block text_border">
    <h5>이벤트</h5>
    <p>~07/10 까지 할인 -5%</p>
  </div>
    </div>
    <div class="carousel-item">
      <img style="margin: auto" src="/0709/image/wall.jpg" class="d-block w-30" alt="...">
	  <div class="carousel-caption d-none d-md-block text_border">
    <h5>풍광</h5>
    <p>개굴개굴개굴개굴<br>개굴개굴개굴개굴개굴개굴</p>
  </div>
    </div>


  </div>
  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

<br>

<div class="card" style="width: 55rem;">
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

	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
	
		<script>  $('.carousel').carousel({
		  interval: 2000
		})</script>
		</div>
</center>
<div id=fixed><a href='d_01.jsp' target=main><img width=200 src='/0709/image/back.png'></a></div>
	</body>
<%
	Calendar cal = Calendar.getInstance();
	
	SimpleDateFormat df = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초", Locale.KOREAN);
	String visit = URLEncoder.encode(df.format(cal.getTime()), "UTF-8");
	Cookie cookieName = new Cookie("recentVisit", visit);
	cookieName.setMaxAge(-1);	//브라우저 켜있을때 까지
	response.addCookie(cookieName);	//response객체에 보내야 사용가능함

%>
</html>