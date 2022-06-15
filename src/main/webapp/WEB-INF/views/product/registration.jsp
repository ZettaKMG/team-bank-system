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

<title>상품등록 페이지</title>
</head>
<body>
	<bank:navBar current="registration"></bank:navBar>
	
	<div class="container">
		<form role="form" action="${appRoot }/product/registration" method="post">
			<div class="form-group">
			<div class="mt-5 mb-3">
				<label for="item_name" class="form-label"><h4>상품명</h4></label>
		  		<input type="text" class="form-control" name="item_name" id="item_name" placeholder="000예금/000적금" required />
			</div>
			</div>
			<div class="form-group">
			<div class="mt-1 mb-3">
				<label for="summary" class="form-label"><h4>상품요약</h4></label>
		  		<input type="text" class="form-control" name="summary" id="summary" placeholder="~~~를 위한 예금" required />
			</div>
			</div>
			
		    <div class="mt-3">
				<table class="table table-borderless">					  
					<tbody class="table-group-divider">
						<tr>					
							<td>
								<!-- check 타입이 생각보다 지저분해보여서 간단하게 input text 타입으로 바꿈 -->
								<div class="form-group">
								<div class="input-group mb-3">
								  <span class="input-group-text" id="sav_method">상품종류</span>
								  <input type="text" class="form-control" name="sav_method" placeholder="예금/적금" aria-label="Username" aria-describedby="sav_method" required />
								</div>
								</div>
							</td>	
						</tr>
						<tr>
							<td>
								<!-- check 타입이 생각보다 지저분해보여서 간단하게 input text 타입으로 바꿈 -->
								<div class="form-group">
								<div class="input-group mb-3">
								  <span class="input-group-text" id="exp_period">가입기간</span>
								  <input type="text" class="form-control" name="exp_period" placeholder="공란(예금)/1년/2년/3년" aria-label="Username" aria-describedby="exp_period" />
								</div>
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<!-- check 타입이 생각보다 지저분해보여서 간단하게 input text 타입으로 바꿈 -->
								<div class="form-group">
								<div class="input-group mb-3">
								  <span class="input-group-text" id="rate">이율</span>
								  <input type="text" class="form-control" name="rate" placeholder="0.5%부터 0.5% 단위로 입력" aria-label="Username" aria-describedby="rate" required />
								</div>
								</div>
							</td>
						</tr>
					</tbody>					
				</table>					
			</div>
			<div class="form-group">
			<div class="mt-3 mb-3">
				<label for="item_detail" class="form-label"><h4>상품 상세내용</h4></label>
			    <textarea class="form-control" name="detail" id="item_detail" rows="10"></textarea>
			</div>
			</div>
			<div class="mt-1 d-md-flex justify-content-md-center">
			    <button type="submit" class="btn btn-success">상품등록</button>
			</div>		
		
		</form>
	</div>

</body>
</html>