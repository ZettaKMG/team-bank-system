<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tag" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<title>상품조회 페이지</title>
</head>
<body>
	<tag:navBar></tag:navBar>

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
									<input class="form-check-input" type="radio" name="date" id="all" value="option1">
	 							    <label class="form-check-label" for="all">전체</label>
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
									<input class="form-check-input" type="radio" name="rate" id="all" value="option1">
	 							    <label class="form-check-label" for="all">전체</label>
								</div>
	                    		<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="rate" id="1.0" value="option2">
								    <label class="form-check-label" for="1.0">~ 연 1.0%</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="rate" id="2.0" value="option3">
	 							  <label class="form-check-label" for="2.0">연 1.1 ~ 2.0%</label>
								</div>
	                    		<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="rate" id="3.0" value="option4">
								  <label class="form-check-label" for="3.0">연 2.1% ~ 3.0%</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="rate" id="4.0" value="option4">
								  <label class="form-check-label" for="4.0">연 3.1% ~ 4.0%</label>
								</div>
								<div class="form-check form-check-inline">
								  <input class="form-check-input" type="radio" name="rate" id="5.0" value="option4">
								  <label class="form-check-label" for="5.0">연 4.1% ~ </label>
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
	
	<!-- 상품목록 조회 결과표시(조건 선택 안하면 그냥 전체 결과 표시) -->
	<div class="container">
		<div class="border border-success p-3 mt-5">
			<div class="list-group">
			  <a href="#" class="list-group-item list-group-item-action">
			    <div class="d-flex w-100 justify-content-between">
			      <h5 class="mb-1">수퍼 정기예금</h5>
			      <small>3 days ago</small>
			    </div>
			    <p class="mb-1">가입 조건을 직접 설정하는 예금</p>
			    <small class="text-muted">이율 : 연 1.0%</small>
			  </a>
			  <a href="#" class="list-group-item list-group-item-action">
			    <div class="d-flex w-100 justify-content-between">
			      <h5 class="mb-1">보통 정기예금</h5>
			      <small class="text-muted">3 days ago</small>
			    </div>
			    <p class="mb-1">본 은행의 대표 정기예금</p>
			    <small class="text-muted">이율 : 연 0.5%</small>
			  </a>
			  <a href="#" class="list-group-item list-group-item-action">
			    <div class="d-flex w-100 justify-content-between">
			      <h5 class="mb-1">첫 재테크예금</h5>
			      <small class="text-muted">3 days ago</small>
			    </div>
			    <p class="mb-1">재테크에 처음 도전하는 분들을 위한 예금</p>
			    <small class="text-muted">이율 : 연 1.5%</small>
			  </a>
			</div>		
			<tag:pagination></tag:pagination>
		</div>
	</div>	
	
</body>
</html>