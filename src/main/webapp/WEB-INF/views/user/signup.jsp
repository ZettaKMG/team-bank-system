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
<title>klk은행의 회원이 되어보세요!</title>
<script>
	$(document).ready(function() {
		// 중복, 암호 확인, 미입력 확인 변수
		let idOk = false;
		let pwOk = false;
		let emailOk = false;
		let nameOk = false;
		let birthOk = false;
		let addressOk = false;
		let phoneOk = false;
		
		// 아이디 중복 확인
		$("#checkIdButton1").click(function(e) {
			e.preventDefault();
			if ($('#idInput1').val() == '') {
			      alert("아이디를 입력해주세요.");
			      return;
			}
			
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
				}
			});
		});
		
		// 패스워드 오타 확인
		$("#passwordInput1, #passwordInput2").keyup(function() {
			const pw1 = $("#passwordInput1").val();
			const pw2 = $("#passwordInput2").val();
			
			pwOk = false;
			if (pw1 === pw2 && pw1 != '' && pw2 != '') {
				$("#passwordMessage1").text("패스워드가 일치합니다.");
				pwOk = true;
			} else if(pw1 === '' || pw2 === '') {
				$("#passwordMessage1").text("패스워드를 입력해주세요.");
			} else {
				$("#passwordMessage1").text("패스워드가 일치하지 않습니다.");
			}
			
		});
		
		// 이메일 중복 확인
		$("#checkEmailButton1").click(function(e) {
			e.preventDefault();
			
			if ($('#emailInput1').val() == '') {
				alert("이메일을 입력해주세요.");
				return;
			}
			
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
				}
			});
		});
		
		// 회원가입 버튼 클릭 시 입력 폼 체크
		$("#submitButton1").click(function(e) {
			e.preventDefault();
			
			if($("#nameInput1").val() != '') {
				nameOk = true;
			}
			if($("#birthInput1").val() != '') {
				birthOk = true;			
			}
			if($("#addressInput1").val() != '') {
				addressOk = true;
			}
			if($("#phoneInput1").val() != '') {
				phoneOk = true;
			}
			
			if (idOk && pwOk && emailOk && nameOk && birthOk && addressOk && phoneOk) {
				$("#form1").submit();				
			} else {
				alert("작성내용을 확인해주세요.");
				return;
			}
		});
		
		// ID 중복체크 후 변경시 다시 체크
		$("#idInput1").keyup(function() {
			$("#idMessage1").text("중복확인 해주세요.");
			idOk = false;
		});
		
		// Email 중복체크 후 변경시 다시 체크
		$('#emailInput1').keyup(function() {
			$("#emailMessage1").text("중복확인 해주세요.");
			emailOk = false;
		});
	});
</script>
</head>
<body>
	<bank:navBar current="signup"></bank:navBar>

	<div class="container">
		<div class="row justify-content-center">
			<div class="mt-5 col-12 col-lg-6">
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
					<input id="nameInput1" class="form-control" type="text" name="user_name" required/> 
					
					<label for="birthInput1" class="form-label">
						생년월일
					</label>
					<input id="birthInput1" class="form-control" type="date" name="user_birth" required/>
									
					<label for="addressInput1" class="form-label">
						주소
					</label>
					<input id="addressInput1" class="form-control" type="text" name="user_address" required/> 
					
					<label for="phoneInput1" class="form-label">
						전화번호
					</label>
					<input id="phoneInput1" class="form-control" type="text" name="user_phone" required/> 
					
					<label for="emailInput1" class="form-label">
						Email
					</label>
					<div class="input-group mb-3">
						<input id="emailInput1" class="form-control" type="email" name="user_email"/>
						<button id="checkEmailButton1" class="btn btn-secondary" type="button">이메일 중복 확인</button>
					</div>
					
					<div id="emailMessage1" class="form-text"></div>
					
					<div class="mt-1 d-md-flex justify-content-md-center">		 	
						<button id="submitButton1" class="btn btn-primary">회원가입</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>