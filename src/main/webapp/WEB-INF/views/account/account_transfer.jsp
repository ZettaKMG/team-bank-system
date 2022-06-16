<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

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
		let account1_ok = false;
		let account2_ok = false;
		
		$("#account_num_check1").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			
			const data = {
					account_num : $("#input2").val()
			};
			
			$.ajax({
				url : "${appRoot}/account/account_check",
				type : "post",
				data : data,
				
				success : function(data) {
					switch (data) {
						case "ok" :
							$("#account1_num_message").text("사용 가능한 계좌번호입니다.");
							account1_ok = true;
							break;
						case "notOk" : 
							$("#account1_num_message").text("사용 불가능한 계좌번호 입니다.");
							break;	
					}
				},
				error : function() {
					$("#account1_num_message").text("중복 확인 중 문제 발생, 다시 시도해 주세요");
				},
				complete : function() {
					$("#account1_num_check").removeAttr("disabled");
					enable_submit();				
				}
				
			});
			
			$("#account_num_check2").click(function(e) {
				e.preventDefault();
				
				$(this).attr("disabled", "");
				
				const data = {
						account_num : $("#input5").val()
				};
				
				$.ajax({
					url : "${appRoot}/account/account_check",
					type : "post",
					data : data,
					
					success : function(data) {
						switch (data) {
							case "ok" :
								$("#account2_num_message").text("사용 가능한 계좌번호입니다.");
								account1_ok = true;
								break;
							case "notOk" : 
								$("#account2_num_message").text("사용 불가능한 계좌번호 입니다.");
								break;	
						}
					},
					error : function() {
						$("#account2_num_message").text("중복 확인 중 문제 발생, 다시 시도해 주세요");
					},
					complete : function() {
						$("#account2_num_check").removeAttr("disabled");
						enable_submit();				
					}
					
				});
			
			const enable_submit = function() {
				if(account1_ok && account2_ok) {
					$("#account_register_execute").removeAttr("disabled");
				} else {
					$("#account_register_execute").attr("disabled", "");
				}
			};
		});
		
	});
</script>

<title>Insert title here</title>
</head>
<body>

	<div class="container">
		<div class="row justify-content-center">
			<div class="border border-info col-12 col-lg-6">
				<form action="${appRoot }/account/account_transfer" method="post">
				<label for="input1" class="form-label">보내는사람</label>
				<div class="input-group mb-3">
					<input id="input1" class="form-control" type="text" name="account_user_name1" />
				</div>

				<label for="input2" class="form-label">계좌번호</label>
				<div class="input-group mb-3">
					<input id="input2" class="form-control" type="text" name="send_account_num"/>
					<button class="btn btn-secondary" type="button" id="account_num_check1">계좌확인</button>
				</div>
				<div class="form-text" id="account1_num_message"></div>
				
				<label for="input3" class="form-label">송금액</label>
				<div class="input-group mb-3">
					<input id="input3" class="form-control" type="text" name="send_account_cost" />
				</div>

				<label for="input4" class="form-label">받는사람</label>
				<div class="input-group mb-3">
					<input id="input4" class="form-control" type="text" name="account_user_name2"/>
				</div>

				<label for="input5" class="form-label">계좌번호</label>
				<div class="input-group mb-3">
					<input id="input5" class="form-control" type="text" name="receive_account_num"/>
					<button class="btn btn-secondary" type="button" id="account_num_check2">계좌확인</button>
				</div>

				<button class="mt-3 btn btn-primary" data-bs-toggle="modal" data-bs-target="#Modal2">계좌이체</button>
				</form>
			</div>
		</div>
	</div>
<!-- 
	<div class="modal fade" id="Modal1" tabindex="-1" aria-labelledby="ModalLabel1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel1">비밀번호</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>비밀번호를 입력하세요</p>
					<input type="password" name="" id="">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#Modal2">확인</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>

				</div>
			</div>
		</div>
	</div> -->

	<div class="modal fade" id="Modal2" tabindex="-1" aria-labelledby="ModalLabel2" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel2">계좌이체</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					
					<p>계좌이체를 진행하시겠습니까?</p>	 
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">진행</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>

				</div>
			</div>
		</div>
	</div>



</body>

</html>