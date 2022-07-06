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
						<div class="carousel-item active" onclick="javascript:location.href='${appRoot}/product/search'" style="cursor: pointer">
							<img src="https://drive.google.com/uc?id=1LnBl978Jsq9IQSIHRsvjmmFm9Jdr-x0h" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>이벤트1</h5>
								<p>상품 가입 이벤트1</p>
							</div>
						</div>
						<div class="carousel-item" onclick="javascript:location.href='${appRoot}/product/search'" style="cursor: pointer">
							<img src="https://drive.google.com/uc?id=1LnBl978Jsq9IQSIHRsvjmmFm9Jdr-x0h" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>이벤트2</h5>
								<p>상품 가입 이벤트2</p>
							</div>
						</div>
						<div class="carousel-item" onclick="javascript:location.href='${appRoot}/product/search'" style="cursor: pointer">
							<img src="https://drive.google.com/uc?id=1LnBl978Jsq9IQSIHRsvjmmFm9Jdr-x0h" class="d-block w-100" alt="...">
							<div class="carousel-caption d-none d-md-block">
								<h5>이벤트3</h5>
								<p>상품 가입 이벤트3</p>
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
			<div class="col-12 col-lg-3 p-2 border">
				<c:choose>
					<c:when test="${not empty principal.username }">
						<div class="mx-5 mt-3">
							<div class="row align-center">
								<h5><i class="bi bi-person-bounding-box"></i> ${principal.username }</h5>			
							</div>
							<div class="row mt-5">
								<div class="col">
									<button class="btn btn-outline-dark" onClick="location.href='${appRoot }/user/info?user_id=${principal.username }'">내 정보</button>
								</div>
								<div class="col">
									<c:choose>
										<c:when test="${accountNum != 0 }">
											<button class="btn btn-outline-dark" onClick="location.href='${appRoot }/account/account_list'">내 계좌</button>						
										</c:when>
										<c:when test="${accountNum == 0 }">
											<sec:authorize access="hasRole('ROLE_USER')">
												<button class="btn btn-outline-dark" onClick="location.href='${appRoot }/product/search'">새 계좌 개설</button>
											</sec:authorize>
										</c:when>
									</c:choose>
								</div>
							</div>
						</div>
					</c:when>
					<c:when test="${empty principal.username }">
						<div style="text-align: center">
							<h5>로그인이 필요합니다.</h5>
						</div>
						<div class="mt-5" style="text-align: center">
							<button class="btn btn-outline-primary" onClick="location.href='${appRoot}/user/login'">로그인</button>
						</div>
					</c:when>
				</c:choose>
			</div>
		</div>

		<div class="row mt-3 text-center border">
			<div class="d-flex mt-3">
				<h5>상품</h5>
				<a href="${appRoot }/product/search" class="ms-auto">
					<small>more..</small>
				</a>
			</div>
			
			<c:forEach items="${productList }" var="product">
				<div class="col">
					<div class="card mb-4 rounded-3 shadow-sm">
						<div class="card-header py-3">
							<h5 class="my-0 fw-normal"><c:out value="${product.item_name }" /></h5>
						</div>
						<div class="card-body">
							<h6 class="card-title pricing-card-title">
								상품 종류 : <c:out value="${product.sav_method }" />
							</h6>
							<ul class="list-unstyled mt-3 mb-4">
								<li>
						    		이율 : <strong><c:out value="연 ${product.rate * 100 }%" /></strong>
					    		</li>
								<li>
					   				가입기간 : <c:out value="${product.exp_period }개월" />
								</li>
								<li>
									<c:out value="${product.summary }" />
								</li>
							</ul>
							<c:url value="/product/detail" var="detail_url">
					  			<c:param name="id" value="${product.id }"></c:param>
					 		</c:url>
							<button type="button" class="w-100 btn btn-lg btn-outline-primary" onClick="location.href='${detail_url }'">가입하기</button>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		
		
		<div class="row d-flex mt-3">
			<div class="col-12 border">
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
		
	</div>

</body>
</html>
