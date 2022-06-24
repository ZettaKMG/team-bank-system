<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ attribute name = "current" %>


<!-- 상품 게시판 관련 링크 -->
<c:url value="/product/search" var="searchUrl" />
<c:url value="/product/registration" var="registrationUrl" />

<!-- 회원 정보 관련 링크 -->
<c:url value="/user/list" var="userListUrl"></c:url>
<c:url value="/user/info" var="userInfoUrl"></c:url>
<c:url value="/user/signup" var="signUpUrl"></c:url>
<c:url value="/user/login" var="loginUrl"></c:url>
<c:url value="/logout" var="logoutUrl"></c:url>

<!-- 문의 관련 링크 -->
<c:url value="/qnaBoard/list" var="qnaUrl"></c:url>

<!-- 계좌 관련 링크 -->
<c:url value="/account/account_list" var="accountListUrl"></c:url>
<c:url value="/account/account_register" var="accountRegUrl"></c:url>
<c:url value="/account/account_transfer" var="accountTransUrl"></c:url>

<%-- 회원정보링크 --%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<c:url value="/user/info" var="userInfoUrl">
		<c:param name="user_id" value="${principal.username }" />
	</c:url>
</sec:authorize>

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
								<a class="dropdown-item" href="${searchUrl }">상품조회</a>
							</li>
							<sec:authorize access="hasAnyRole('ADMIN, PRODUCT')">
								<li>
									<a class="dropdown-item" href="${registrationUrl }">상품등록</a>
								</li>
							</sec:authorize>
						</ul>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" id="account"
							role="button" data-bs-toggle="dropdown" aria-expanded="false">
							계좌 </a>
						<ul class="dropdown-menu" aria-labelledby="account">

							<sec:authorize access="isAuthenticated()">
								<li>
									<a class="dropdown-item" href="${accountListUrl }">계좌조회</a>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ADMIN, SERVICE')">
								<li>
									<a class="dropdown-item" href="${accountRegUrl }">계좌등록</a>
								</li>
							</sec:authorize>
						</ul>
					</li>
					
					<li class="nav-item">
						<a class="nav-link" ${current == 'transfer' ? 'active' : '' } href="${accountTransUrl }">계좌이체</a>
					</li>
					
					<li class="nav-item">
						<a class="nav-link" ${current == 'qna' ? 'active' : '' } href="${qnaUrl }">문의</a>
					</li>
					
					<sec:authorize access="isAuthenticated()">
						<li class="nav-item">
							<a class="nav-link" ${current == 'info' ? 'active' : '' } href="${userInfoUrl }">마이페이지</a>
						</li>
					</sec:authorize>
					
					<sec:authorize access="hasRole('ADMIN')">
					    <li class="nav-item">
					      	<a class="nav-link ${current == 'userList' ? 'active' : '' }" href="${userListUrl }">회원 목록</a>
						</li>
			        </sec:authorize>
			
					<sec:authorize access="not isAuthenticated()">
				      	<li class="nav-item">
				        	<a class="nav-link ${current == 'signup' ? 'active' : '' }" href="${signUpUrl }">회원 가입</a>
				        </li>
				        
				        <li class="nav-item">
				        	<a class="nav-link ${current == 'login' ? 'active' : '' }" href="${loginUrl }">로그인</a>
				        </li>
			        </sec:authorize>
			        
			        <sec:authorize access="isAuthenticated()">
			        	<li class="nav-item">
			        		<button class="btn btn-link nav-link" type="submit" form="logoutForm">로그아웃</button>
			        	</li>
			        </sec:authorize>
										
				</ul>
				<!-- 로그인시에는 "로그인한 ID 님 환영합니다!!!" 메세지를, 비로그인시에는 "비로그인 상태입니다!"메세지 출력  -->
				<div class="d-flex justify-content-right">
					<c:choose>	
						<c:when test="${not empty principal.username }">
							<div class="grid">					 
							  <div class="g-col-3 g-start-9">								  	
							  	<input class="form-control text-center" type="text" value="${principal.username } 님 환영합니다!" aria-label="readonly input example" readonly>
							  </div>
							</div>
						</c:when>									
						<c:when test="${empty principal.username }">
							<div class="grid">					 
							  <div class="g-col-3 g-start-9">
							  	<input class="form-control text-center" type="text" value="비로그인 상태입니다" aria-label="readonly input example" readonly>
							  </div>
							</div>
						</c:when>		
					</c:choose>								 
				</div>

				<div class="d-none">
			    	<form action="${logoutUrl }" id="logoutForm" method="post"></form>
			    </div>
						

			</div>
		</div>
	</nav>
</div>