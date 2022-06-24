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
		
		// 페이지 로딩 후 댓글 목록
		const listReply = function() {
			const data = {qna_id : ${qna.id}};
			$.ajax({
				url : "${appRoot}/qnaReply/list",
				type : "post",
				data : data,
				dataType : "json",
				success : function(list) {
					const replyListElement = $("#replyList");
					replyListElement.empty();
					
					// 댓글 개수
					$("#numOfReply1").text(list.length);
					
					for (let i = 0; i < list.length; i++) {
						const replyElement = $("<li class='list-group-item' />");
						replyElement.html(`
							<div id="replyDisplayContainer\${list[i].id }">
								<div class="d-flex fw-bold">
									<i class="fa-solid fa-comment"></i>
									<span class="mx-2">\${list[i].user_id}</span>
									<div class="ms-auto">
										<span class="reply-edit-toggle-button badge bg-info text-dark"
											id="replyEditToggleButton${list[i].id }"
											data-reply-id="\${list[i].id }">
											<i class="fa-solid fa-pen-to-square"></i>
										</span>
										<span class="reply-delete-button badge bg-danger"
											data-reply-id="\${list[i].id }">
											<i class="fa-solid fa-trash-can"></i>
										</span>
									</div>
								</div>
								<div class="d-flex form-label">
									<span><c:out value="\${list[i].qna_rep_content }" /></span>
									<span class="ms-auto">\${list[i].changeTimeInserted }</span>
								</div>
							</div>

							<div id="replyEditFormContainer\${list[i].id }"
								style="display: none;">
								<form action="${appRoot }/reply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="boardId" value="${qna.id }" />
										<input type="hidden" name="id" value="\${list[i].id }" />
										<input class="form-control" value="\${list[i].qna_rep_content }"
											type="text" name="content" required />
										<button class="btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>
						`);
						replyListElement.append(replyElement);
					}
				}, 
				error : function() {
					console.log("댓글 가져오기 실패");
				}
			});
		}
		
		// 댓글 가져오는 함수 실행
		listReply();
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<bank:navBar current="qnaWrite"></bank:navBar>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-10 mt-3">
				<div>
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
				
				<%-- 댓글 추가 form --%>
				<div class="row mt-3">
					<form id="addReplyForm" action="${appRoot}/qnaReply/write" method="post">
						<div class="input-group">
							<input type="hidden" name="qna_id" value="${qna.id }" />
							<input id="addReplyContentInput" class="form-control" type="text" name="qna_rep_content" required />
							<button id="addReplySubmitButton" class="btn btn-outline-secondary">
								<i class="fa-solid fa-comment-dots"></i>
							</button>
						</div>
					</form>
				</div>
				
				<div class="row mt-3">
					<div class="alert alert-primary" style="display:none; " id="replyMessage"></div>
				</div>
				
				<div class="row mt-3">
					<div class="col">
						<h3>댓글 <span id="numOfReply"></span> 개</h3>
		
						<ul id="replyList" class="list-group">
							<%-- 
							<c:forEach items="${replyList }" var="reply">
								<li class="list-group-item">
									<div id="replyDisplayContainer${reply.id }">
										<div class="d-flex fw-bold">
											<i class="fa-solid fa-comment"></i>
											<span class="mx-2">${reply.user_id}</span>
											<div class="ms-auto">
												<span class="reply-edit-toggle-button badge bg-info text-dark"
													id="replyEditToggleButton${reply.id }"
													data-reply-id="${reply.id }">
													<i class="fa-solid fa-pen-to-square"></i>
												</span>
												<span class="reply-delete-button badge bg-danger"
													data-reply-id="${reply.id }">
													<i class="fa-solid fa-trash-can"></i>
												</span>
											</div>
										</div>
										<div class="d-flex form-label">
											<span><c:out value="${reply.qna_rep_content }" /></span>
											<span class="ms-auto">${reply.changeTimeInserted }</span>
										</div>
		
		
									</div>
		
									<div id="replyEditFormContainer${reply.id }"
										style="display: none;">
										<form action="${appRoot }/reply/modify" method="post">
											<div class="input-group">
												<input type="hidden" name="boardId" value="${qna.id }" />
												<input type="hidden" name="id" value="${reply.id }" />
												<input class="form-control" value="${reply.qna_rep_content }"
													type="text" name="content" required />
												<button class="btn btn-outline-secondary">
													<i class="fa-solid fa-comment-dots"></i>
												</button>
											</div>
										</form>
									</div>
								</li>
							</c:forEach> 
							--%>
						</ul>
					</div>
				</div>
		
			</div>
		</div>
	</div>
</body>
</html>