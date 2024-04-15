<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Semim Board Write</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<jsp:include page="/WEB-INF/views/semi/common_function.jsp"/>
</head>
<body>
<h1>Semim Board Write</h1>
<form id="frm-write">
	<div><label>제목</label><input type="text" name="subject" required></div>
	<div><label>내용</label><textarea name="content" required>여기여기</textarea></div>
	<div><button type="button" class="btn file">파일추가</button></div>
	
	<div><button type="button" class="btn write" >글쓰기</button></div>
</form>

<script>
$(loadedHandler);
function loadedHandler(){
	//event 등록
	$(".btn.write").on("click", btnWriteClickHandler);
	$(".btn.file").on("click", btnFileClickHandler);
}
function btnFileClickHandler(){
	var htmlVal =`<div><input type="file" name="uploadfiles" required><button type="button" class="btn file-cancle">취소</button></div> `;
	$(this).parent().after(htmlVal);
	$(".btn.file-cancle").off("click");
	$(".btn.file-cancle").on("click", btnFileCancleClickHandler);
}
function btnFileCancleClickHandler(){
	console.log("btnFileCancleClickHandler");
	$(this).parent().remove();
	
}
function btnWriteClickHandler(){
	
	//Login 페이지로 이동
	if(checkLogin("로그인되어야 글쓰기가 가능합니다.\n로그인페이지로 이동하시겠습니까?","write")){
		return;
	}
	
	console.log($("[name=content]").val().length);  // 사용자 입력값은 value가 진짜임.
	console.log($("[name=content]").val().trim().length);
	//console.log($("[name=content]").html());
	//console.log($("[name=content]").text());
	
	if($("[name=subject]").val().trim().length == 0){
	   alert("빈문자열만 입력할 수 없습니다. 제목을 작성해주세요.");
	   return;
    }
	if($("[name=content]").val().trim().length == 0){
	   alert("빈문자열만 입력할 수 없습니다. 내용을 작성해주세요.");
	   return;
	}
	var frm = document.getElementById("frm-write");
	frm.method="post";  // content 길이 길거라..
	frm.action = "${pageContext.request.contextPath}/board/write";
	frm.enctype="multipart/form-data";  // form 태그 내부에 input type="file"이 있다면
	frm.submit();	
}
</script>
</html>










