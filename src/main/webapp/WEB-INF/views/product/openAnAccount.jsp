<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"	referrerpolicy="no-referrer"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script>
	$(document).ready(function() {
		/* <!-- 수정 모드 진입 여부 묻는 메세지 창  -->
		$("#into_edit_mode_button").click(function(e) {
			e.preventDefault();
			
			if (confirm("상품 정보 수정/삭제모드로 진입하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr1 = "${appRoot}/product/edit";
				form1.attr("action1", actionAttr1);
				
				form1.submit();
			}
		});	
		
		<!-- 계좌개설 메뉴 이동 여부 묻는 메세지 창  -->
		$("#open_an_account_button").click(function(e) {
			e.preventDefault();
			
			if (confirm("계좌개설 메뉴로 이동하시겠습니까?")) {
				let form2 = $("#form2");
				let actionAttr2 = "${appRoot}/product/openAnAccount";
				form2.attr("action2", actionAttr1);
				
				form2.submit();
			}
		});	 */
	});
</script>

<script type="text/javascript">
	$(document).ready(function(){
		/* var result = '<c:out value="${message}"/>';
		
		check_modal(result);
		
		function check_modal(result) {
			if (result === '') {
				return ;
			}
			
			if (parseInt(result) > 0) {
				$(".modal-body").html("${message}");
			}
			
			$("#my_modal").modal("show");
		} */
	});
</script>
	
<title>상품 상세정보 페이지</title>
</head>
<body>
	<bank:navBar></bank:navBar>
	
	<%-- <!-- 상품 수정 여부 표시 modal -->
	<c:if test="${not empty message }">
		<div class="modal" id="my_modal" tabindex="-1" role="dialog" area-labelledby="my_modal_lable" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="my_modal_lable">상품 수정 여부</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
		      </div>
		      <div class="modal-body">
		        <p>${message }</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>		        
		      </div>
		    </div>
		  </div>
		</div>		
	</c:if>	 --%>

	<form role="form" id="form1" action="${appRoot }/product/openAnAccount?id=${product.id }" method="post">	
	<div class="container">				 
		<input type="hidden" name="id" value="${product.id }" />
		
		<div class="mt-5 mb-3">
			<label for="item_name" class="form-label"><h4>상품명</h4></label>
	  		<input type="text" class="form-control" name="item_name" id="item_name" value="${open_an_account.item_name }" required readonly />
		</div>
		<div class="mt-1 mb-3">
			<label for="user_id" class="form-label"><h4>계좌보유 ID</h4></label>
	  		<input type="text" class="form-control" name="user_id" id="user_id" value="${open_an_account.user_id }" required readonly />
		</div>
		<div class="mt-1 mb-3">
			<label for="user_name" class="form-label"><h4>예금주 명</h4></label>
	  		<input type="text" class="form-control" name="user_name" id="user_name" value="${open_an_account.user_name }" required readonly />
		</div>
		<div class="mt-1 mb-3">
			<label for="sav_method" class="form-label"><h4>상품종류</h4></label>
	  		<input type="text" class="form-control" name="sav_method" id="sav_method" value="${open_an_account.sav_method == 00 ? '예금' : '적금' }" required readonly />
		</div>
		<div class="mt-1 mb-3">
			  <label for="account_num" class="form-label"><h4>계좌번호</h4></label>
	  		<input type="text" class="form-control" name="account_num" id="account_num" value="${open_an_account.account_num }" required readonly />
	  		
	  		<div class="input-group mt-1 mb-3">
			  <input type="number" class="form-control" placeholder="000000-00-000000" aria-label="000000" aria-describedby="account_num">
			  <button class="btn btn-outline-secondary" type="button" id="account_num">계좌번호 생성하기</button>
			  <button class="btn btn-outline-secondary" type="button" id="account_num">계좌번호 중복확인</button>
			</div>
		</div>
		<div class="mt-1 mb-3">
			<label for="account_pw1" class="form-label"><h4>계좌비밀번호</h4></label>
	  		<input type="password" class="form-control" name="account_pw1" id="account_pw1" required />
		</div>	
		<div class="mt-1 mb-3">
			<label for="account_pw2" class="form-label"><h4>계좌비밀번호 재확인</h4></label>
	  		<input type="password" class="form-control" name="account_pw2" id="account_pw2" required />
		</div>	    			
		
   	    <sec:authorize access="isAuthenticated()">
			<div class="mt-1 d-md-flex justify-content-md-center gap-2" role="group" aria-label="Basic mixed styles example">
		  		<button type="submit" data-oper="search" onclick="location.href='${appRoot}/product/search'" class="btn btn-primary">상품목록으로 돌아가기</button>
		  		<button type="submit" id="open_an_account_button" data-oper="open_an_account" onclick="location.href='${appRoot}/product/openAnAccount?id=<c:out value="${product.id }" />'" class="btn btn-warning">계좌개설하기</button>
			</div>	
	    </sec:authorize>		
	</div>
	</form>
</body>
</html>