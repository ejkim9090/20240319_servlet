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
<div>아이디:<input type="text" name="id"><button type="button">중복확인</button></div>
<div>패스워드:<input type="password" name="pwd"></div>
<div>이메일:<input type="text" name="email"></div>
<div><button type="submit">회원가입</button></div>
</form>

</body>
</html>