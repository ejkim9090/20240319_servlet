
    <!-- bootstrap 우선순위 높이려면 -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
     <!-- [1] 해상도 - 최적해상도1050px 결정 (최대/최소 지원범위-테스트영역) -->
    <!-- [2] content 영역 960px 80vw 90%, 배치(중앙,왼쪽) -->
    <!-- [3] reset.css 검토 -  폴더 경로 확정 -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->
    <link href="<%=request.getContextPath()%>/resources/css/reset.css" rel="stylesheet">
    <!-- bootstrap 우선순위 낮게 -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->

    <!-- [4] project명 또는 core.css / projectname.css 폴더경로 - bootstrap, template 등으로 대체 -->
    <!-- [4] 기본색상 10~15개정도 class 미리 만들어두기 -->
    <!-- [4] 폰트family와 크기 5~7개정도 class 미리 만들어두기 -->
    <!-- [4] button 3개 class 미리 만들어두기 -->
    <!-- [4] a 모양 미리 만들어두기 -->
    <link href="<%=request.getContextPath()%>/resources/css/core.css" rel="stylesheet">

    <!-- bootstrap 우선순위 낮게 -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"> -->

    <!-- [5] body Layout 영역 - 화면설계서 -->
    <!-- <link href="/css/layout.css" rel="stylesheet"> -->

    <!-- header 영역 style -->
    <link href="<%=request.getContextPath()%>/resources/css/header.css" rel="stylesheet">
    <!-- section 영역 style -->
    <link href="<%=request.getContextPath()%>/resources/css/home_section.css" rel="stylesheet">
    <!-- aside 영역 style -->
    <link href="<%=request.getContextPath()%>/resources/css/aside.css" rel="stylesheet">
    <!-- footer 영역 style -->
    <link href="<%=request.getContextPath()%>/resources/css/footer.css" rel="stylesheet">
 
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>화면설계-순서</title>

    <style>
        @import url("${pageContext.request.contextPath}/resources/css/layout.css") screen and (min-width:960px);
        @import url("${pageContext.request.contextPath}/resources/css/layout_response.css") screen and (min-width:801px) and (max-width:959px);
        @import url("${pageContext.request.contextPath}/resources/css/layout_min.css") screen and (max-width:800px);

        .mission_a{
            position: relative;
        }
        .mission_a h1 a:hover::after {
            content:'HTML5! CSS3! 실습입니다';
            font: .7em Helvetica sans-serif;
            color:blue;
            
            position: absolute;
            top: 0;
            left: 0;
            margin-left: 180px;
        }
        article form > div {
            text-align: center;
        }
        article .c-ellipsis{
            border: 1px solid black;
            width: 100px;
            /* 세트로 */
            text-overflow: ellipsis;
            white-space: nowrap;
            overflow: hidden;
        }
        article .c-clip{
            border: 1px solid black;
            width: 100px;
            /* 세트로 */
            text-overflow: clip;
            white-space: nowrap;
            overflow: hidden;
        }
    </style>
</head>

<body>
    <div class="wrap">
        <div class="wrap-header">
        <%@include file="/WEB-INF/views/common/header.jsp" %>
        </div>
        <div class="wrap-main">
         <%@include file="/WEB-INF/views/home/section.jsp" %>
         <%@include file="/WEB-INF/views/common/aside.jsp" %>
       </div>
        <div class="wrap-footer">
         <%@include file="/WEB-INF/views/common/footer.jsp" %>            
        </div>
    </div>
	<a href="/WEB-INF/views/home.jsp">jsp 페이지 열기 WEB-INF 폴더 아래 접근 불가</a> 
	<a href="${pageContext.request.contextPath}/home">Controller를 통해서 jsp 열기 - js 에서 같은 모양 기호가 쓰임이 있어 혼선</a>
	<a href="<%=request.getContextPath()%>/home">Controller를 통해서 jsp 열기 - js 안에서 썼을때 색상이 이상해짐.</a> 

	<!-- home.js 를 script로 추가 -->
    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script> -->

</body>

</html>