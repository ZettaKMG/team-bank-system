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

<%-- 회원정보 링크 --%>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	<c:url value="/user/info" var="userInfoUrl">
		<c:param name="user_id" value="${principal.username }" />
	</c:url>
</sec:authorize>

<div class="border border-success container mt-3">
	<nav class="navbar navbar-expand-lg">
		<div class="container-fluid">			
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
									<a class="dropdown-item" href="${appRoot }/account/account_list">계좌조회</a>
								</li>
							</sec:authorize>
							<sec:authorize access="hasAnyRole('ADMIN, SERVICE')">
								<li>
									<a class="dropdown-item" href="${appRoot }/account/account_register">계좌등록</a>
								</li>
							</sec:authorize>
						</ul>
					</li>
					<sec:authorize access="hasRole('ADMIN')">
						<li class="nav-item">
							<a class="nav-link" href="${appRoot }/user/list">멤버조회</a>
						</li>
					</sec:authorize>
					<sec:authorize access="not isAuthenticated()">
						<li class="nav-item">
							<a class="nav-link" href="${appRoot }/account/account_transfer">계좌이체</a>
						</li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li class="nav-item">
							<a class="nav-link" ${current == 'info' ? 'active' : '' } href="${userInfoUrl }">마이페이지</a>
						</li>
					</sec:authorize>
					<sec:authorize access="not isAuthenticated()">
						<li class="nav-item">
							<a class="nav-link" ${current == 'login' ? 'active' : '' } href="${loginUrl }">로그인</a>
						</li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li class="nav-item">						
							<a class="nav-link" href="${logoutUrl }">로그아웃</a>								
						</li>		
					</sec:authorize>
					<sec:authorize access="not isAuthenticated()">		
						<li class="nav-item">
							<a class="nav-link" ${current == 'signup' ? 'active' : '' } href="${signUpUrl }">회원가입</a>
						</li>
					</sec:authorize>
					<c:choose>	
						<c:when test="${principal.username != '' }">
							<div class="grid">					 
							  <div class="g-col-3 g-start-9">
							  	<input class="form-control" type="text" value="${principal.username } 님 환영합니다!" aria-label="readonly input example" readonly>
							  </div>
							</div>
						</c:when>									
						<c:when test="${principal.username == '' }">
							<div class="grid">					 
							  <div class="g-col-3 g-start-9">
							  	<input class="form-control" type="text" value="익명의 고객님 반갑습니다!" aria-label="readonly input example" readonly>
							  </div>
							</div>
						</c:when>		
					</c:choose>								 
				</ul>
			</div>
		</div>
	</nav>
</div>