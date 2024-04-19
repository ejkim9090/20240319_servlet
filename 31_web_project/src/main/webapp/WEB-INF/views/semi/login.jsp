<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Semim Login</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<jsp:include page="/WEB-INF/views/semi/common_function.jsp"/>
<script>
// 경고 메시지
alertMsg("${param.alertMsg }");
</script>
</head>
<body>
[[ url: ${param.url }, ${param.alertMsg }]]
<h1>Semim Login</h1>
<fieldset>
	<legend>로그인 form - 현재 controller 동작 안하여 삭제함. </legend>
</fieldset>

<fieldset>
	<legend>로그인 ajax</legend>
	<form id="frm-login">
		<div><label>아이디</label><input type="text" name="id"></div>
		<div><label>패스워드</label><input type="password" name="pwd"></div>
		<div><input type="button" value="로그인" class="btn submit"></div>
	</form>
</fieldset>

<script>
$(loadedHandler);
function loadedHandler(){
	//event 등록
	$("#frm-login .btn.submit").on("click", frmClickHandler);
}

function frmClickHandler(){
	console.log("클릭");
	//console.log(document.getElementById("frm-login").serialize());
	console.log($("#frm-login").serialize()); // query string 형태로 만들어줌.// id=sss&pwd=vvv
	//{id : $("#frm-login [name=id]").val() , pwd : $("#frm-login [name=pwd]").val()  }	
	//$("#frm-login").serialize()
	let preUrl = "${param.url }";
	preUrl = (preUrl) ? "?url="+preUrl : "";
	console.log("preUrl : "+preUrl);
	$.ajax({
		url:"${pageContext.request.contextPath }/login"+preUrl
		, method : "post"
		, data : $("#frm-login").serialize()
		, success : function(result){
			console.log(result);
			if(result == 1 ){
				alert("반갑습니다.");
				if(preUrl){
					// 이전페이지로 이동
					location.href="${param.url }";
				} else {
					location.href="${pageContext.request.contextPath}/main";
				}
			}else {
				alert("아이디 또는 패스워드가 일치하지 않습니다.\n다시 확인하고 로그인해주세요.");
				$("[name=pwd]").val("");
			}
		}
		,error : function(request, status, error){
			alert("code: "+request.status + "\n" + "message: " 
					+ request.responseText + "\n"
					+ "error: "+error);
		}
	});
	
}

</script>






























</body>
</html>