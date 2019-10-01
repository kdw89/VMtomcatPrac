<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*,java.net.*,java.lang.*" %>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>


<html>
<head>
<title>환율정보</title>
	<script src="Chart.min.js"></script>
	<script src="utils.js"></script>
	<!--<script src="analyser.js"></script>-->
	<!--<script src="moment.min.js"></script>-->
	
<style>
	canvas {
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	</style>
</head>
<body style="text-align:center;">
<%

JSONParser parser = new JSONParser();

Calendar cal = Calendar.getInstance();
SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
SimpleDateFormat df2 = new SimpleDateFormat("MMM d");

String days[] = new String[30];
String usd_ttb[] = new String[30];
String usd_tts[] = new String[30];
String cnh_ttb[] = new String[30];
String cnh_tts[] = new String[30];
String jpy_ttb[] = new String[30];
String jpy_tts[] = new String[30];
String eur_ttb[] = new String[30];
String eur_tts[] = new String[30];
String gbp_ttb[] = new String[30];
String gbp_tts[] = new String[30];
String aud_ttb[] = new String[30];
String aud_tts[] = new String[30];
String cad_ttb[] = new String[30];
String cad_tts[] = new String[30];
String nzd_ttb[] = new String[30];
String nzd_tts[] = new String[30];

String str_days = "";
String usd_str_ttb = "";
String usd_str_tts = "";
String cnh_str_ttb = "";
String cnh_str_tts = "";
String jpy_str_ttb = "";
String jpy_str_tts = "";
String eur_str_ttb = "";
String eur_str_tts = "";
String gbp_str_ttb = "";
String gbp_str_tts = "";
String aud_str_ttb = "";
String aud_str_tts = "";
String cad_str_ttb = "";
String cad_str_tts = "";
String nzd_str_ttb = "";
String nzd_str_tts = "";

String getTTB = "";
String getTTS = "";
cal.add(cal.DATE,-29);
%>
<select name="cur" id="cur" onchange="getCur(this)" style="font-size:large; width:50%; height:40px;">
		<option value="">환율정보 : 화폐 선택</option>
		<option value="USD">미국 달러</option>
		<option value="CNH">중국 위안</option>
		<option value="JPY">일본 엔</option>
		<option value="EUR">유로</option>
		<option value="GBP">영국 파운드</option>
		<option value="AUD">호주 달러</option>
		<option value="CAD">캐나다 달러</option>
		<option value="NZD">뉴질랜드 달러</option>
</select>

<%
for(int i=0; i<30; i++) {
	
	days[i] = df2.format(cal.getTime());
	URL oracle = new URL("https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=k1e9kW482chvY8gw05YdMJOJguVf5cYJ&searchdate="+df.format(cal.getTime())+"&data=AP01"); // URL to Parse
	URLConnection yc = oracle.openConnection();
	BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream()));
	usd_ttb[i] = "0";
	usd_tts[i] = "0";
	cnh_ttb[i] = "0";
	cnh_tts[i] = "0";
	jpy_ttb[i] = "0";
	jpy_tts[i] = "0";
	eur_ttb[i] = "0";
	eur_tts[i] = "0";
	gbp_ttb[i] = "0";
	gbp_tts[i] = "0";
	aud_ttb[i] = "0";
	aud_tts[i] = "0";
	cad_ttb[i] = "0";
	cad_tts[i] = "0";
	nzd_ttb[i] = "0";
	nzd_tts[i] = "0";
	
	String inputLine;
	while ((inputLine = in.readLine()) != null) {
		JSONArray a = (JSONArray) parser.parse(inputLine);

		for (Object o : a) {
			JSONObject tutorials = (JSONObject) o;
			
			switch(tutorials.get("cur_unit").toString()) {
				case "USD" :
					getTTB = (String) tutorials.get("ttb");
					usd_ttb[i] = getTTB.replace(",","");
					getTTS = (String) tutorials.get("tts");
					usd_tts[i] = getTTS.replace(",","");
					break;
					
				case "CNH" :
					getTTB = (String) tutorials.get("ttb");
					cnh_ttb[i] = getTTB.replace(",","");
					getTTS = (String) tutorials.get("tts");
					cnh_tts[i] = getTTS.replace(",","");
					break;
					
				case "JPY(100)" :
					getTTB = (String) tutorials.get("ttb");
					jpy_ttb[i] = getTTB.replace(",","");
					getTTS = (String) tutorials.get("tts");
					jpy_tts[i] = getTTS.replace(",","");
					break;
					
				case "EUR" :
					getTTB = (String) tutorials.get("ttb");
					eur_ttb[i] = getTTB.replace(",","");
					getTTS = (String) tutorials.get("tts");
					eur_tts[i] = getTTS.replace(",","");
					break;
					
				case "GBP" :
					getTTB = (String) tutorials.get("ttb");
					gbp_ttb[i] = getTTB.replace(",","");
					getTTS = (String) tutorials.get("tts");
					gbp_tts[i] = getTTS.replace(",","");
					break;
					
				case "AUD" :
					getTTB = (String) tutorials.get("ttb");
					aud_ttb[i] = getTTB.replace(",","");
					getTTS = (String) tutorials.get("tts");
					aud_tts[i] = getTTS.replace(",","");
					break;
					
				case "CAD" :
					getTTB = (String) tutorials.get("ttb");
					cad_ttb[i] = getTTB.replace(",","");
					getTTS = (String) tutorials.get("tts");
					cad_tts[i] = getTTS.replace(",","");
					break;
				
				case "NZD" :
					getTTB = (String) tutorials.get("ttb");
					nzd_ttb[i] = getTTB.replace(",","");
					getTTS = (String) tutorials.get("tts");
					nzd_tts[i] = getTTS.replace(",","");
					break;
			}
		}
	}
	
	cal.add(cal.DATE,+1);
}


