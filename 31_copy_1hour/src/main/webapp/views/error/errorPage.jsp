<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String ctxPath = request.getContextPath();
pageContext.setAttribute("ctxPath", request.getContextPath());
pageContext.setAttribute("pageScope", "pageScope Value");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Msg</title>
</head>
<body>
JSP 제공 내장객체의 scope 분리하여 말하시오.
예) setAttribute - getAttribute 
page(pageContext) 
- request(response전까지유지) - request.getRequestDispatcher("xxx.jsp").forward(req,res);과 함께 사용됨.
- session(브라우저창닫기까지,removeAttribute()) - response.sendRedirect(url..);과 함께 사용됨. 로그인정보(로그아웃)
- application

 매개변수(인자) 없음. 내장객체미리 지정해줌.
 request
 response
 ${ctxPath}
<%

	String pcValue = (String)pageContext.getAttribute("pageScope");
	// response.getWriter()  ==> out 이름의 객체
	out.write("aaa");
	// request.getSession()  ==> session 이름의 객체
	session.setAttribute("loginId", "abc");
	session.removeAttribute("loginId");
	
	// exception  // TODO 예시
	
	//page === Ojbect  현재 JSP를 class 의미로 봤을때 해당 JSP 객체
	//pageContext ===== 외부 환경/설정 정보를 제공하는 객체
	// TODO : 예시
%>
 
 
 
<c:choose>
 <c:when test="5 != 6">화면에 바로 뿌려지는 부분</c:when>

 <c:when test=""></c:when>
 <c:when test=""></c:when>
 <c:when test=""></c:when>

 <c:otherwise></c:otherwise>
</c:choose>
<!-- 
<h1>Error Msg</h1>
 -->
${msg }

</body>
</html>