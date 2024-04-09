<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Semim Board List</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
<h1>Semim Board List</h1>
[[${dtolist }]] <br>
[[<%=request.getAttribute("dtolist") %>]]
</html>