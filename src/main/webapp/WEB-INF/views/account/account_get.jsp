<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix = "bank" tagdir="/WEB-INF/tags" %>
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
	$(function () {
		let pw_ok = false;
		
		// 계좌수정시작버튼 클릭시
		$("#account_update_start").click(function() {
			<sec:authorize access="hasRole('ADMIN')">
				$("#input2").removeAttr("readonly");
				$("#input3").removeAttr("readonly"); 
				$("#input4").removeAttr("readonly");
				$("#input5").removeAttr("readonly");				
			</sec:authorize>
			
			$("#add_file_input_container1").removeClass("d-none");
			$(".remove_file_checkbox").removeClass("d-none");	
			
			$("#password_input1, #password_input2").removeAttr("readonly");
			
			$("#account_update_start").addClass("d-none");
		});
		
		// 계좌삭제실행버튼 클릭시
		$("#account_delete_execute").click(function(e) {
			e.preventDefault();
			
			if (confirm("삭제하시겠습니까")) {
				let form1 = $("#form1");
				let action1 = "${appRoot }/account/account_remove";

				form1.attr("action", action1);

				form1.submit();
			}
		});
		
		// 패스워드체크
		$("#password_input1, #password_input2").keyup(function() {
			const pw1 = $("#password_input1").val();
			const pw2 = $("#password_input2").val();
			
			pw_ok = false;
			if((pw1 != "") && (pw2 != "") && (pw1 === pw2)){
				$("#pw_check").text("패스워드가 일치합니다.");
				pw_ok = true;
				$("#password_input1, #password_input2").attr("readonly", "");
			} else {
				$("#pw_check").text("패스워드가 일치하지 않습니다.");
			}
			
			enable_submit();
		});
		
		// 모든내용이 잘 실행했는지 체크하는 메소드
		const enable_submit = function() {
			if(pw_ok) {
				$("#account_update_execute").removeAttr("disabled");
			} else {
				$("#account_update_execute").attr("disabled", "");
			}
		};
		
	});

</script>


<title>계좌 상세정보 페이지</title>
</head>
<body>
    <bank:navBar current="account_get"/>
    
    <%-- 계좌 상세 정보 화면 --%>
    <div class="container">
		<div class="row justify-content-center">
			<div class="border border-info col-12 col-lg-6">
			
				<form action="${appRoot }/account/account_modify" id="form1" method="post" enctype="multipart/form-data">
					<input type="hidden" name="account_num" value="${account.account_num }"/>
					<label for="input1" class="form-label">계좌번호</label>
					<div class="input-group mb-3">
						<input id="input1" class="form-control" type="text"
							value="${account.account_num }" readonly />
					</div>
					
					<label for="passwordInput1" class="form-label">계좌비밀번호</label> 
					<input class="form-control" id="password_input1" type="text" name="account_pw" readonly /> 
					<label for="passwordInput2" class="form-label">계좌비밀번호확인</label> 
					<input class="form-control"	id="password_input2" type="text" name="account_pw_confirm" readonly />
					<p class="form-text" id="pw_check"></p>
					
					<label for="input2" class="form-label">고객아이디</label>
					<div class="input-group mb-3">
						<input id="input2" class="form-control" type="text" name="account_user_id" value="${account.account_user_id }" readonly />
					</div>

					<label for="input3" class="form-label">계좌주</label>
					<div class="input-group mb-3">
						<input id="input3" class="form-control" type="text" value="${account.account_user_name }" readonly />
					</div> 

					<label for="input4" class="form-label">상품번호</label>
					<div class="input-group mb-3">
						<input id="input4" class="form-control" type="text" name="account_item_id" value="${account.account_item_id }" readonly />
					</div>
					
					<%-- <!-- DB 미반영 항목 -->
					<label for="input11" class="form-label">상품명</label>
					<div class="input-group mb-3">
						<input id="input11" value="${product.item_name }" class="form-control" type="text" name="product_item_name" required readonly />
					</div>
					
					<!-- DB 미반영 항목 -->
					<label for="input12" class="form-label">이율(%)</label>
					<div class="input-group mb-3">
						<input id="input12" value="${product.rate }" class="form-control" type="text" name="product_rate" required readonly />
					</div> --%>

					<label for="input5" class="form-label">잔고</label>
					<div class="input-group mb-3">
						<input id="input5" class="form-control" type="text" name="account_balance" value="${account.account_balance }" readonly />
					</div>

					<label for="input6" class="form-label">계좌생성일</label>
					<div class="input-group mb-3">
						<input id="input6" class="form-control" type="text"
							value="${account.account_date }" readonly />
					</div>
					
					<!-- 제출된 파일 추가/수정 부분 -->
					<c:forEach items="${account.file_name }" var="file">
						<%
						String file = (String) pageContext.getAttribute("file");
						String encoded_file_name = java.net.URLEncoder.encode(file, "utf-8");
						pageContext.setAttribute("encoded_file_name", encoded_file_name);
						%>
						<div class="row">
							<div class="col d-flex align-items-center">
								<div class="col-3 justify-content-center">
									<img class="img-fluid img-thumbnail"
										src="${image_url }/account/${account.account_num }/${encoded_file_name }"
										alt="" />
								</div>
								<div class="remove_file_checkbox d-none">
									<div class="form-check form-switch">
										<label class="form-check-label text-danger">
											<input class="form-check-input delete-checkbox"
												type="checkbox" name="remove_file_list" value="${file }" />
											<i class="fa-solid fa-trash-can">파일삭제</i>
										</label>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					
					<div id="add_file_input_container1" class="my-3 d-none">
						<label for="file_input1" class="form-label"></label>
						파일 추가
						<input id="file_input1" class="form-control mb-3" type="file" accept="image/*" multiple="multiple" name="add_file_list" />
					</div>

					<button id="account_withdraw_deposit" class="mt-3 btn btn-info" form="form2" type="submit">계좌이력</button>
					<button id="account_update_start" class="mt-3 btn btn-primary" type="button" >계좌수정시작</button>
					<button id="account_update_execute" class="mt-3 btn btn-success" disabled="disabled">계좌수정완료</button>
					<button id="account_delete_execute" class="mt-3 btn btn-danger">계좌삭제</button>
				</form>
			</div>
		</div>
    </div>
	
	<%-- 계좌 조회 요청--%>
	<form id="form2" action="${appRoot }/account/account_history" method="post">
		<input type="hidden" name="account_num" value="${account.account_num }"/>
	</form>   
   
   
</body>
</html>