for(int j=0; j<days.length; j++)
{
	if(j==0) { 
		if(usd_ttb[j] == "0" || usd_tts[j] == "0") {
			str_days = "";
			usd_str_ttb = "";
			usd_str_tts = "";
		} else {
			str_days = "'"+days[j]+"'";
			usd_str_ttb = "'"+usd_ttb[j]+"'";
			usd_str_tts = "'"+usd_tts[j]+"'";
		}
		
		if(cnh_ttb[j] == "0" || cnh_tts[j] == "0") {
			cnh_str_ttb = "";
			cnh_str_tts = "";
		} else {
			cnh_str_ttb = "'"+cnh_ttb[j]+"'";
			cnh_str_tts = "'"+cnh_tts[j]+"'";
		}
		
		if(jpy_ttb[j] == "0" || jpy_tts[j] == "0") {
			jpy_str_ttb = "";
			jpy_str_tts = "";
		} else {
			jpy_str_ttb = "'"+jpy_ttb[j]+"'";
			jpy_str_tts = "'"+jpy_tts[j]+"'";
		}

		if(eur_ttb[j] == "0" || eur_tts[j] == "0") {
			eur_str_ttb = "";
			eur_str_tts = "";
		} else {
			eur_str_ttb = "'"+eur_ttb[j]+"'";
			eur_str_tts = "'"+eur_tts[j]+"'";
		}
		
		if(gbp_ttb[j] == "0" || gbp_tts[j] == "0") {
			gbp_str_ttb = "";
			gbp_str_tts = "";
		} else {
			gbp_str_ttb = "'"+gbp_ttb[j]+"'";
			gbp_str_tts = "'"+gbp_tts[j]+"'";
		}
		
		if(aud_ttb[j] == "0" || aud_tts[j] == "0") {
			aud_str_ttb = "";
			aud_str_tts = "";
		} else {
			aud_str_ttb = "'"+aud_ttb[j]+"'";
			aud_str_tts = "'"+aud_tts[j]+"'";
		}
		
		if(cad_ttb[j] == "0" || cad_tts[j] == "0") {
			cad_str_ttb = "";
			cad_str_tts = "";
		} else {
			cad_str_ttb = "'"+cad_ttb[j]+"'";
			cad_str_tts = "'"+cad_tts[j]+"'";
		}
		
		if(nzd_ttb[j] == "0" || nzd_tts[j] == "0") {
			nzd_str_ttb = "";
			nzd_str_tts = "";
		} else {
			nzd_str_ttb = "'"+nzd_ttb[j]+"'";
			nzd_str_tts = "'"+nzd_tts[j]+"'";
		}
		
	} else {
		if(usd_ttb[j] == "0" || usd_tts[j] == "0") {
			str_days = str_days + "";
			usd_str_ttb = usd_str_ttb + "";
			usd_str_tts = usd_str_tts + "";
		} else {
			str_days = str_days + ",'"+days[j]+"'";
			usd_str_ttb = usd_str_ttb + ",'"+usd_ttb[j]+"'";
			usd_str_tts = usd_str_tts + ",'"+usd_tts[j]+"'";
		}
		
		if(cnh_ttb[j] == "0" || cnh_tts[j] == "0") {
			cnh_str_ttb = cnh_str_ttb + "";
			cnh_str_tts = cnh_str_tts + "";
		} else {
			cnh_str_ttb = cnh_str_ttb + ",'"+cnh_ttb[j]+"'";
			cnh_str_tts = cnh_str_tts + ",'"+cnh_tts[j]+"'";
		}
		
		if(jpy_ttb[j] == "0" || jpy_tts[j] == "0") {
			jpy_str_ttb = jpy_str_ttb + "";
			jpy_str_tts = jpy_str_tts + "";
		} else {
			jpy_str_ttb = jpy_str_ttb + ",'"+jpy_ttb[j]+"'";
			jpy_str_tts = jpy_str_tts + ",'"+jpy_tts[j]+"'";
		}
		
		if(eur_ttb[j] == "0" || eur_tts[j] == "0") {
			eur_str_ttb = eur_str_ttb + "";
			eur_str_tts = eur_str_tts + "";
		} else {
			eur_str_ttb = eur_str_ttb + ",'"+eur_ttb[j]+"'";
			eur_str_tts = eur_str_tts + ",'"+eur_tts[j]+"'";
		}
		
		if(gbp_ttb[j] == "0" || gbp_tts[j] == "0") {
			gbp_str_ttb = gbp_str_ttb + "";
			gbp_str_tts = gbp_str_tts + "";
		} else {
			gbp_str_ttb = gbp_str_ttb + ",'"+gbp_ttb[j]+"'";
			gbp_str_tts = gbp_str_tts + ",'"+gbp_tts[j]+"'";
		}
		
		if(aud_ttb[j] == "0" || aud_tts[j] == "0") {
			aud_str_ttb = aud_str_ttb + "";
			aud_str_tts = aud_str_tts + "";
		} else {
			aud_str_ttb = aud_str_ttb + ",'"+aud_ttb[j]+"'";
			aud_str_tts = aud_str_tts + ",'"+aud_tts[j]+"'";
		}
		
		if(cad_ttb[j] == "0" || cad_tts[j] == "0") {
			cad_str_ttb = cad_str_ttb + "";
			cad_str_tts = cad_str_tts + "";
		} else {
			cad_str_ttb = cad_str_ttb + ",'"+cad_ttb[j]+"'";
			cad_str_tts = cad_str_tts + ",'"+cad_tts[j]+"'";
		}

		if(nzd_ttb[j] == "0" || nzd_tts[j] == "0") {
			nzd_str_ttb = nzd_str_ttb + "";
			nzd_str_tts = nzd_str_tts + "";
		} else {
			nzd_str_ttb = nzd_str_ttb + ",'"+nzd_ttb[j]+"'";
			nzd_str_tts = nzd_str_tts + ",'"+nzd_tts[j]+"'";
		}
		
	}

}

