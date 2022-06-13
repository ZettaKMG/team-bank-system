<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
			
				<h1>회원 정보 보기</h1>
				
				<div>
					<p>${message }</p>
				</div>
				
				<div>
					<label for="idInput1" class="form-label">
						ID
					</label>
					<input id="idInput1" class="form-control" type="text" value="${user.userId }" readonly/>
					
					<label for="passwordInput1" class="form-label">
						비밀번호
					</label>
					<input class="form-control" id="passwordInput1" type="text" value=""  />

					<label for="passwordInput2" class="form-label">
						비밀번호 확인
					</label>
					<input class="form-control" id="passwordInput2" type="text" value=""  />
					
					<p class="form-text" id="passwordMessage1"></p>
					
					<label for="nameInput1" class="form-label">
						이름
					</label>
					<input id="nickNameInput1" class="form-control" type="text" value="${user.userName }" readonly/>
					
					<label for="birthInput1" class="form-label">
						생년월일
					</label>
					<input id="birthInput1" class="form-control" type="date" value="${user.userBirth }" readonly />
					
					<label for="addressInput1" class="form-label">
						주소
					</label>
					<input id="addressInput1" class="form-control" type="text" value="${user.userAddress }" />
					
					<label for="phoneInput1" class="form-label">
						전화번호
					</label>
					<input id="phoneInput1" class="form-control" type="text" value="${user.userPhone }" />
					
					<label for="emailInput1" class="form-label">
						Email
					</label>
					<div class="input-group">
						<input id="emailInput1" class="form-control" type="email" value="${user.userEmail }" /> 
						<button id="emailCheckButton1"  class="btn btn-secondary" disabled>이메일 중복확인</button>
					</div>
					
					<p class="form-text" id="emailMessage1"></p>
					
				</div>
				
				<div class="mt-3">
					<button id="editButton1" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modal2" disabled>수정</button>
					<button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modal1">삭제</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>