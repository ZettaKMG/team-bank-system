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
		let send_cost_ok = false;
		
		$("#account1_num_check").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			
			const data = {
					send_account_num : $("#input2").val()
			};
			
			$.ajax({
				url : "${appRoot}/account/account_send_check",
				type : "post",
				data : data,
				
				success : function(data) {
					$("#account1_num_message").text("사용가능한 계좌번호입니다.");
					$("#send_enable_cost").text("송금가능한 금액 : " + data + "원");	
					$("#send_account1").val($("#input2").val());
					$("#input3").removeAttr("disabled");
					account1_ok = true;
					
				},
				error : function() {
					$("#account1_num_message").text("없는계좌번호 입니다. 다시 시도해 주세요.");
					$("#send_enable_cost").text("");
				},
				complete : function() {
					$("#account1_num_check").removeAttr("disabled");
					enable_submit();				
				}
			});
		});	
		
		$("#send_cost_check").click(function(e) {
			e.preventDefault();
			
			$(this).attr("disabled", "");
			
			const data = {
				send_account_num : $("#input2").val(),
				send_account_cost : $("#input3").val()
			};
			
			$.ajax({
				url : "${appRoot}/account/send_cost_check",
				type : "post",
				data : data,
				
				success : function(data) {
					switch(data){
						case "ok" : 
							$("#send_enable_cost1").text("가능한 금액입니다.");
							send_cost_ok = true;
							break;
						
						case "notOk" : 
							$("#send_enable_cost1").text("불가능한 금액입니다.");
							send_cost_ok = false;
							break;
						
						case "" :
							$("#send_enable_cost1").text("계좌가 존재하지 않습니다.");
							break;
							
					}
					
				},
				error : function() {
					$("#send_enable_cost1").text("금액확인 중 오류가 발생하였습니다.");
				},
				complete : function() {
					$("#send_cost_check").removeAttr("disabled");
					enable_submit();
				}
			});
			
		});
		
		$("#account2_num_check").click(function(e) {
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
								$("#account2_num_message").text("사용 불가능한 계좌번호 입니다.");
								break;
							case "notOk" : 
								$("#account2_num_message").text("사용 가능한 계좌번호입니다.");
								account2_ok = true;
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
		});	
		
		$("#account_pw_check1").click(function(e) {
			e.preventDefault();
			
			const data = {
				send_account_num : $("#send_account1").val(),
				send_account_pw : $("#account_pw_input1").val()
			};
			
			$.ajax({
				url : "${appRoot}/account/account_pw_check",
				type : "post",
				data : data,
				
				success : function(data) {
					switch (data) {
						case "ok" :
							$("#account_pw_check_result").text("비밀번호가 일치합니다.");
							$("#account_transfer_notice").text("계좌이체를 실행하시겠습니까?");
							$("#account_transfer_submit").removeClass("d-none");
							break;
						case "notOk" : 
							$("#account_pw_check_result").text("비밀번호가 일치하지 않습니다.");
							break;	
					}
				},
				error : function() {
					$("#account2_num_message").text("중복 확인 중 문제 발생, 다시 시도해 주세요");
				},
				complete : function() {
									
				}

			});
		});
		
		$("#account_pw_cancel, #account_transfer_cancel").click(function() {
			$("#account_pw_input1").val("");
		});
		
		const enable_submit = function() {
			if(account1_ok && account2_ok && send_cost_ok) {
				$("#account_transfer_execute").removeAttr("disabled");
			} else {
				$("#account_transfer_execute").attr("disabled", "");
			}
		};
		
	});
</script>

<title>Insert title here</title>
</head>
<body>

	<div class="container">
		<div class="row justify-content-center">
			<div class="border border-info col-12 col-lg-6">
				<form id="form1" action="${appRoot }/account/account_transfer" method="post">
				<label for="input1" class="form-label">보내는사람</label>
				<div class="input-group mb-3">
					<input id="input1" class="form-control" type="text" name="account_user_name1" />
				</div>

				<label for="input2" class="form-label">계좌번호</label>
				<div class="input-group mb-3">
					<input id="input2" class="form-control" type="text" name="send_account_num"/>
					<button class="btn btn-secondary" type="button" id="account1_num_check">계좌확인</button>
				</div>
				<div class="form-text" id="account1_num_message"></div>
				<div id="send_enable_cost" class="form-text"></div>
								
				<label for="input3" class="form-label">송금액</label>
				<div class="input-group mb-3">
					<input id="input3" class="form-control" type="text" name="send_account_cost" disabled/>
					<button class="btn btn-secondary" type="button" id="send_cost_check">송금액확인</button>
				</div>
				<div class="form-text" id="send_enable_cost1"></div>

				<label for="input4" class="form-label">받는사람</label>
				<div class="input-group mb-3">
					<input id="input4" class="form-control" type="text" name="account_user_name2"/>
				</div>

				<label for="input5" class="form-label">계좌번호</label>
				<div class="input-group mb-3">
					<input id="input5" class="form-control" type="text" name="account_num"/>
					<button class="btn btn-secondary" type="button" id="account2_num_check">계좌확인</button>
				</div>
				<div class="form-text" id="account2_num_message"></div>
				
				<button id="account_transfer_execute" class="mt-3 btn btn-primary" data-bs-toggle="modal" data-bs-target="#Modal1" type="button" disabled>계좌이체</button>
				</form>
			</div>
		</div>
	</div>

<!-- 비밀번호 체크 모달 -->
	<div class="modal fade" id="Modal1" tabindex="-1" aria-labelledby="ModalLabel1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel1">비밀번호</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
						<input id="send_account1" type="hidden" />
						<input type="text" id="account_pw_input1" />
				</div>
				<div class="modal-footer">
					<button id="account_pw_check1" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#Modal2">확인</button>
					<button id="account_pw_cancel" type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div> 

<!-- 계좌이체 모달 -->
	<div class="modal fade" id="Modal2" tabindex="-1" aria-labelledby="ModalLabel2" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel2">계좌이체</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p id="account_pw_check_result"></p>
					<p id="account_transfer_notice"></p>	 
				</div>
				<div class="modal-footer">
					<button id="account_transfer_submit" form="form1" type="submit" class="btn btn-primary d-none">진행</button>
					<button id="account_transfer_cancel" type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>

	

</body>

</html>