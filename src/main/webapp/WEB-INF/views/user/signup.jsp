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
<title>Insert title here</title>
<script>
	$(document).ready(function() {
		// 중복, 암호 확인 변수
		let idOk = false;
		let pwOk = false;
		let emailOk = false;
		
		// 아이디 중복 확인
		$("#checkIdButton1").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			const data = {
					user_id : $("#form1").find("[name=user_id]").val()
			};
			
			idOk = false;
			
			$.ajax({
				url : "${appRoot}/user/check",
				type : "get",
				data : data,
				success : function(data) {
					switch(data) {
						case "available" :
							$("#idMessage1").text("사용 가능한 아이디 입니다.");
							idOk = true;
							break;
						case "unavailable" :
							$("#idMessage1").text("사용 불가능한 아이디 입니다.");
							break;
					}
				},
				error : function() {
					$("#idMessage1").text("중복 확인 중 문제 발생, 다시 시도해 주세요.");
				},
				complete : function() {
					$("#checkIdButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		});
		
		// 패스워드 오타 확인
		$("#passwordInput1, #passwordInput2").keyup(function() {
			const pw1 = $("#passwordInput1").val();
			const pw2 = $("#passwordInput2").val();
			
			pwOk = false;
			if (pw1 === pw2) {
				$("#passwordMessage1").text("패스워드가 일치합니다.");
				pwOk = true;
			} else {
				$("#passwordMessage1").text("패스워드가 일치하지 않습니다.");
			}
			
			enableSubmit();
		});
		
		// 이메일 중복 확인
		$("#checkEmailButton1").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			const data = {
					user_email : $("#form1").find("[name=user_email]").val()
			};
			
			emailOk = false;
			
			$.ajax({
				url : "${appRoot}/user/check",
				type : "get",
				data : data,
				success : function(data) {
					switch(data) {
						case "available" :
							$("#emailMessage1").text("사용 가능한 이메일 입니다.");	
							emailOk = true;
							break;
						case "unavailable" :
							$("#emailMessage1").text("사용중인 이메일 입니다.");
							break;
					}
				},
				error : function() {
					$("#emailMessage1").text("중복 확인 중 문제 발생, 다시 시도해 주세요.");
				},
				complete : function() {
					$("#checkEmailButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		});
		
		// 회원가입 버튼 활성화/비활성화
		const enableSubmit = function () {
			if (idOk && pwOk && emailOk) {
				$("#submitButton1").removeAttr("disabled");
			} else {
				$("#submitButton1").attr("disabled", "");
			}
		}
	});
</script>
</head>
<body>
	<bank:userNavBar current="signup"></bank:userNavBar>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
				<h1>회원 가입</h1>
				
				<form id="form1" action="${appRoot }/user/signup" method="post">
					<label for="idInput1" class="form-label">
						ID
					</label>
					<div class="input-group">
						<input id="idInput1" class="form-control" type="text" name="user_id"/>
						<button id="checkIdButton1" class="btn btn-secondary" type="button">아이디 중복 확인</button>
					</div>
					
					<div id="idMessage1" class="form-text"></div>
					
					<label for="passwordInput1" class="form-label">
						비밀번호
					</label>		 
					<input id="passwordInput1" class="form-control" type="text" name="user_pw" /> 
					
					<label for="passwordInput2" class="form-label">
						비밀번호 확인
					</label>
					<input id="passwordInput2" class="form-control" type="text" name="pwCheck" />
					
					<div id="passwordMessage1" class="form-text"></div>
					
					<label for="nameInput1" class="form-label">
						이름
					</label>
					<input id="nameInput1" class="form-control" type="text" name="user_name" /> 
					
					<label for="birthInput1" class="form-label">
						생년월일
					</label>
					<input id="birthInput1" class="form-control" type="date" name="user_birth"/>
									
					<label for="addressInput1" class="form-label">
						주소
					</label>
					<input id="addressInput1" class="form-control" type="text" name="user_address" /> 
					
					<label for="phoneInput1" class="form-label">
						전화번호
					</label>
					<input id="phoneInput1" class="form-control" type="text" name="user_phone" /> 
					
					<label for="emailInput1" class="form-label">
						Email
					</label>
					<div class="input-group mb-3">
						<input id="emailInput1" class="form-control" type="email" name="user_email"/>
						<button id="checkEmailButton1" class="btn btn-secondary" type="button">이메일 중복 확인</button>
					</div>
					
					<div id="emailMessage1" class="form-text"></div>
							 	
					<button id="submitButton1" class="btn btn-primary" disabled>회원가입</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>