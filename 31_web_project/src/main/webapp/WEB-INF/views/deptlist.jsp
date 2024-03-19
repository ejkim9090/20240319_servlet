<%@page import="kh.mclass.jdbc.model.vo.Dept"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%!
int sum(int a, int b){
	return a+b;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dept List</title>
</head>
<body>
[[ ${volist } ]]

Dept List
<br>
==============
<br>

<%
	List<Dept> volist = (List<Dept>)request.getAttribute("volist");
	if(volist!=null){
		if(volist.size() == 0){
%>
DEPT 데이터가 없습니다. 추가해주세요.
<%
		}else {
			for(Dept vo : volist){
out.print(vo.getDeptno() + " | " + vo.getDname() +" | "+  vo.getLoc() +" <br>" );
			}
		}
	} else {
%>
잠시 시스템이 불안정하여 잠시후 다시 확인해 주세요.
<%
	}
%>
<br>
<h1>EL (Expression Language 표현언어로 표현만가능. for,if,변수선언..등제어문없음.)</h1>
<c:forEach begin="1" end="10" step="3" var="i">
${i }<br>
</c:forEach>

<c:if test="${empty volist }">
잠시 시스템이 불안정하여 잠시후 다시 확인해 주세요.
</c:if>
<c:choose>
	<c:when test="${empty volist }">
		잠시 시스템이 불안정하여 잠시후 다시 확인해 주세요.
	</c:when>
	<c:when test="${volist.size() == 0 }">
		DEPT 데이터가 없습니다. 추가해주세요.
	</c:when>
	<c:otherwise>
		<c:forEach items="${volist }" var="vo" varStatus="vs">
		${vs.count } ||||  ${vo.deptno } | ${vo.dname }  |  ${vo.loc } |  ${vs.index }<br>
		</c:forEach>
	</c:otherwise>
</c:choose>




=======<br>
${volist.get(0).deptno } | ${volist.get(0).dname } | ${volist.get(0).loc }
${volist.get(1).getDeptno() } | ${volist.get(0).dname } | ${volist.get(0).loc }
<br>
==============
<br>
</body>
</html>



