//in.close();

%>
	
	<div style="width:85%; text-align:center;">
		<canvas id="canvas"></canvas>
	</div>
	<script>
		var USD_ttb = [<%=usd_str_ttb%>];
		var USD_tts = [<%=usd_str_tts%>];
		var CNH_ttb = [<%=cnh_str_ttb%>];
		var CNH_tts = [<%=cnh_str_tts%>];
		var JPY_ttb = [<%=jpy_str_ttb%>];
		var JPY_tts = [<%=jpy_str_tts%>];
		var EUR_ttb = [<%=eur_str_ttb%>];
		var EUR_tts = [<%=eur_str_tts%>];
		var GBP_ttb = [<%=gbp_str_ttb%>];
		var GBP_tts = [<%=gbp_str_tts%>];
		var AUD_ttb = [<%=aud_str_ttb%>];
		var AUD_tts = [<%=aud_str_tts%>];
		var CAD_ttb = [<%=cad_str_ttb%>];
		var CAD_tts = [<%=cad_str_tts%>];
		var NZD_ttb = [<%=nzd_str_ttb%>];
		var NZD_tts = [<%=nzd_str_tts%>];
		
		var config = {
			type: 'line',
			data: {
				labels: [<%=str_days%>],
				datasets: [{
					label: 'TTB - 전신환(송금) 받으실때',
					backgroundColor: window.chartColors.red,
					borderColor: window.chartColors.red,
					data: [
						<%=usd_str_ttb%>
					],
					fill: false,
				}, {
					label: 'TTS - 전신환(송금) 보내실때',
					fill: false,
					backgroundColor: window.chartColors.blue,
					borderColor: window.chartColors.blue,
					data: [
						<%=usd_str_tts%>
					],
				}]
			},
			options: {
				responsive: true,
				title: {
					display: true,
					text: '환율정보(USD), 최근 30일'
				},
				tooltips: {
					mode: 'index',
					intersect: false,
				},
				hover: {
					mode: 'nearest',
					intersect: true
				},
				scales: {
					xAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: '날짜'
						}
					}],
					yAxes: [{
						display: true,
						scaleLabel: {
							display: true,
							labelString: '환율'
						}
					}]
				}
			}
		};

		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myLine = new Chart(ctx, config);
		};

