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
			<!-- 수정 모드 진입 여부 묻는 메세지 창  -->
			$("#into_edit_mode_button").click(function(e) {
				e.preventDefault();
				
				if (confirm("상품 정보 수정/삭제모드로 진입하시겠습니까?")) {
					let form1 = $("#form1");
					let actionAttr1 = "${appRoot}/product/edit";
					form1.attr("action1", actionAttr1);
					
					form1.submit();
				}
			});	
	});
</script>
	
<title>상품 상세정보 페이지</title>
</head>
<body>
	<bank:navBar></bank:navBar>
	
	<div class="container">		
		<!-- 상품 수정 여부 modal -->
		<!-- 
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
		 -->
		 
			<input type="hidden" name="id" value="${product.id }" />
			
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
								  <span class="input-group-text" id="sav_method">상품종류</span>
								  <input type="text" class="form-control" name="sav_method" value="${product.sav_method }" aria-label="Username" aria-describedby="sav_method" required readonly />
								</div>									
							</td>	
						</tr>
						<tr>
							<td>
								<c:if test="${not empty product.exp_period }">
									<div class="input-group mb-3">
									  <span class="input-group-text" id="exp_period">가입기간</span>
									  <input type="text" class="form-control" name="exp_period" value="${product.exp_period } 개월" aria-label="Username" aria-describedby="exp_period" readonly />
									</div>									
								</c:if>								
							</td>
						</tr>
						<tr>
							<td>								
								<div class="input-group mb-3">
								  <span class="input-group-text" id="rate">이율</span>
								  <input type="text" class="form-control" name="rate" value="연 ${product.rate * 100 } %" aria-label="Username" aria-describedby="rate" required readonly />
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
			  <button type="submit" data-oper="search" onclick="location.href='${appRoot}/product/search'" class="btn btn-primary">상품목록</button>
			  			  
			  <!-- 추후 관리자 권한 있는 사용자만 보이게끔 조치 예정 -->
			  <button type="submit" id="into_edit_mode_button" data-oper="edit" onclick="location.href='${appRoot}/product/edit?id=<c:out value="${product.id }" />'" class="btn btn-warning">상품정보 수정/삭제모드</button>
			  			  
			</div>			
		
	</div>

</body>
</html>