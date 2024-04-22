<%@page import="kh.mclass.common.AladinXML"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OpenApi Test</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
	<h1>OpenApi 테스트용</h1>
	<form action="${pageContext.request.contextPath }/openapi" method="post">
		<div><label>lawdCd : </label><input type="text" name="lawdCd" value="11110"></div>
		<div><label>dealYMD : </label><input type="text" name="dealYMD" value="201512"></div>
		<div><button type="submit">확인ee-console</button></div>		
	</form>
	
	
	<form id="frm-ajax">
		<div><label>lawdCd : </label><input type="text" name="lawdCd" value="11110"></div>
		<div><label>dealYMD : </label><input type="text" name="dealYMD" value="201512"></div>
		<div><button type="button" class="btn openapi redigo">확인f12-console</button></div>		
	</form>
	
	<form id="frm-ajax2">
		<div><label> : </label><input type="text" name="" value=""></div>
		<div><label> : </label><input type="text" name="" value=""></div>
		<div><button type="button" class="btn openapi exam">확인f12-console</button></div>		
	</form>
	
	<fieldset>
	<legend>날씨</legend>
	<form id="frm-ajax-weather">
		<div><label>nx : </label><input type="text" name="nx" value="55"></div>
		<div><label>ny : </label><input type="text" name="ny" value="127"></div>
		<div><button type="button" class="btn openapi weather">확인f12-console</button></div>		
	</form>
	</fieldset>
	
<script>
$(loadedHandler);
function loadedHandler(){
	//event 등록
	$(".btn.openapi.redigo").on("click", btnOpenApiClickHandler);
	$(".btn.openapi.exam").on("click", btnOpenApiExamClickHandler);
	$(".btn.openapi.weather").on("click", btnOpenApiWeatherClickHandler);
}
function callbackHandler(result){
	console.log("-----");
	console.log(result);
}
function errorCallback(request, status, error){
	alert("code: "+request.status + "\n" + "message: " 
			+ request.responseText + "\n"
			+ "error: "+error);
}

function btnOpenApiWeatherClickHandler (){
	var basedUrl = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst";
	var serviceKeyVal = "=wDDeL0LFjIoRuO317GpfgOEgr%2B399wsB0qnv3gaKz6aQxDMz%2BOT9u1%2FMYEye0pW8EN9QZJdlN4cfyE2lI9SPkw%3D%3D";
	// 오늘 날짜
	const today = new Date(); // 년도
	const year = today.getFullYear(); // 월
	const month = (today.getMonth() + 1).toString().padStart(2, '0');  // 일
	const day = today.getDate().toString().padStart(2, '0'); // yyyymmdd
	const hh = today.getHours()+9; // 미국시간 기준이니까 9를 더해주면 대한민국 시간됨
	const nowStr = `\${year}\${month}\${day}`;
	const nowStrHour = hh+'00'; 
	console.log(nowStr);

	var sendData = {
			serviceKey: serviceKeyVal, 
			pageNo: "1",
			numOfRows: "1000",
			dataType : "xml",
			base_date : nowStr,
			base_time : nowStrHour,
			nx: encodeURIComponent($("[name=nx]").val()),
			ny: encodeURIComponent($("[name=ny]").val())
	};
	
	$.ajax({
		url:basedUrl
		,method:"get"
//		,contentType: "application/json; charset=utf-8"
//		,data: sendDataJson
		,data: sendData
		,dataType : "xml"
		,success: callbackHandler
		,error : errorCallback
	});
}
function btnOpenApiClickHandler(){
	//var basedUrl = "http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev";
	var basedUrl = "http://openapi.molit.go.kr:8081/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTrade";
	var sendData = {
			serviceKey: encodeURIComponent("${serviceKey}"), 
			pageNo: "1",
			numOfRows: "10",
			LAWD_CD: encodeURIComponent($("[name=lawdCd]").val()),
			DEAL_YMD: encodeURIComponent($("[name=dealYMD]").val())
			//,callback: callbackHandler
//			returnType: ""
	};
	var sendDataJson = JSON.stringify(sendData);
	console.log(sendData);
	console.log(sendDataJson);
	
	$.ajax({
		url:basedUrl
		,method:"get"
//		,contentType: "application/json; charset=utf-8"
//		,data: sendDataJson
		,data: sendData
		,dataType: "jsonp"
	});
	
}

</script>

<script>
function btnOpenApiExamClickHandler(){
	var xhr = new XMLHttpRequest();
	var url = 'http://apis.data.go.kr/B490007/qualExamSchd/getQualExamSchdList';
	var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + encodeURIComponent('t+MBfXyUlsCG64LCFFpv/VotwMILtIfeNO7zAeIjdTWYPTgoNLBWkbOaqy9OXo3PMctejj/Xe7pWVinitw3AUg==');
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('10'); 
	queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
	queryParams += '&' + encodeURIComponent('dataFormat') + '=' + encodeURIComponent('json'); 
	queryParams += '&' + encodeURIComponent('implYy') + '=' + encodeURIComponent('2023'); 
	queryParams += '&' + encodeURIComponent('qualgbCd') + '=' + encodeURIComponent('T'); 
	queryParams += '&' + encodeURIComponent('jmCd') + '=' + encodeURIComponent('7910');
	xhr.open('GET', url + queryParams);
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4) {
	        alert('Status: '+this.status+'nHeaders: '+JSON.stringify(this.getAllResponseHeaders())+'nBody: '+this.responseText);
	    }
	};
	xhr.send('');
}
</script>
	<input type="button" id="xml1" name="xml1" value="xml1">
	<input type="button" id="xml2" name="xml2" value="xml2">
	<input type="button" id="json1" name="json1" value="json1">
	<input type="button" id="json2" name="json2" value="json2">
	<div id="progress"></div>

<script>
	function abc(data1) {
		console.log(typeof data1 + " : " + data1);
		var str1 = JSON.stringify(data1); 
		console.log(typeof str1 + " : " + str1);
		$("#progress").text(str1);
		//하나씩 db에 넣어주는 코드 작성.
	}
	function defg(data1) {
		console.log(typeof data1 + " : " + data1);
		$.ajax({
			url:"ItemSearch_20131101.xml",
			cache:false,
			dataType: "xml",
			success: function(data1){
				$(data1).find("item").each(function(){
					$("#progress").append( $(this).find("title").text() + " : " +
											$(this).find("isbn").text() + "<br>" );	
				});
			},
			error: function(e) {
				alert("Error loading XML file");	
			}			
		});
	}
	$(function() {
		$("#json1").on('click', function() {
			// url http://www.aladin.co.kr/ttb/api/ItemList.aspx
			// ttp://www.aladin.co.kr/ttb/api/ItemList.aspx?ttbkey=TTBKey&QueryType=ItemNewAll&MaxResults=10&start=1&SearchTarget=Book&output=xml&Version=20131101
			$.ajax({
				method : "get",
				dataType : "jsonp",
				url : "http://www.aladin.co.kr/ttb/api/ItemList.aspx",
				data : {
					ttbkey : "ttbhagalaz04301822001",
					QueryType : "ItemNewAll",
					SearchTarget : "Book",
					Version : 20131101,
					output : "JS",
					cover : "big",
					callback : "abc",
				},
				Start : 1,
				MaxResults : 100
			});
		});
		$("#xml1").on('click', function() {
			<%
			AladinXML axml = new AladinXML();
			axml.testAladdinOpenAPI("a");
			%>
		});
		$("#xml2").on('click', function() {
			defg();
		});
	});
</script>
</body>
</html>