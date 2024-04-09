<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Semim Board List</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<jsp:include page="/WEB-INF/views/semi/common_function.jsp"/>
</head>
<body>
[[ 로그인 정보 : ${sssLogin} ]]
<h1>Semim Board List</h1>
[[${dtolist }]] - blank <br> 
[[<%=request.getAttribute("dtolist") %>]] - null

<div><button type="button" class="btn write" >글쓰기</button></div>

<script>
$(loadedHandler);
function loadedHandler(){
	//event 등록
	$(".btn.write").on("click", btnWriteClickHandler);
}

function btnWriteClickHandler(){
	
	//Login 페이지로 이동
	if(checkLogin("로그인되어야 글쓰기가 가능합니다.\n로그인페이지로 이동하시겠습니까?","write")){
		return;
	}
	
	location.href="${pageContext.request.contextPath}/board/write";
}
</script>
</html>