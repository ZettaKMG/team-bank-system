<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script type="text/javascript">
	$(document).ready(function(){
		var result = '<c:out value="${result}"/>';
		
		check_modal(result);
		
		function check_modal(result) {
			if (result === '') {
				return ;
			}
			
			if (parseInt(result) > 0) {
				$(".modal-body").html("상품" + parseInt(result) + " 번이 등록되었습니다.");
			}
			
			$("#my_modal").modal("show");
		}
	});
</script>

<title>상품조회 페이지</title>
</head>
<body>
	<bank:navBar></bank:navBar>

	<!-- 상품목록 조회 조건선택 -->
	<div class="container">
		<div class="border border-success p-1 mt-5">
			<figure class="text-center">
				<h2>상 품 목 록 조 회</h2>
			</figure>
			<div class="mt-3">
				<table class="table table-borderless">					  
					<tbody class="table-group-divider">
						<tr>
							<th scope="row">상품명</th>
						    <td>
						    	<div class="input-group input-group-sm mb-3">
						     		<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
						     	</div>
						    </td>
						</tr>						  
						<tr>
							<th scope="row">상품종류</th>
						    <td>
						    	<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="type" id="deposit" value="option1">
	 							    <label class="form-check-label" for="deposit">예금</label>
								</div>
	                    		<div class="form-check form-check-inline">
								    <input class="form-check-input" type="radio" name="type" id="savings" value="option2">
								    <label class="form-check-label" for="savings">적금</label>
								</div>
						    </td>
						</tr>
						<tr>
							<th scope="row">가입기간</th>
						    <td>
						    	<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="date" id="none" value="option1">
	 							    <label class="form-check-label" for="none">없음</label>
								</div>
	                    		<div class="form-check form-check-inline">
								    <input class="form-check-input" type="radio" name="date" id="oneyear" value="option2">
								    <label class="form-check-label" for="oneyear">1년</label>
								</div>
								<div class="form-check form-check-inline">
								    <input class="form-check-input" type="radio" name="date" id="twoyears" value="option3">
	 							    <label class="form-check-label" for="twoyears">2년</label>
								</div>
	                    		<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="date" id="threeyears" value="option4">
								    <label class="form-check-label" for="threeyears">3년</label>
								</div>
						    </td>
						</tr>
						<tr>
							<th scope="row">이자율</th>
						    <td>
						    	<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rate" id="all" value="option0">
	 							    <label class="form-check-label" for="none">전체</label>
								</div>
	                    		<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rate" id="opt1" value="option1">
								    <label class="form-check-label" for="opt1">~ 연 1.5%</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="rate" id="opt2" value="option2">
	 							  <label class="form-check-label" for="opt2">연 1.6 ~ 3.0%</label>
								</div>
	                    		<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="rate" id="opt3" value="option3">
								  <label class="form-check-label" for="opt3">연 3.1% ~</label>
								</div>
							</td>
						</tr>
					</tbody>					
				</table>
				<figure class="text-center">
				<button type="button" class="btn btn-secondary">조회</button>
				</figure>
			</div>		
		</div>
	</div>
	
	<!-- 상품 등록/삭제 여부 표시 modal -->
	<c:if test="${not empty message }">
		<div class="modal" id="my_modal" tabindex="-1" role="dialog" area-labelledby="my_modal_lable" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="my_modal_lable">상품 등록/삭제 여부</h5>
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
	
	<!-- 상품목록 조회 결과표시(조건 선택 안하면 그냥 전체 결과 표시) -->
	<div class="container">
		<div class="border border-success p-3 mt-5">
			<div class="list-group">
				<c:forEach items="${product_list }" var="product">
				  <c:url value="/product/detail" var="detail_url">
				  	<c:param name="id" value="${product.id }"></c:param>
				  </c:url>
				  <a href="${detail_url }" class="list-group-item list-group-item-action">
				    <div class="d-flex w-100 justify-content-between">
				      <h5 class="mb-1"><c:out value="${product.item_name }" /></h5>
				    </div>
				    <p class="mb-1"><c:out value="${product.item_summary }" /></p>
				    <small class="text-muted">가입기간 : <c:out value="${product.exp_period }" /></small>
				    <small class="text-muted">이율 : <c:out value="${product.rate } %" /></small>
				  </a>
				</c:forEach>
			</div>	
			<bank:pagination></bank:pagination>
		</div>
	</div>	
	
</body>
</html>