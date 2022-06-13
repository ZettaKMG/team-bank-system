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
<script>
	$(document).ready(function() {
		
		let passwordCheck = true;
		let emailCheck = true;
		let nickNameCheck = true;
		
		// 주소 변경시 새로운 주소 값
		const oldAddress = $("#addressInput1").val();
		
		$("#addressInput1").keyup(function() {
			const newAddress = $("#addressInput1").val();
		});
		
		// 전화번호 변경시 새로운 번호 값
		const oldPhone = $("#phoneInput1").val();
		
		$("#phoneInput1").keyup(function() {
			const newPhone = $("#phoneInput1").val();
		});
		
		// 이메일 변경시 버튼 활성화
		const oldEmail = $("#emailInput1").val();
		
		$("#emailInput1").keyup(function() {
			const newEmail = $("#emailInput1").val();
			
			if(oldEmail === newEmail) {
				$("#checkEmailButton1").attr("disabled", "");
				$("#emailMessage1").text("");
			} else {
				$("#checkEmailButton1").removeAttr("disabled");				
			}
		});
		
		// ajax 이메일 중복 확인
		$("#checkEmailButton1").click(function(e) {
			e.preventDefault();
			
			const data = {userEmail : $("#emailInput1").val()};
			
			emailCheck = false;
			
			$.ajax({
				url : "${appRoot}/user/check",
				type : "get",
				data : data,
				success : function(data) {
					switch(data) {
						case "available" :
							$("#emailMessage1").text("사용 가능한 이메일 입니다.");	
							emailCheck = true;
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
					enableEdit();
				}
			});
		});
		
		// 암호, 암호확인		
		$("#passwordInput1, #passwordInput2").keyup(function() {
			const pw1 = $("#passwordInput1").val();
			const pw2 = $("#passwordInput2").val();
			
			if(pw1 === pw2)	{
				$("#passwordMessage1").text("패스워드가 일치합니다.");
				passwordCheck = true;
			} else {
				$("#passwordMessage1").text("패스워드가 일치하지 않습니다.");
				passwordCheck = false;
			}
			
			enableEdit();
		});
		
		// 수정 버튼 활성화/비활성화
		const enableEdit = function () {
			if (passwordCheck && emailCheck) {
				$("#editButton1").removeAttr("disabled");
			} else {
				$("#editButton1").attr("disabled", "");
			}
		};
		
		// 수정 버튼 클릭시
		$("#editSubmitButton1").click(function(e) {
			e.preventDefault();
			const form2 = $("#form2");
			
			// input 값
			form2.find("[name=userPw]").val($("#passwordInput1").val());
			form2.find("[name=userEmail]").val($("#emailInput1").val());
			form2.find("[name=userAddress]").val($("#addressInput1").val());
			form2.find("[name=userPhone]").val($("#phoneInput1").val());
			
			// submit
			form2.submit();
		});
	});
</script>
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
					<button id="editButton1" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#modifyModal" disabled>수정</button>
					<button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#removeModal">삭제</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- remove Modal -->
	<div class="modal fade" id="removeModal" tabindex="-1"
		aria-labelledby="removeModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="removeModalLabel">기존 비밀번호 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form1" action="${appRoot }/user/remove" method="post">
						<input type="hidden" value="${user.userId }" name="userId"/>
						<label for="passwordInput3" class="form-label">
				        	비밀번호
				        </label>
				        <input id="passwordInput3" class="form-control" type="text" name="userPw" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">Close</button>
					<button form="form1" type="submit" class="btn btn-danger">탈퇴</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- edit Modal -->
	<div class="modal fade" id="modifyModal" tabindex="-1"
		aria-labelledby="modifyModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modifyModalLabel">기존 비밀번호 입력</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form2" action="${appRoot }/user/modify" method="post">
						<input type="hidden" value="${user.userId }" name="userId"/>
						<input type="hidden" name="userPw"/>
						<input type="hidden" name="userEmail"/>
						<input type="hidden" name="userAddress"/>
						<input type="hidden" name="userPhone"/>
						<label for="passwordInput4" class="form-label">
		     				비밀번호 
	        			</label>
	        			<input id="passwordInput4" class="form-control" type="text" name="oldPassword" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">Close</button>
					<button id="editSubmitButton1" form="form2" type="submit" class="btn btn-primary">수정</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>