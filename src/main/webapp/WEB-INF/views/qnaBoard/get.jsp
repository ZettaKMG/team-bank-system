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
<script>
	$(document).ready(function() {
		$("#qna-modify-button").click(function() {
			$("#qna-modify-button").addClass("d-none");
			$("#inputTitle").removeAttr("readonly");
			$("#inputText").removeAttr("readonly");
			$("#qna-modify-submit").removeClass("d-none");
		});
		
		$("#qna-modify-submit").click(function(e) {
			e.preventDefault();
			
			if(confirm("수정하시겠습니까?")) {
				let qnaForm = $("#qnaContentForm");
				let actionAttr = "${appRoot}/qnaBoard/modify";
				qnaForm.attr("action", actionAttr);
				qnaForm.submit();
			}
		});
		
		$("#qna-remove-submit").click(function(e) {
			e.preventDefault();
			
			if(confirm("삭제하시겠습니까?")) {
				let qnaForm = $("#qnaContentForm");
				let actionAttr = "${appRoot}/qnaBoard/remove";
				qnaForm.attr("action", actionAttr);
				qnaForm.submit();
			}
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<bank:navBar current="qnaWrite"></bank:navBar>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-10 mt-3">
				<form id="qnaContentForm" action="" method="post">
					<input type="hidden" name="id" value="${qna.id }"/>
					<div>
						<label class="form-label" for="inputTitle">제목</label>
						<input class="form-control" type="text" name="title" id="inputTitle" value="${qna.title }" readonly/>
					</div>
					
					<div>
						<label class="form-label" for="inputText">본문</label>
						<textarea class="form-control" name="body" id="inputText" cols="30" rows="10" readonly>${qna.body }</textarea>
					</div>
					
					<div class="button-group mt-3">
						<input type="button" class="btn btn-outline-primary" onclick="location.href='${appRoot }/qnaBoard/list';" value="목록" />
						<input type="button" id="qna-modify-button" class="btn btn-primary" value="수정" />
						<button id="qna-modify-submit" class="btn btn-primary d-none" >수정 완료</button> 
						<button id="qna-remove-submit" class="btn btn-danger">삭제</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>