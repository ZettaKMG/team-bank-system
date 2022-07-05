<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags" %>
<%@ page import="java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<title>Insert title here</title>
</head>
<body>
	<bank:navBar current="qnaList"></bank:navBar>
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<table class="table">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${qnaList }" var="qna">
						<tr>
							<td>${qna.id }</td>							
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
							<td>${qna.user_id }</td>
							<td>${qna.newInserted }</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<sec:authorize access="isAuthenticated()">
					<div class="submit-button-group">
						<form action="${appRoot }/qnaBoard/write">
							<button class="btn btn-primary" type="submit"><i class="fa-solid fa-pencil"></i> 글쓰기</button>
						</form>
					</div>
				</sec:authorize>
			</div>
		</div>
		
		<bank:qna_page_nav></bank:qna_page_nav>
	</div>
</body>
</html>