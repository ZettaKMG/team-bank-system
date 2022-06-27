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
		/* 수정 모드 진입 여부 묻는 메세지 창 */
		$("#into_edit_mode_button").click(function(e) {
			e.preventDefault();
						
			if (confirm("상품 정보 수정/삭제모드로 진입하시겠습니까?")) { // 확인 누를시 진입
				let form1 = $("#form1");
				let actionAttr1 = "${appRoot}/product/edit";
				form1.attr("action", actionAttr1);
				
				form1.submit();
			} else { // 취소 누를시 현재 페이지에 그대로
									
			}
		});	
		
		/* 계좌개설 메뉴 이동 여부 묻는 메세지 창 */
		$("#open_an_account_button").click(function(e) {
			e.preventDefault();
			
			if (confirm("계좌개설 메뉴로 이동하시겠습니까?")) { // 확인 누를시 진입
				let form1 = $("#form1");
				let actionAttr2 = "${appRoot}/account/account_register";
				form1.attr("action", actionAttr2);
				
				form1.submit();
			} else { // 취소 누를시 현재 페이지에 그대로
				
			}
		});	
	});
</script>

<script type="text/javascript">
	<!-- Modal 창 -->
	$(document).ready(function(){
		var result = '<c:out value="${message}"/>';
		
		check_modal(result);
		
		function check_modal(result) {
			if (result === '') {
				return ;
			}
			
			if (parseInt(result) > 0) {
				$(".modal-body").html("${message}");
			}
			
			$("#my_modal").modal("show");
		}
	});
</script>
	
<title>상품 상세정보 페이지</title>
</head>
<body>
	<bank:navBar></bank:navBar>
	
	<!-- 상품 수정 여부 표시 modal -->
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
	</c:if>	
			
	<form id="form1" action="" method="get">	
	<div class="container">				 
		<input type="hidden" name="id" value="${product.id }" />
		<input type="hidden" name="user_id" value="<c:out value='${user.user_id }' />" />
		
		<div class="mt-5 mb-3">
			<label for="item_name" class="form-label"><h4>상품명</h4></label>
	  		<input type="text" class="form-control" name="item_name" id="item_name" value="${product.item_name }" required readonly />
		</div>
		<div class="mt-1 mb-3">
			<label for="summary" class="form-label"><h4>상품요약</h4></label>
	  		<input type="text" class="form-control" name="summary" id="summary" value="${product.summary }" required readonly />
		</div>
	    <div class="mt-3">
			<table class="table table-borderless">					  
				<tbody class="table-group-divider">
					<!-- 상품코드로 상품종류 구분 가능하니 그냥 상품코드->상품종류로 통합 -->
					<tr>					
						<td>								
							<div class="input-group mb-3">
							  <span class="input-group-text" id="sav_method">상품종류
							  <input type="text" class="form-control" name="sav_method" value="${product.sav_method }" aria-label="Username" aria-describedby="sav_method" required readonly />
							  </span>							  
							</div>									
						</td>	
					</tr>
					<c:if test="${product.exp_period != 0 }">
						<tr>
							<td>
								<div class="input-group mb-3">
								  <span class="input-group-text" id="exp_period">가입기간
								  <input type="text" class="form-control" name="exp_period" value="${product.exp_period }" aria-label="Username" aria-describedby="exp_period" readonly /> 개월								  
								  </span>
								</div>									
							</td>
						</tr>
					</c:if>								
					<tr>
						<td>								
							<div class="input-group mb-3">
							  <span class="input-group-text" id="rate">이율
							  연 <input type="text" class="form-control" name="rate" value="${product.rate * 100}" aria-label="Username" aria-describedby="rate" required readonly /> %
							  </span>
							</div>									
						</td>
					</tr>
				</tbody>					
			</table>					
		</div>
		<div class="mt-3 mb-3">
			<label for="detail" class="form-label"><h4>상품 상세내용</h4></label>
		    <textarea class="form-control" name="detail" id="detail" rows="10" readonly>${product.detail }</textarea>
		</div>			
		
		<div class="mt-1 d-md-flex justify-content-md-center gap-2" role="group" aria-label="Basic mixed styles example">
		  <button type="button" id="return_search1" onclick="location.href='${appRoot}/product/search'" class="btn btn-primary">상품목록</button>			  			  
	
		  <sec:authorize access="hasAnyRole('ADMIN, PRODUCT')">
		  	<button type="button" id="into_edit_mode_button" class="btn btn-warning">상품정보 수정/삭제모드</button>
		  </sec:authorize>	
		
		  <sec:authorize access="isAuthenticated()">
		  	<button type="button" id="open_an_account_button" class="btn btn-info">계좌개설하기</button>
		  </sec:authorize>		
		</div>	
	</div>
	</form>
	
</body>
</html>