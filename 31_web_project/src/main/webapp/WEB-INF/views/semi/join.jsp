<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Semim Join</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<h1>Semim Join</h1>

<form action="${pageContext.request.contextPath }/join" method="post">
<div>아이디:<input type="text" name="id"><button type="button" class="btn checkid">중복확인</button></div>
<div>패스워드:<input type="password" name="pwd"></div>
<div>이메일:<input type="text" name="email"></div>
<div><button type="submit">회원가입</button></div>
</form>

<div class="member-list">
	
</div>

<!-- 꼬다리 스크립트위치  -->
<script>
$(loadedHandler);
function loadedHandler(){
	//event 등록
	$(".btn.checkid").on("click", btnCheckidClickHandler);
}
function btnCheckidClickHandler(){
	var idVal = $("[name=id]").val();
	$.ajax( { 
		async : false, 
		url : "${pageContext.request.contextPath }/checkid.ajax"
		,method : "post"
		,data : { cid : $("[name=id]").val(), k1:"v1", k2:"v2" }
		///////////// contentType 은 data의 자료형
		
		///////////// dataType은 success의 result 의 자료형
//		,dataType : "json"
		,success : function(result){ 
			console.log(result);
			if(result > 0){
				alert("사용불가!! 다른아이디를 사용해주세요.");
			}else {
				alert("사용가능");
			}	
			
			/*
			console.log(typeof result);
			//[ {},{}]
			var htmlVal = '';
			$.each(result, function(){
				console.log(this.memEmail);
				// 백틱
				htmlVal += '<div>'+this.memEmail+'</div>';
			});
			$(".member-list").html(htmlVal);
			*/
		}
		,error : function(request, status, error){
			alert("code: "+request.status + "\n" + "message: " 
					+ request.responseText + "\n"
					+ "error: "+error);
		}
	} );

}






















</script>
</body>
</html>