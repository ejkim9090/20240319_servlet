<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dept List</title>
</head>
<body>
<h1>Dept List</h1>
<c:choose>
	<c:when test="${empty volist }">
	dept 못 읽어요
	</c:when>
	<c:when test="${volist.size()==0 }">
	dept 없어요
	</c:when>
	<c:otherwise>
		<c:forEach items="${volist }" var="vo" varStatus="vs">
			${vs.count }|| ${vo.deptno }| ${vo.dname }| ${vo.loc } <br>
		</c:forEach>
	</c:otherwise>
</c:choose>
<h1>부서추가</h1>
<div>
	<form method="post" action="<%=request.getContextPath() %>/dept/insert"  target="_blank">
        <input type="text" name="deptno" >
        <input type="text" name="dname" >
        <input type="text" name="loc" value="seoul">
        <input type="submit" value="post제출">
        <input type="reset" value="초기화말고다른이름">
    </form>
</div>
<div>
	<form method="get" action="<%=request.getContextPath() %>/dept/insert"  target="_blank">
        <input type="text" name="deptno" >
        <input type="text" name="dname" >
        <input type="text" name="loc" value="seoul">
        <input type="submit" value="get제출">
        <input type="reset" value="초기화말고다른이름">
    </form>
</div>
<h1>부서삭제</h1>
<div>
	<form method="post" action="<%=request.getContextPath() %>/dept/delete"  target="_blank">
        <input type="text" name="deptno" >
        <input type="submit" value="제출말고다른이름">
    </form>
</div>










</body>
</html>