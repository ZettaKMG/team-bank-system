<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>

<script>
	$(function() {
		let account_ok = false;
		let pw_ok = false;
		let user_num_ok = false;
		let item_num_ok = false;
		
		// 무작위 계좌번호 생성버튼 추가(정수 12자리)
		$("#account_num_create").click(function(e) {
			e.preventDefault();
			// 2000억 이상 4000억 미만의 정수
			var account_num = Math.floor((Math.random()+1)*200000000000);			
			$("#input1").attr("value", account_num);
			
		});
		
		$("#account_num_check").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			
			const data = {
					account_num : $("#input1").val()
			};
			
			$.ajax({
				url : "${appRoot}/account/account_check",
				type : "post",
				data : data,
				
				success : function(data) {
					switch (data) {
						case "ok" :
							$("#account_num_message").text("사용 가능한 계좌번호입니다.");
							account_ok = true;
							break;
						case "notOk" : 
							$("#account_num_message").text("사용 불가능한 계좌번호 입니다.");
							break;	
					}
				},
				error : function() {
					$("#account_num_message").text("중복 확인 중 문제 발생, 다시 시도해 주세요");
				},
				complete : function() {
					$("#account_num_check").removeAttr("disabled");
					enable_submit();
				}
				
			});
			
			$("#password_input1, #password_input2").keyup(function() {
				const pw1 = $("#password_input1").val();
				const pw2 = $("#password_input2").val();
				
				pw_ok = false;
				if((pw1 != "") && (pw2 != "") && (pw1 === pw2)){
					$("#pw_check").text("패스워드가 일치합니다.");
					pw_ok = true;
					$("#password_input1, #password_input2").attr("disabled", "");
				} else {
					$("#pw_check").text("패스워드가 일치하지 않습니다.");
				}
				
				enable_submit();
			});
			
			// 하단을 주석처리한 이유는 해당 항목들을 이제 입력하는 방식이 아닌 
			// 불러오는 값대로 쓰기 때문에 무효처리를 해줘야 계좌개설 버튼이 활성화되서 그랬습니다...
			/* $("#input2").keyup(function() {
				user_num_ok = true;
				
				enable_submit();
			});
			
			$("#input3").keyup(function() {
				item_num_ok = true;
				
				enable_submit();
			}); */
			
			const enable_submit = function() {
				if(pw_ok && account_ok /* && user_num_ok && item_num_ok */) {
					$("#account_register_execute").removeAttr("disabled");
					
				} else {
					$("#account_register_execute").attr("disabled", "");
				}
			};
		});
	});
</script>

<title>계좌개설 메뉴 페이지</title>
</head>
<body>

	<bank:navBar></bank:navBar>      
    
    <div class="container mt-5">
		<div class="row justify-content-center">
			<div class="border border-info col-12 col-lg-6">

				<form action="${appRoot }/account/account_register" method="post">
					<input type="hidden" name="id" value="${account.account_item_id }" scope="session" />
				
					<label for="input1" class="form-label">계좌번호</label>
					<div class="input-group mb-3">
						<input id="input1" class="form-control" type="text" name="account_num" value="" scope="session" required readonly/>
						<!-- 정수 12자리 무작위 번호 생성 버튼 추가 -->
						<button class="btn btn-secondary" id="account_num_create" type="button">계좌번호 생성</button>
						<button class="btn btn-secondary" id="account_num_check" type="button">계좌번호 중복 확인</button>
					</div>
					<div class="form-text" id="account_num_message"></div>

					<label for="password_input1" class="form-label">패스워드</label>
					<input class="form-control" id="password_input1" type="text" placeholder="숫자 4자리 입력" name="account_pw" scope="session" required />

					<label for="password_input2" class="form-label">패스워드 확인</label>
					<input class="form-control" id="password_input2" type="text" placeholder="숫자 4자리 입력" name="account_pw_confirm" required />
					<p class="form-text" id="pw_check"></p>
					
					<!-- 불러올때는 User 테이블의 user_id 컬럼값, DB에는 Account 테이블의 account_user_id 컬럼값으로 저장 -->
					<label for="input2" class="form-label">유저아이디</label>
					<div class="input-group mb-3">
						<input id="input2" value="${principal.username }" class="form-control" type="text" name="account_user_id" scope="session" required readonly />
					</div>

					<!-- 불러올때는 Product 테이블의 id 컬럼값, DB에는 Account 테이블의 account_item_id 컬럼값으로 저장 -->
					<label for="input3" class="form-label">상품번호</label>
					<div class="input-group mb-3">
						<input id="input3" value="${product.id }" class="form-control" type="text" name="account_item_id" scope="session" required readonly />
					</div>
					
					<!-- DB 미반영 항목 -->
					<label for="input4" class="form-label">상품명</label>
					<div class="input-group mb-3">
						<input id="input4" value="${product.item_name }" class="form-control" type="text" name="product_item_name" scope="session" required readonly />
					</div>
					
					<!-- DB 미반영 항목 -->
					<label for="input5" class="form-label">이율(%)</label>
					<div class="input-group mb-3">
						<input id="input5" value="${product.rate }" class="form-control" type="text" name="product_rate" required readonly />
					</div>
					
					<div class="mb-3">
					  <label for="formFileMultiple" class="form-label">제출서류 첨부(필요시)</label>
					  <input class="form-control" type="file" name="file" id="formFileMultiple" accept="image/*" multiple>
					</div>

					<button id="account_register_execute" class="mt-3 btn btn-primary" type="submit" disabled>계좌등록</button>
				</form>
			</div>
		</div>
	</div>
   
</body>
</html>