function getCur(selectObject) {
    var value = selectObject.value;
	
	switch(value) {
		case "USD" :
			myLine.options.title.text = "환율정보(USD), 최근 30일";
			for(var i=0; i<30; i++) {
				myLine.data.datasets[0].data[i] = USD_ttb[i];
				myLine.data.datasets[1].data[i] = USD_tts[i];
			}
			break;
			
		case "CNH" :
			myLine.options.title.text = "환율정보(CNH), 최근 30일";
			for(var i=0; i<30; i++) {
				myLine.data.datasets[0].data[i] = CNH_ttb[i];
				myLine.data.datasets[1].data[i] = CNH_tts[i];
			}		
			break;
			
		case "JPY" :
			myLine.options.title.text = "환율정보(JPY(100)), 최근 30일";
			for(var i=0; i<30; i++) {
				myLine.data.datasets[0].data[i] = JPY_ttb[i];
				myLine.data.datasets[1].data[i] = JPY_tts[i];
			}
			break;
		
		case "EUR" :
			myLine.options.title.text = "환율정보(EUR), 최근 30일";
			for(var i=0; i<30; i++) {
				myLine.data.datasets[0].data[i] = EUR_ttb[i];
				myLine.data.datasets[1].data[i] = EUR_tts[i];
			}
			break;
			
		case "GBP" :
			myLine.options.title.text = "환율정보(GBP), 최근 30일";
			for(var i=0; i<30; i++) {
				myLine.data.datasets[0].data[i] = GBP_ttb[i];
				myLine.data.datasets[1].data[i] = GBP_tts[i];
			}
			break;
			
		case "AUD" :
			myLine.options.title.text = "환율정보(AUD), 최근 30일";
			for(var i=0; i<30; i++) {
				myLine.data.datasets[0].data[i] = AUD_ttb[i];
				myLine.data.datasets[1].data[i] = AUD_tts[i];
			}
			break;
			
		case "CAD" :
			myLine.options.title.text = "환율정보(CAD), 최근 30일";
			for(var i=0; i<30; i++) {
				myLine.data.datasets[0].data[i] = CAD_ttb[i];
				myLine.data.datasets[1].data[i] = CAD_tts[i];
			}
			break;
			
		case "NZD" :
			myLine.options.title.text = "환율정보(NZD), 최근 30일";
			for(var i=0; i<30; i++) {
				myLine.data.datasets[0].data[i] = NZD_ttb[i];
				myLine.data.datasets[1].data[i] = NZD_tts[i];
			}
			break;
	}

	window.myLine.update();
}
	</script>
</body>
</html>