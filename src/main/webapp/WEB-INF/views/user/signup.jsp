<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
				<h1>회원 가입</h1>
				
				<form id="form1" action="" method="post">
					<label for="" class="form-label">
						ID
					</label>
					<div class="input-group">
						<input id="" class="form-control" type="text" name=""/>
						<button id="" class="btn btn-secondary" type="button">아이디 중복 확인</button>
					</div>
					
					<label for="passwordInput1" class="form-label">
						비밀번호
					</label>		 
					<input id="passwordInput1" class="form-control" type="text" name="" /> 
					
					<label for="passwordInput2" class="form-label">
						비밀번호 확인
					</label>
					<input id="passwordInput2" class="form-control" type="text" name="" />
					
					<label for="nameInput1" class="form-label">
						이름
					</label>
					<input id="nameInput1" class="form-control" type="text" name="" /> 
					
					<label for="birthInput1" class="form-label">
						생년월일
					</label>
					<div class="row g-3">
						<div class="col-lg-4">
							<input type="text" class="form-control" placeholder="년"/>
						</div>
						<div class="col-lg-4">
							<input type="text" class="form-control" placeholder="월"/>
						</div>
						<div class="col-lg-4">
							<input type="text" class="form-control" placeholder="일"/>
						</div>
					</div>
									
					<label for="addressInput1" class="form-label">
						주소
					</label>
					<input id="addressInput1" class="form-control" type="text" name="" /> 
					
					<label for="phoneInput1" class="form-label">
						전화번호
					</label>
					<input id="phoneInput1" class="form-control" type="text" name="" /> 
					
					<label for="emailInput1" class="form-label">
						Email
					</label>
					<div class="input-group mb-3">
						<input id="" class="form-control" type="email" name=""/>
						<button id="" class="btn btn-secondary" type="button">이메일 중복 확인</button>
					</div>
					
							 	
					<button id="submitButton1" class="btn btn-primary" disabled>회원가입</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>