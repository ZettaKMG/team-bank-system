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
			
			if (confirm("상품 정보를 수정하시겠습니까?")) { // 확인시 수정 내용 적용
				let form1 = $("#form1");
				let actionAttr2 = "${appRoot}/product/edit";
				form1.attr("action", actionAttr2);
				
				form1.submit();
			} else { // 취소시 아무일도 안 일어남
			
			}
		});		
		
		/* 삭제 버튼 누를시 이벤트 */
		$("#remove_submit1").click(function(e) {
			e.preventDefault();
			
			if (confirm("상품 정보를 삭제하시겠습니까?")) { // 확인시 삭제
				let form1 = $("#form1");
				let actionAttr3 = "${appRoot}/product/remove";
				form1.attr("action", actionAttr3);
				
				form1.submit();
			} else { // 취소시 아무일도 안 일어남
				
			}
		});
	});
</script>
	
<title>상품 상세정보 페이지</title>
</head>
<body>
	<bank:navBar></bank:navBar>

	<form id="form1" action="" method="post">
	<div class="container">				
		<input type="hidden" name="id" value="${product.id }" />
				
		<div class="mt-5 mb-3">
			<div class="input-group">
			  <span class="input-group-text"><strong>상품명</strong></span>
			  <textarea class="form-control" name="item_name" id="item_name" rows="1" required>${product.item_name }</textarea>
			</div>	
		</div>
		<div class="mt-1 mb-3">
			<div class="input-group">
			  <span class="input-group-text"><strong>상품요약</strong></span>
			  <textarea class="form-control" name="summary" id="summary" rows="2" required>${product.summary }</textarea>
			</div>
		</div>
	    <div class="mt-3">
		    <div class="row justify-content-md-center">
			    <div class="col col-lg-2">
			      <div class="input-group mb-3">
					  <span class="input-group-text" id="sav_method"><strong>상품종류</strong>
					  <input type="text" class="form-control" name="sav_method" value="${product.sav_method }" aria-label="Username" aria-describedby="sav_method" required />
					  </span>							  
					</div>
			    </div>
			    <div class="col col-lg-2">
			      <c:if test="${product.exp_period != 0 }">						
					<div class="input-group mb-3">
					  <span class="input-group-text" id="exp_period"><strong>가입기간</strong>
					  <input type="text" class="form-control" name="exp_period" value="${product.exp_period }" aria-label="Username" aria-describedby="exp_period" /> 개월								  
					  </span>
					</div>					
				  </c:if>
			    </div>
			    <div class="col col-lg-2">
			      <div class="input-group mb-3">
					  <span class="input-group-text" id="rate"><strong>연 이율</strong>
					  	<input type="text" class="form-control" name="rate" value="${product.rate * 100}" aria-label="Username" aria-describedby="rate" required /> %
					  </span>
				  </div>	
			    </div>
		  	</div>
		</div>			
						
		<div class="mt-1 mb-3">
			<div class="input-group">
			  <span class="input-group-text"><strong>상품 상세내용</strong></span>
			  <textarea class="form-control" name="detail" id="detail" rows="10">${product.detail }</textarea>
			</div>		    
		</div>
	</div>
			
	<div class="mt-1 d-md-flex justify-content-md-center gap-2" role="group" aria-label="Basic mixed styles example">
	  <button type="button" id="return_search1" onclick="location.href='${appRoot}/product/search'" class="btn btn-primary">상품목록</button>
	  <button type="button" id="edit_submit1" class="btn btn-warning">상품정보 수정</button>
	  <button type="button" id="remove_submit1" class="btn btn-danger">상품정보 삭제</button>
	</div>
	</form>		

</body>
</html>