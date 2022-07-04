<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
	<title>Home</title>
</head>
<body>
<bank:navBar></bank:navBar>

	<div class="container">
		<div class="row justify-content-center mt-3">
			<div class="col-12 col-lg-9 p-0">
				<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
						<button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
					</div>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img src="https://drive.google.com/uc?id=1LnBl978Jsq9IQSIHRsvjmmFm9Jdr-x0h" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>이벤트1</h5>
								<p>Some representative placeholder content for the first slide.</p>
							</div>
						</div>
						<div class="carousel-item">
							<img src="https://drive.google.com/uc?id=1LnBl978Jsq9IQSIHRsvjmmFm9Jdr-x0h" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>이벤트2</h5>
								<p>Some representative placeholder content for the second slide.</p>
							</div>
						</div>
						<div class="carousel-item">
							<img src="https://drive.google.com/uc?id=1LnBl978Jsq9IQSIHRsvjmmFm9Jdr-x0h" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>이벤트3</h5>
								<p>Some representative placeholder content for the third slide.</p>
							</div>
						</div>
					</div>
					<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"	data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>
			<div class="col-12 col-lg-3 p-2">
				<div>
					<h1>개인 메뉴</h1>				
				</div>
			</div>
		</div>
		<div class="row d-flex mt-3">
			<div class="col-6 border">
				<h1>컨텐츠1</h1>
			</div>
			<div class="col-6 border">
				<div class="d-flex mt-3">
					<div class="justify-content-center">
						<h5>문의 게시판</h5>
					</div>
					<a href="${appRoot }/qnaBoard/list" class="ms-auto">
						<small>more..</small>
					</a>
				</div>
				<div class="mt-2">
					<table class="table table-bordered">
						<c:forEach begin="0" end="4" items="${qnaList }" var="qna">
							<tr>
								<c:url value="/qnaBoard/get" var="getUrl">
									<c:param name="id" value="${qna.id }"></c:param>
								</c:url>
								<td onClick="location.href='${getUrl }'" style="cursor:pointer;">
									<c:if test="${qna.qna_dep != 0}">
										<span style="margin-left :${qna.qna_dep * 10}px;"><i class="bi bi-arrow-return-right"></i></span> 
									</c:if>
									<c:out value="${qna.title }" /> 
									<c:if test="${qna.num_of_reply > 0 }">
											<span class="badge rounded-pill bg-light text-dark">
												<i class="fa-solid fa-comment-dots"></i>
												${qna.num_of_reply }
											</span>
									</c:if>
								</td>
							</tr>						
						</c:forEach>
					</table>
				</div>
			</div>
		</div>

		<div class="row mt-3 text-center border">
			<div class="d-flex mt-3">
				<h5>상품</h5>
				<small class="ms-auto">more..</small>
			</div>
			<div class="col">
				<div class="card mb-4 rounded-3 shadow-sm">
					<div class="card-header py-3">
						<h4 class="my-0 fw-normal">상품1</h4>
					</div>
					<div class="card-body">
						<h1 class="card-title pricing-card-title">
							$0
							<small class="text-muted fw-light">/mo</small>
						</h1>
						<ul class="list-unstyled mt-3 mb-4">
							<li>설명1</li>
							<li>설명2</li>
							<li>설명3</li>
							<li>설명4</li>
						</ul>
						<button type="button" class="w-100 btn btn-lg btn-outline-primary">가입하기</button>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card mb-4 rounded-3 shadow-sm">
					<div class="card-header py-3">
						<h4 class="my-0 fw-normal">상품2</h4>
					</div>
					<div class="card-body">
						<h1 class="card-title pricing-card-title">
							$15
							<small class="text-muted fw-light">/mo</small>
						</h1>
						<ul class="list-unstyled mt-3 mb-4">
							<li>설명1</li>
							<li>설명2</li>
							<li>설명3</li>
							<li>설명4</li>
						</ul>
						<button type="button" class="w-100 btn btn-lg btn-outline-primary">가입하기</button>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card mb-4 rounded-3 shadow-sm">
					<div class="card-header py-3">
						<h4 class="my-0 fw-normal">상품3</h4>
					</div>
					<div class="card-body">
						<h1 class="card-title pricing-card-title">
							$29
							<small class="text-muted fw-light">/mo</small>
						</h1>
						<ul class="list-unstyled mt-3 mb-4">
							<li>설명1</li>
							<li>설명2</li>
							<li>설명3</li>
							<li>설명4</li>
						</ul>
						<button type="button" class="w-100 btn btn-lg btn-outline-primary">가입하기</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
