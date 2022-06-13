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
	

	
<title>상품 상세 정보 페이지</title>
</head>
<body>
	<bank:navBar></bank:navBar>

	<div class="container">			
	    <div class="mt-5">
	    	<!-- 편집버튼(권한 있는 유저에게만 보이게끔) -->
	    	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			  <button id="edit_button1" type="button" class="btn btn-warning">편집하기</button>			
			</div>
	    	<!-- 상품 개요 -->		    	
			<table class="table table-borderless">					  
				<tbody class="table-group-divider">
					<tr>					
						<th scope="row"><h4>상품명</h4></th>
							<td>
								<p><strong>000예금 / 000적금</strong></p>							
							</td>
					</tr>
					<tr>					
						<th scope="row"><h4>상품요약</h4></th>
							<td>
								<p><strong>~~~를 위한 예금</strong></p>							
							</td>
					</tr>					
					<tr>					
						<th scope="row"><h4>상품종류</h4></th>
							<td>
								<p><strong>예금</strong></p>							
							</td>
					</tr>
					<tr>
						<th scope="row"><h4>가입기간</h4></th>
							<td>
								<p><strong>없음</strong></p>
							</td>
					</tr>
					<tr>
						<th scope="row"><h4>이자율</h4></th>
							<td>
								<p><strong>0.5%</strong></p>
							</td>
					</tr>
				</tbody>					
			</table>					
		</div>
		<!-- 상품 상세내용 -->
		<div class="mt-3 mb-3">
			<label for="productDetail" class="form-label"><h4>상품 상세내용</h4></label>
		    <textarea class="form-control" id="productDetail" rows="15" readonly></textarea>
		</div>
	</div>
	
	<%-- 댓글 쪽은 안할 수도 있음 --%>
	<%-- 댓글 추가(로그인한 일반 유저 권한 이상에서만 활성화) --%>	
	<%--
	<div class="container mt-5">
		<div class="row">
			<div class="col">
				<form id="insertReplyForm1">
					<h5><strong>댓글쓰기</strong></h5>							
					<div class="input-group">
						<input id="insertReplyContentInput1" class="form-control" type="text" name="content" required />
						<button id="addReplySubmitButton1" class="btn btn-outline-secondary">댓글 등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>	
	 --%>
	
	<%-- 댓글 목록 --%>
	<%--
	<div class="container mt-5">
		<div class="row">
			<div class="col">
				<h5><strong>댓글 5개</strong></h5>
				<ul class="list-group">
					<li class="list-group-item">댓글 1</li>
					<li class="list-group-item">댓글 2</li>
					<li class="list-group-item">댓글 3</li>
					<li class="list-group-item">댓글 4</li>
					<li class="list-group-item">댓글 5</li>
				</ul>
			</div>
		</div>
	</div>
	 --%>
	
	<%-- 댓글 수정/삭제(작성자 본인과 관리자만 수정/삭제 가능하게끔) --%>
	

</body>
</html>