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
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.min.js" integrity="sha512-OvBgP9A2JBgiRad/mM36mkzXSXaJE9BEIENnVEmeZdITvwT09xnxLtT4twkCa8m/loMbPHsvPl0T8lRGVBwjlQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<title>Insert title here</title>
</head>
<body>
	<bank:navBar current="qnaWrite"></bank:navBar>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-10 mt-3">
				<h3>문의</h3>
				<form action="${appRoot }/qnaBoard/write" method="post">
					<c:if test="${not empty param.id }">
						<input type="hidden" name="qna_parent" value="<c:out value="${param.id }"></c:out>"/>
						<input type="hidden" name="qna_dep" value="<c:out value="${param.dep }"></c:out>"/>
					</c:if>
					<div>
						<label class="form-label" for="inputTitle">제목</label>
						<input class="form-control" type="text" name="title" required id="inputTitle" />
					</div>
					
					<div>
						<label class="form-label" for="inputText">본문</label>
						<textarea class="form-control" name="body" id="inputText" cols="30" rows="10"></textarea>
					</div>
					
					<div class="button-group mt-3">
						<button class="btn btn-primary">작성</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>