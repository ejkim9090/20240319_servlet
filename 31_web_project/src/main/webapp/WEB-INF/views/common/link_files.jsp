<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    <!-- aside 영역 style -->
    <link href="<%=request.getContextPath()%>/resources/css/aside.css" rel="stylesheet">
    <!-- footer 영역 style -->
    <link href="<%=request.getContextPath()%>/resources/css/footer.css" rel="stylesheet">
 