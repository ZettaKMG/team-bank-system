<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<!-- modal창 보여주기 -->
<script type="text/javascript">
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
			<form id="condition_search" action="${appRoot }/product/search" method="get">
				<div class="mt-3">
					<table class="table table-borderless">					  
						<tbody class="table-group-divider">
							<tr>								
								<th scope="row">상품명</th>															
							    <td>
							    	<div id="item_name" class="input-group input-group-sm mb-3">
							     		<input type="text" value="${param.keyword }" name="keyword" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-sm">
							     	</div>
							    </td>
							</tr>						  
							<tr>
								<th scope="row">상품종류</th>
							    <td>
							    	<div id="sav_method" name="sav_method">
							    	<div class="form-check form-check-inline">
										<input ${param.sav_method == "예금" ? "checked" : "" } class="form-check-input" type="radio" name="sav_method" id="deposit" value="예금">
		 							    <label class="form-check-label" for="deposit">예금</label>
		 							</div>
		                    		<div class="form-check form-check-inline">
		 							    <input ${param.sav_method == "적금" ? "checked" : "" } class="form-check-input" type="radio" name="sav_method" id="savings" value="적금">
									    <label class="form-check-label" for="savings">적금</label>
									</div>
							    	</div>
							    </td>
							</tr>
							<tr>
								<th scope="row">가입기간</th>
							    <td>
							    	<div id="exp_period" name="exp_period">
							    	<div class="form-check form-check-inline">
										<input ${param.exp_period == "" ? "checked" : "" } class="form-check-input" type="radio" name="exp_period" id="none" value="">
		 							    <label class="form-check-label" for="none">없음</label>
									</div>
		                    		<div class="form-check form-check-inline">
									    <input ${param.exp_period == "12" ? "checked" : "" } class="form-check-input" type="radio" name="exp_period" id="one_year" value="12">
									    <label class="form-check-label" for="one_year">12개월</label>
									</div>
									<div class="form-check form-check-inline">
									    <input ${param.exp_period == "24" ? "checked" : "" } class="form-check-input" type="radio" name="exp_period" id="two_years" value="24">
		 							    <label class="form-check-label" for="two_years">24개월</label>
									</div>
		                    		<div class="form-check form-check-inline">
										<input ${param.exp_period == "36" ? "checked" : "" } class="form-check-input" type="radio" name="exp_period" id="three_years" value="36">
									    <label class="form-check-label" for="three_years">36개월</label>
									</div>
							    	</div>
							    </td>
							</tr>
							<tr>
								<th scope="row">이율</th>
							    <td>
							    	<div id="rate" name="rate">
							    	<div class="form-check form-check-inline">
										<input ${param.rate == "rate_all" ? "checked" : "" } class="form-check-input" type="radio" name="rate" id="all" value="rate_all">
		 							    <label class="form-check-label" for="all">전체</label>
									</div>
		                    		<div class="form-check form-check-inline">
										<input ${param.rate == "rate1" ? "checked" : "" } class="form-check-input" type="radio" name="rate" id="opt1" value="rate1">
									    <label class="form-check-label" for="opt1">~ 연 2.0%</label>
									</div>
									<div class="form-check form-check-inline">
									  <input ${param.rate == "rate2" ? "checked" : "" } class="form-check-input" type="radio" name="rate" id="opt2" value="rate2">
		 							  <label class="form-check-label" for="opt2">연 2.1% ~</label>
									</div>
							    	</div>
								</td>
							</tr>
						</tbody>					
					</table>
					<figure class="text-center">
					<button id="condition_search_button" type="submit" class="btn btn-secondary">조회</button>
					</figure>
				</div>		
			</form>
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
				  <ul class="product_list">
					  <li>
					  <c:url value="/product/detail" var="detail_url">
					  	<c:param name="id" value="${product.id }"></c:param>
					  </c:url>
					  <a href="${detail_url }" class="list-group-item list-group-item-action">
					    <div class="d-flex w-100 justify-content-between">
					      <h5 class="mb-1"><strong><c:out value="${product.item_name }" /></strong></h5>
					    </div>
					    <p class="mb-1"><c:out value="${product.summary }" /></p>
					    <small class="text-muted">상품종류 : <c:out value="${product.sav_method }, " /></small>
					    <small class="text-muted">
					    	<c:choose>
					    		<c:when test="${product.exp_period != 0 }">
					    			이율 : <strong><c:out value="연 ${product.rate * 100 }%, " /></strong>
					    		</c:when>
					    		<c:otherwise>
					    			이율 : <strong><c:out value="연 ${product.rate * 100 }%" /></strong>
					    		</c:otherwise>
					    	</c:choose>
					    </small>
					    <small class="text-muted">
					    	<c:if test="${product.exp_period != 0 }">
						   		가입기간 : <c:out value="${product.exp_period }개월" />
					    	</c:if>
					    </small>
					  </a>
					  </li>
				  </ul>
				</c:forEach>
			</div>	
			<bank:pagination></bank:pagination>
		</div>
	</div>	
	
</body>
</html>