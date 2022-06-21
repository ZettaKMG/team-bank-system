<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name = "current" %>


<div class="border border-success container mt-3">
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
		<a class="navbar-brand" href="#"><i class="fa-solid fa-house"></i></a>
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      			<span class="navbar-toggler-icon"></span>
    		</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-5 mb-lg-0">
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="product"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
							상품 </a>
						<ul class="dropdown-menu" aria-labelledby="product">
							<li>
								<a class="dropdown-item" href="${appRoot }/product/search">상품조회</a>
							</li>
							<li>
								<a class="dropdown-item" href="${appRoot }/product/registration">상품등록</a>
							</li>
						</ul>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="account"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
							계좌 </a>
						<ul class="dropdown-menu" aria-labelledby="account">
							<li>
								<a class="dropdown-item" href="${appRoot }/account/account_list">계좌조회</a>
							</li>
							<li>
								<a class="dropdown-item"
									href="${appRoot }/account/account_register">계좌등록</a>
							</li>
						</ul>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">멤버조회</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="${appRoot }/account/account_transfer">계좌이체</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">마이페이지</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">로그인/로그아웃</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="#">회원가입</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
</div>