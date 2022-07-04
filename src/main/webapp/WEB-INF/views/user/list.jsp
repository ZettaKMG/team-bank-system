<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"	referrerpolicy="no-referrer"></script>
	
<script>
	$(document).ready(function() {
		// select box 변경에 따라 회원 목록 변경
		const listUser = function() {
			var data = {role : $("#selectUserRole").val()};
			$.ajax({
				url : "${appRoot}/user/list",
				type : "post",
				data : data,
				dataType : "json",
				success : function(list){
					const userListElement = $("#divUserList");
					userListElement.empty();
					
					for(let i = 0; i < list.length; i++) {
						const userElement = $("<div class='my-3 p-3 bg-body rounded shadow-sm d-flex' />");
						var roleName = "";
						
						switch (list[i].user_role) {
						case 'ROLE_ADMIN':
							roleName = "총괄 관리자";
							break;
						case 'ROLE_PRODUCT':
							roleName = "상품 관리자";
							break;
						case 'ROLE_SERVICE':
							roleName = "문의 관리자";
							break;
						case 'ROLE_USER':
							roleName = "일반 회원";
							break;
						}
						userElement.html(`

								<a href="${appRoot}/user/info?user_id=\${list[i].user_id }">
									<div class="d-flex text-muted">
										<svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32">
											<rect width="100%" height="100%" fill="#007bff"></rect>
										</svg>
									
										<p class="mb-0 small lh-sm border-bottom">
												<strong class="d-flex text-gray-dark my-1"> \${roleName} </strong>
											<strong class="d-flex text-gray-dark">\${list[i].user_id }</strong>
											<i class="fa-solid fa-mobile-screen mx-1"></i>\${list[i].user_phone } <i class="fa-solid fa-envelope mx-1"></i>\${list[i].user_email }
										</p>
									</div>
								</a>
						`);
						userListElement.append(userElement);
					}
				},
				error : function() {
					console.log("목록 조회 문제 발생");
				},
				complete : function() {
					console.log("목록 조회 완료");
				}
			});
		}
		$("#selectUserRole").change(listUser);
		
		// 회원 ID 검색
		const userSearch = function() {
			var data = {
					role : $("#selectUserRole").val(),
					keyword : $("#idSearchInput").val()
			};
			$.ajax({
				url : "${appRoot}/user/search",
				type : "post",
				data : data,
				dataType : "json",
				success : function(list){
					const userListElement = $("#divUserList");
					userListElement.empty();
					
					for(let i = 0; i < list.length; i++) {
						const userElement = $("<div class='my-3 p-3 bg-body rounded shadow-sm d-flex' />");
						var roleName = "";
						
						switch (list[i].user_role) {
						case 'ROLE_ADMIN':
							roleName = "총괄 관리자";
							break;
						case 'ROLE_PRODUCT':
							roleName = "상품 관리자";
							break;
						case 'ROLE_SERVICE':
							roleName = "문의 관리자";
							break;
						case 'ROLE_USER':
							roleName = "일반 회원";
							break;
						}
						userElement.html(`
								<a href="${appRoot}/user/info?user_id=\${list[i].user_id }">
									<div class="d-flex text-muted">
										<svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32">
											<rect width="100%" height="100%" fill="#007bff"></rect>
										</svg>
									
										<p class="mb-0 small lh-sm border-bottom">
												<strong class="d-flex text-gray-dark my-1"> \${roleName} </strong>
											<strong class="d-flex text-gray-dark">\${list[i].user_id }</strong>
											<i class="fa-solid fa-mobile-screen mx-1"></i>\${list[i].user_phone } <i class="fa-solid fa-envelope mx-1"></i>\${list[i].user_email }
										</p>
									</div>
								</a>
						`);
						userListElement.append(userElement);
					}	
				},
				error : function() {
					console.log("ID 검색 문제 발생");
				},
				complete : function() {
					console.log("ID 검색 완료");
				}
			});
		}
		$("#idSearchBtn").click(userSearch);
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<bank:navBar current="userList"></bank:navBar>

	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-10">			

				<div class="d-flex align-items-center p-3 my-3 text-white bg-primary rounded shadow-sm">
					<div>
						<select class="form-select mx-2" name="selectUserRole" id="selectUserRole" >
							<option value="ALL">전체</option>
							<option value="ROLE_ADMIN">총괄 관리자</option>
							<option value="ROLE_PRODUCT">상품 관리자</option>
							<option value="ROLE_SERVICE">문의 관리자</option>
							<option value="ROLE_USER">일반 회원</option>
						</select>
					</div>
					<div class="d-flex mx-3">
						<h1 class="h6 text-white">회원 목록</h1>
					</div>
					<div class="d-flex ms-auto">
				      	<input id="idSearchInput" type="search" class="form-control mx-3" name="keyword"/>
				      	<button id="idSearchBtn" class="btn btn-outline-light"><i class="fa-solid fa-magnifying-glass"></i></button>
					</div>
				</div>
				
				<div id="divUserList">
					<c:forEach items="${userList }" var="user">
							<div class="my-3 p-3 bg-body rounded shadow-sm d-flex">
								<c:url value="/user/info" var="getUserUrl">
									<c:param name="user_id" value="${user.user_id }"></c:param>
								</c:url>
								<a href="${getUserUrl }">
									<div class="d-flex text-muted">
										<svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32">
												<rect width="100%" height="100%" fill="#007bff"></rect>
										</svg>
									
										<p class="mb-0 small lh-sm border-bottom">
											<c:choose>
												<c:when test="${user.user_role == 'ROLE_ADMIN'}"> <strong class="d-flex text-gray-dark my-1"> 총괄 관리자 </strong> </c:when>
												<c:when test="${user.user_role == 'ROLE_PRODUCT'}"> <strong class="d-flex text-gray-dark my-1"> 상품 관리자 </strong> </c:when>
												<c:when test="${user.user_role == 'ROLE_SERVICE'}"> <strong class="d-flex text-gray-dark my-1"> 문의 관리자 </strong> </c:when>
												<c:when test="${user.user_role == 'ROLE_USER'}"> <strong class="d-flex text-gray-dark my-1"> 일반 회원 </strong> </c:when>
											</c:choose>
											<strong class="d-flex text-gray-dark">${user.user_id }</strong>
											<i class="fa-solid fa-mobile-screen mx-1"></i>${user.user_phone } <i class="fa-solid fa-envelope mx-1"></i>${user.user_email }
										</p>
									</div>
								</a>
							</div>
					</c:forEach>
				</div>
	
			</div>
		</div>
	</div>
</body>
</html>