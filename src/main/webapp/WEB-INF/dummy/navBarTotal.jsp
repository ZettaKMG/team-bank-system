<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="java.util.*" %>

<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<!-- 아래 스크립트 코드를 추가해야 드롭다운 기능이 정상작동됩니다. -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body>

<div class="border border-success container mt-3">
<nav class="navbar navbar-expand-lg">
  <div class="container-fluid">    
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-5 mb-lg-0">
      	<li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="product" role="button" data-bs-toggle="dropdown" aria-expanded="false">
           	상품
          </a>
          <ul class="dropdown-menu" aria-labelledby="product">
            <li><a class="dropdown-item" href="#">상품조회</a></li>
            <li><a class="dropdown-item" href="#">상품등록</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="account" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                     계좌
          </a>
          <ul class="dropdown-menu" aria-labelledby="account">
            <li><a class="dropdown-item" href="#">계좌조회</a></li>
            <li><a class="dropdown-item" href="#">계좌이체</a></li>
            <li><a class="dropdown-item" href="#">계좌등록</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">멤버조회</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">마이페이지</a>
        </li>     
        <li class="nav-item">
          <a class="nav-link" href="#">로그인/로그아웃</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">회원가입</a>
        </li>           
      </ul>      
    </div>
  </div>
</nav>
</div>

</body>
</html>