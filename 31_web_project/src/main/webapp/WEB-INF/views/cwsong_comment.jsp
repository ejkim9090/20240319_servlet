<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.List" %>
<%@ page import = "kh.mclass.jdbc.model.vo.Dept" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- core에 있는 클래스들에서 제공해주는 것 다 사용 가능 -->
<!-- prefix 은 내가 정하고 uri 은 반드시 이거 써야함 -->
<%!

int sum(int a, int b) {
	return a + b;
}


%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dept List</title>
</head>
<body>
<h1>Dept list</h1>

<%-- ${data1 }  --%>
<%-- <%= request.getAttribute("volist") %> --%>
<!-- //값 꺼내는 곳 => 이렇게 쓰면 toString 이 보임 -->
<br>
<% 
/* data2는 넣을때 String 형태 넣어서 꺼냈을 때 String 모양으로 받아서 처리 */
//String data2 = (String)request.getAttribute("data2");
/* Integer data3 = (Integer)request.getAttribute("data3"); => data3는 int형 넣어서 casting 은 int로 함 */
%>
<br>

<%
List<Dept> volist = (List<Dept>)request.getAttribute("volist"); 
/*  data1에서 값을 꺼내서 volist 에 넣음=> (리턴타입 자로형) => 다운캐스팅 */
/* 넣었을 때 List<Dept> 형 이었기 때문에 꺼냈을 때도 List<Dept> 형태로 나옴(DeptController에서 보면 나옴)
리턴타입이 object 이면 down casting 함 */

if(volist!=null) {
	if(volist.size() != 0) {
		for(Dept vo : volist) { //volist 에서 한개를 꺼내면 Dept 형태의 vo 에 넣을것
%>
<%=vo.getDeptno() %> |<%=vo.getDname()%> | <%=vo.getLoc()%> <br>
<%	
		}
	}else {
%>
DEPT 데이터가 없습니다. 추가해주세요. 	
<%
	}
} else {
%>
잠시 시스템이 불안정하여 잠시 후 다시 확인해 주세요.
<% 		
}
%>
<br>



<h1>EL(Expression Language = 표현언어) => 표현만 가능하고 for, if 등 반복문(제어문) 없음)</h1>
<!-- 1부터 10까지 3씩 증가함, 변수는 i -->
<c:forEach begin="1" end="10" step="3" var="i"> 
${i }<br>
</c:forEach> 
<br>

<!-- 이거 비었니 하고 물어보는것 ===== null check 하는 것(size 0 도 포함) -->
<!-- 얘는 else 가 없음. if 있음 -->
<c:if test="${empty volist }">
잠시 시트템이 불안정하여 잠시후 다시 확인해 주세요.
</c:if>

<!-- 만약 이렇다면 이걸 해줘 ===== else if 조건식 -->
<!-- if 문의 else(조건식 X ==== test 가 X) -->
<c:choose>
	<c:when test="${volist eq null }"> 
	잠시 시트템이 불안정하여 잠시후 다시 확인해 주세요.
	</c:when>
	<c:when test="${volist.size() lt 1 }">
	DEPT 데이터가 없습니다. 추가해주세요.
	</c:when>
	<c:otherwise>
<%--
 		<c:forEach items="${volist }" var="vo" varStatus="vs"> 
			${vs.count } | ${vo.deptno } | ${vo.dname } |${vo.loc } |${vs.index } <br>
		</c:forEach>  
--%>	
	</c:otherwise>
</c:choose>

====여기 1 테스트용 참고<br>
<!-- enhanced for이랑 비슷 => 아이템 여러개 가지고 있는 것을 items 에 써라 -->
<c:forEach items="${volist }" var="vo"> 
${vo.deptno } | ${vo.dname } |${vo.loc } <br>
</c:forEach>

====여기 2 테스트용 참고<br>
${volist.get(0).deptno} | ${volist.get(0).dname} | ${volist.get(0).loc} 
<!--  
꺼내준 모양이 list 모양이라 get 시리즈 쓸 수 있음 
애초에 get 뒤에 () 가 있어서 메소드라서 getter 를 굳이 만들어서 쓰지 X
 -->
<br>
${volist.get(1).getDeptno()}
<br>

====여기 끝<br>

</body>
</html>
