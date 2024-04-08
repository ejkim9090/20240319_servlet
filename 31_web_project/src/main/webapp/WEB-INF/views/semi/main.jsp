<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Semim Main</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
[[ ${sssLogin } ]] <br>
[[ <%=session.getAttribute("sssLogin") %> ]]

<h1>Semim Main</h1>
<c:choose>
	<c:when test="${empty sssLogin }">
		<div><button class="btn join">회원가입</button></div>
		<div><button class="btn login">로그인</button></div>
	</c:when>
	<c:otherwise>
		<form id="frm-logout">
		<div><button class="btn logout">로그아웃</button></div>
		</form>
		<div><button class="btn mypage">마이페이지</button></div>
	</c:otherwise>
</c:choose>

<div><button class="btn board">게시판</button></div>

<!-- 아래는 스크립트만 -->
<script>
$(loadedHandler);
function loadedHandler(){
	//event 등록
	$(".btn.join").on("click", btnJoinClickHandler);
	$(".btn.login").on("click", btnLoginClickHandler);
	$(".btn.mypage").on("click", btnMypageClickHandler);
	$(".btn.board").on("click", btnBoardClickHandler);
	$(".btn.logout").on("click", btnLogoutClickHandler);
}

function btnJoinClickHandler(){
	//window.open("${pageContext.request.contextPath}/join","_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=400,height=400");
	location.href="${pageContext.request.contextPath}/join";
}
function btnLoginClickHandler(){
	location.href="${pageContext.request.contextPath}/login";
}
function btnMypageClickHandler(){
	location.href="${pageContext.request.contextPath}/mypage";
}
function btnBoardClickHandler(){
	location.href="${pageContext.request.contextPath}/board/list";	
}
function btnLogoutClickHandler(){
	// get방식으로 사용하지 않음
	// location.href="${pageContext.request.contextPath}/logout";
	//
	
	alert("로그아웃되었습니다.");
	
	var frmlogout = document.getElementById("frm-logout");
	frmlogout.action = "${pageContext.request.contextPath}/logout";
	frmlogout.method = "post";
	frmlogout.submit();
	
	
}
</script>
</body>
</html>















