<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Semim Board List</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<jsp:include page="/WEB-INF/views/semi/common_function.jsp"/>
<style>
.board.grid{
	display:grid;
	grid-template-columns: 1fr 5fr 3fr 2fr 1fr;
}
.board.grid > div{
	display : flex;
	border : 1px solid black;
	text-align: center;
}
ul {
list-style-type:none;
}
ul > li {
display: inline-block;
padding: 0 10px;
}
</style>
</head>
<body>
[[ 로그인 정보 : ${sssLogin} ]]<br>
[[ map : ${map.dtolist }]]<br>
[[ totalPageCount : ${map.totalPageCount }]]<br>
[[ startPageNum : ${map.startPageNum }]]<br>
[[ endPageNum : ${map.endPageNum }]]<br>
<h1>Semim Board List</h1>

	
<div><button type="button" class="btn write" >글쓰기</button></div>
<div class="board grid">
<c:choose>
	<c:when test="${empty map.dtolist }">
	글 없어요.
	</c:when>
	<c:otherwise>
		<c:forEach items="${map.dtolist }" var="vo" varStatus="vs">
			<div>${vo.boardId }</div>
			<div><a href="${pageContext.request.contextPath }/board/read?id=${vo.boardId }">${vo.subject }</a></div>
			<div>${vo.writeTime }</div>
			<div>${vo.boardWriter }</div>
			<div>${vo.readCount }</div>
		</c:forEach>
	</c:otherwise>
</c:choose>
</div>

<div >
	<ul>
	<c:if test="${map.startPageNum > 1}">
		<li><a href="${pageContext.request.contextPath }/board/list?page=${map.startPageNum-1 }">  &lt;&lt; </a></li>
	</c:if>
	<c:forEach begin="${map.startPageNum }" end="${map.endPageNum }" var="page">
		<c:if test="${map.currentPageNum == page }">
		<li><strong>${page }</strong></li>
		</c:if>
		<c:if test="${map.currentPageNum != page }">
		<li><a href="${pageContext.request.contextPath }/board/list?page=${page }">${page }</a></li>
		</c:if>
	</c:forEach>
	<c:if test="${map.endPageNum < map.totalPageCount }">
		<li><a href="${pageContext.request.contextPath }/board/list?page=${map.endPageNum+1 }">  &gt;&gt; </a></li>
	</c:if>
	</ul>
</div>

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