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
		$("#edit_button1").click(function() {
			$("#product_name").removeAttr("readonly");
			$("#product_summary").removeAttr("readonly");
			$("#product_detail").removeAttr("readonly");
			$("#edit_submit1").removeClass("d-none");
			$("#delete_submit1").removeClass("d-none");			
		});

		<!-- 수정 버튼 누를시 수정 여부 묻는 메세지 창 -->
		$("#edit_submit1").click(function(e) {
			e.preventDefault();
			
			if (confirm("상품 정보를 수정하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr1 = "${appRoot}/product/edit";
				form1.attr("action1", actionAttr1);
				
				form1.submit();
			}
		});		
		
		<!-- 삭제 버튼 누를시 삭제 여부 묻는 메세지 창 -->
		$("#delete_submit1").click(function(e) {
			e.preventDefault();
			
			if (confirm("상품 정보를 삭제하시겠습니까?")) {
				let form2 = $("#form2");
				let actionAttr2 = "${appRoot}/product/remove";
				form2.attr("action2", actionAttr2);
				
				form2.submit();
			}
		});
	});
</script>		

	
<title>상품 상세정보 페이지</title>
</head>
<body>
	<bank:navBar></bank:navBar>

	<div class="container">
		<div class="mt-5 mb-3">
				<!-- 편집버튼(권한 있는 유저에게만 보이게끔) -->
			<sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal" var="principal" />
				
				<c:if test="${principal.user_id == product.user_id }">
			    	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					  <button id="edit_button1" class="btn btn-warning">편집하기</button>			
					</div>
				</c:if>
			</sec:authorize>
		</div>
				
		<form id="form1" action="${appRoot }/product/edit" method="post">
			<input type="hidden" name="id" value="${product.id }" />
			
			<div class="mt-5 mb-3">
				<label for="name" class="form-label"><h4>상품명</h4></label>
		  		<input type="text" class="form-control" name="item_name" id="name" value="${product.item_name }" required readonly />
			</div>
			<div class="mt-1 mb-3">
				<label for="summary" class="form-label"><h4>상품요약</h4></label>
		  		<input type="text" class="form-control" name="item_summary" id="summary" value="${product.item_summary }" required readonly />
			</div>
		    <div class="mt-3">
				<table class="table table-borderless">					  
					<tbody class="table-group-divider">
						<!-- 상품코드로 상품종류 구분 가능하니 그냥 상품코드->상품종류로 통합 -->
						<tr>					
							<td>								
								<div class="input-group mb-3">
								  <span class="input-group-text" id="type">상품종류</span>
								  <input type="text" class="form-control" name="sav_method" value="${product.sav_method }" aria-label="Username" aria-describedby="type" required readonly />
								</div>									
							</td>	
						</tr>
						<tr>
							<td>								
								<div class="input-group mb-3">
								  <span class="input-group-text" id="period">가입기간</span>
								  <input type="text" class="form-control" name="exp_period" value="${product.exp_period }" aria-label="Username" aria-describedby="period" readonly />
								</div>									
							</td>
						</tr>
						<tr>
							<td>								
								<div class="input-group mb-3">
								  <span class="input-group-text" id="rate">이율</span>
								  <input type="text" class="form-control" name="deposit_rate" value="${product.rate }%" aria-label="Username" aria-describedby="rate" required readonly />
								</div>									
							</td>
						</tr>
					</tbody>					
				</table>					
			</div>
			<div class="mt-3 mb-3">
				<label for="productDetail" class="form-label"><h4>상품 상세내용</h4></label>
			    <textarea class="form-control" name="detail" id="productDetail" rows="10" readonly>${product.detail }</textarea>
			</div>
			
			<div class="mt-1 d-md-flex justify-content-md-center gap-2" role="group" aria-label="Basic mixed styles example">
			  <button type="submit" id="edit_submit1" class="btn btn-warning">상품정보 수정</button>
			  <button type="submit" id="delete_submit1" class="btn btn-danger">상품정보 삭제</button>
			</div>
		</form>		
	</div>

</body>
</html>