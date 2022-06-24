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
		/* 수정 버튼 누를시 이벤트 */
		$("#edit_submit1").click(function(e) {
			e.preventDefault();
			
			if (confirm("상품 정보를 수정하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr2 = "${appRoot}/product/edit";
				form1.attr("action", actionAttr2);
				form1.attr("method", "post");
				
				form1.submit();
			} else {
				//history.back();
			}
		});		
		
		/* 삭제 버튼 누를시 이벤트 */
		$("#remove_submit1").click(function(e) {
			e.preventDefault();
			
			if (confirm("상품 정보를 삭제하시겠습니까?")) {
				let form1 = $("#form1");
				let actionAttr3 = "${appRoot}/product/remove";
				form1.attr("action", actionAttr3);
				form1.attr("method", "post");
				
				form1.submit();
			} else {
				//history.back();
			}
		});
	});
</script>

<!-- <script type="text/javascript">
	$(document).ready(function() {
		var formObj = $("form");
		$('button').on("click", function(e) {
			e.preventDefault();
			
			var operation = $(this).data("oper");
			console.log(operation);
			if (operation === 'remove') {
				formObj.attr("action", "${appRoot}/product/remove");
			} else if (operation === 'modify') {
				// detail창으로 이동
				// self.location = "${appRoot}/product/detail?id=" + ${product.id };
				// return;
			} else if (operation === 'search') {
				// search창으로 이동
				self.location = "${appRoot}/product/search";
				return;
			}
			formObj.submit();
		});
	});
</script> -->
	
<title>상품 상세정보 페이지</title>
</head>
<body>
	<bank:navBar></bank:navBar>

	<form id="form1" action="" method="">
	<div class="container">				
			<div class="form-group">
			<input type="hidden" name="id" value="${product.id }" />
			</div>
			
			<div class="form-group">
			<div class="mt-5 mb-3">
				<label for="item_name" class="form-label"><h4>상품명</h4></label>
		  		<input type="text" class="form-control" name="item_name" id="item_name" value="${product.item_name }" required />
			</div>
			</div>
			
			<div class="form-group">
			<div class="mt-1 mb-3">
				<label for="summary" class="form-label"><h4>상품요약</h4></label>
		  		<input type="text" class="form-control" name="summary" id="summary" value="${product.summary }" required />
			</div>
			</div>
			
			<div class="form-group">
		    <div class="mt-3">
				<table class="table table-borderless">					  
					<tbody class="table-group-divider">
						<!-- 상품코드로 상품종류 구분 가능하니 그냥 상품코드->상품종류로 통합 -->
						<tr>					
							<td>								
								<div class="input-group mb-3">
								  <span class="input-group-text" id="sav_method">상품종류</span>
								  <input type="text" class="form-control" name="sav_method" value="${product.sav_method }" aria-label="Username" aria-describedby="sav_method" required />
								</div>									
							</td>	
						</tr>
						<tr>
							<td>								
								<div class="input-group mb-3">
								  <span class="input-group-text" id="exp_period">가입기간</span>
								  <input type="text" class="form-control" name="exp_period" value="${product.exp_period }" aria-label="Username" aria-describedby="exp_period" />
								</div>									
							</td>
						</tr>
						<tr>
							<td>								
								<div class="input-group mb-3">
								  <span class="input-group-text" id="rate">이율</span>
								  <input type="text" class="form-control" name="rate" value="${product.rate }" aria-label="Username" aria-describedby="rate" required />
								</div>									
							</td>
						</tr>
					</tbody>					
				</table>					
			</div>
			</div>
			
			<div class="form-group">
				<div class="mt-3 mb-3">
					<label for="detail" class="form-label"><h4>상품 상세내용</h4></label>
				    <textarea class="form-control" name="detail" id="detail" rows="10">${product.detail }</textarea>
				</div>
			</div>
			
			<div class="mt-1 d-md-flex justify-content-md-center gap-2" role="group" aria-label="Basic mixed styles example">
			  <button type="button" id="return_search1" onclick="location.href='${appRoot}/product/search'" class="btn btn-primary">상품목록</button>
			  <button type="button" id="edit_submit1" class="btn btn-warning">상품정보 수정</button>
			  <button type="button" id="remove_submit1" class="btn btn-danger">상품정보 삭제</button>
			</div>
	</div>
	</form>		

</body>
</html>