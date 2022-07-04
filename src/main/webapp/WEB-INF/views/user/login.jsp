<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<title>로그인 준비가 되셨습니까?</title>
</head>
<body>
	<bank:navBar current="login"></bank:navBar>

	<div class="container">
		<div class="row justify-content-center">
			<c:if test="${not empty LoginFailMessage}">
				<div class="alert alert-danger mt-3" >
					<p> Error : <c:out value="${LoginFailMessage}"/> </p>
				</div>
			</c:if>
			
			<div class="mt-5 col-12 col-lg-4">	
				<div class="mt-1 d-md-flex justify-content-md-center">		
					<h1>로그인</h1>
				</div>
				<h3><c:out value="${logout }"></c:out></h3>
				<form action="${appRoot }/user/login" method="post">					
					
					<div class="row">
						<label for="userIdInput1" class="form-label">
							<strong>ID</strong> 
						</label>
						<input id="userIdInput1" class="form-control" type="text" name="username"/>
					</div>
					
					<div class="row">
						<label for="userPwInput1" class="form-label">
							<strong>Password</strong>
						</label>
						<input id="userPwInput1" class="form-control" type="password" name="password"/>
					</div>
					
					<div class="mt-1 d-md-flex justify-content-md-center">
						<div class="form-check mt-3">
							<input class="btn btn-primary" type="submit" value="로그인"/>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>