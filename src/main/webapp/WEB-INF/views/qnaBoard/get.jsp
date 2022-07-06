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
<script>
	$(document).ready(function() {
		// 문의 글 수정 버튼 클릭 시 readonly 제한 해제 및 수정 버튼 변경
		$("#qna-modify-button").click(function() {
			$("#qna-modify-button").addClass("d-none");
			$("#inputTitle").removeAttr("readonly");
			$("#inputText").removeAttr("readonly");
			$("#qna-modify-submit").removeClass("d-none");
		});
		
		// 문의 글 수정 완료 버튼 클릭 시 confirm창 최종 확인 후 수정
		$("#qna-modify-submit").click(function(e) {
			e.preventDefault();
			
			if(confirm("수정하시겠습니까?")) {
				let qnaForm = $("#qnaContentForm");
				let actionAttr = "${appRoot}/qnaBoard/modify";
				qnaForm.attr("action", actionAttr);
				qnaForm.submit();
			}
		});
		
		// 문의 글 삭제 버튼 클릭 시 confirm창 최종 확인 후 삭제
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
					$("#numOfReply").text(list.length);
					
					for (let i = 0; i < list.length; i++) {
						const replyElement = $("<li class='list-group-item' />");
						replyElement.html(`
							<div style="margin-left :\${list[i].qna_rep_dep * 10}px;" id="replyDisplayContainer\${list[i].id }">
								<div class="d-flex fw-bold">
									<span id="replyIcon\${list[i].id }"><i class="fa-solid fa-comment"></i></span>
									<span class="mx-2">\${list[i].user_id}</span>
									<div class="ms-auto" id="editButtonWrapper\${list[i].id }">
									</div>
								</div>
								<div class="d-flex form-label">
									<span id="replyContent\${list[i].id }"><c:out value="\${list[i].qna_rep_content }" /></span>
									<span class="ms-auto">\${list[i].changeTimeInserted }</span>
								</div>
							</div>
							
							<div id="replyEditFormContainer\${list[i].id }"	style="display: none;">
								<form action="${appRoot }/qnaReply/modify" method="post">
									<div class="input-group">
										<input type="hidden" name="qna_id" value="${qna.id }" />
										<input type="hidden" name="id" value="\${list[i].id }" />
										<input class="form-control" value="\${list[i].qna_rep_content }" type="text" name="qna_rep_content" required />
										<button data-reply-id="\${list[i].id}"  class="reply-modify-submit btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>
							
							<div class="row mt-3" id="reReplyFormDiv\${list[i].id }" style="display: none;">
								<form id="reReplyForm\${list[i].id }" action="${appRoot}/qnaReply/write" method="post">
									<div class="input-group">
										<input type="hidden" name="qna_id" value="${qna.id }" />
										<input type="hidden" name="qna_rep_dep" value="\${list[i].qna_rep_dep}"/>
										<input type="hidden" name="qna_rep_parent" value="\${list[i].id}" />
										<input id="addReplyContentInput" class="form-control" type="text" name="qna_rep_content" required />
										<button id="addReplySubmitButton" class="btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</div>
								</form>
							</div>
						`);
						replyListElement.append(replyElement);
						
						if (list[i].own) {
							// 로그인 한 사람의 댓글일 때 답글, 수정, 삭제 버튼 보여줌
							$("#editButtonWrapper" + list[i].id).html(`
								<span class="re-reply-toggle-button badge bg-success" id="reReplyBtn\${list[i].id }" data-reply-id="\${list[i].id }">
									<i class="fa-solid fa-reply"></i>
								</span>
								<span class="reply-edit-toggle-button badge bg-info text-dark" id="replyEditToggleButton\${list[i].id }" data-reply-id="\${list[i].id }">
									<i class="fa-solid fa-pen-to-square"></i>
								</span>
								<span class="reply-delete-button badge bg-danger" data-reply-id="\${list[i].id }">
									<i class="fa-solid fa-trash-can"></i>
								</span>
							`);
						} else if(${empty principal.username}) {
							// 비로그인일때 아무 버튼도 보이지 않음
							$("#editButtonWrapper" + list[i].id).html(``);
						} else {
							// 다른사람의 댓글일 때 답글 버튼만 보여줌
							$("#editButtonWrapper" + list[i].id).html(`
									<span class="re-reply-toggle-button badge bg-success" id="reReplyBtn\${list[i].id }" data-reply-id="\${list[i].id }">
										<i class="fa-solid fa-reply"></i>
									</span>
							`);
						}
						
						// 댓글이 대댓글일 때 아이콘 모양 변경
						if(list[i].qna_rep_parent != 0) {
							$("#replyIcon" + list[i].id).html(`
								<i class="bi bi-arrow-return-right"></i>
							`);
						}
						
					} // for문 마지막
					
					// 댓글 수정 버튼 클릭시 댓글 보여주는 div 숨기고, 수정 form 보여주기
					$(".reply-edit-toggle-button").click(function() {
						const replyId = $(this).attr("data-reply-id");
						const displayDivId = "#replyDisplayContainer" + replyId;
						const editFormId = "#replyEditFormContainer" + replyId;

						$(displayDivId).hide();
						$(editFormId).show();
					});
					
					// 답글 버튼 클릭 시 답글form 보여줌
					$(".re-reply-toggle-button").click(function() {
						const replyId = $(this).attr("data-reply-id");
						const reReplyFormDiv = "#reReplyFormDiv" + replyId;
						const reReplyForm = "#reReplyForm" + replyId;

						$(reReplyFormDiv).show();
					});
					
					// 댓글 수정완료 버튼 클릭 시 댓글 수정
					$(".reply-modify-submit").click(function(e) {
						e.preventDefault();
						
						const id = $(this).attr("data-reply-id");
						const formElem = $("#replyEditFormContainer" + id).find("form");
						const data = {
							qna_id : formElem.find("[name=qna_id]").val(),
							id : formElem.find("[name=id]").val(),
							qna_rep_content : formElem.find("[name=qna_rep_content]").val()
						};
						
						$.ajax({
							url : "${appRoot}/qnaReply/modify",
							type : "put",
							data : JSON.stringify(data),
							contentType : "application/json",
							success : function(data) {
								// 메세지 보여주기
								$("#replyMessage").show().text(data).fadeOut(3000);
								
								// 댓글목록 새로고침
								listReply();
							},
							error : function() {
								$("#replyMessage").show().text("댓글을 수정할 수 없습니다.").fadeOut(3000);
							},
							complete : function() {
							}
						});
					});
					
					// 댓글 삭제 버튼 클릭시 댓글 삭제
					$(".reply-delete-button").click(function() {
						const replyId = $(this).attr("data-reply-id");
						const message = "댓글을 삭제하시겠습니까?";

						if (confirm(message)) {
							$.ajax({
								url : "${appRoot}/qnaReply/delete/" + replyId,
								type : "delete",
								success : function(data) {
									// 댓글 list refresh
									listReply();
									// 메세지 출력
									$("#replyMessage").show().text(data).fadeOut(3000);
								},
								error : function() {
									$("#replyMessage").show().text("댓글을 삭제할 수 없습니다.").fadeOut(3000);
								},
								complete : function() {
								}
							});
						}
					});
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
					<c:if test="${not empty message }">
						<div class="alert alert-primary">${message }</div>
					</c:if>
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
							<sec:authorize access="hasAnyRole('ADMIN, PRODUCT, SERVICE')">
								<input type="button" class="btn btn-outline-primary" onclick="location.href='${appRoot }/qnaBoard/write?id=${qna.id }&dep=${qna.qna_dep }';" value="답글"/>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<input type="button" id="qna-modify-button" class="btn btn-primary" value="수정" />
								<button id="qna-modify-submit" class="btn btn-primary d-none" >수정 완료</button> 
								<button id="qna-remove-submit" class="btn btn-danger">삭제</button>
							</sec:authorize>
						</div>
					</form>
				</div>
				
				<%-- 댓글 추가 form --%>
				
				<c:choose>
					<c:when test="${not empty principal.username}">
						<div class="row mt-3">
							<form id="addReplyForm" action="${appRoot}/qnaReply/write" method="post">
								<div class="input-group">
									<input type="hidden" name="qna_id" value="${qna.id }" />
									<input id="addReplyContentInput" class="form-control" type="text" name="qna_rep_content" required />
									<sec:authorize access="isAuthenticated()">
										<button id="addReplySubmitButton" class="btn btn-outline-secondary">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
									</sec:authorize>
								</div>
							</form>
						</div>
					</c:when>
					<c:when test="${empty principal.username }">
						<div class="row mt-3">
							<div class="input-group">
								<input id="addReplyContentInput" class="form-control" type="text" name="qna_rep_content" readonly placeholder="로그인이 필요합니다."/>
								<button id="addReplySubmitButton" class="btn btn-outline-secondary" disabled>
									<i class="fa-solid fa-comment-dots"></i>
								</button>
							</div>
						</div>
					</c:when>
				</c:choose>
				
				<div class="row mt-3">
					<div class="alert alert-primary" style="display:none; " id="replyMessage"></div>
				</div>
				
				<div class="row mt-3">
					<div class="col">
						<h3>댓글 <span id="numOfReply"></span> 개</h3>
		
						<ul id="replyList" class="list-group"></ul>
					</div>
				</div>
		
			</div>
		</div>
	</div>
	
	<%-- 댓글 삭제 form --%>
	<div class="d-none">
		<form id="replyDeleteForm1" action="${appRoot }/qnaReply/delete" method="post">
			<input id="replyDeleteInput1" type="text" name="id" />
			<input type="text" name="qna_id" value="${qna.id }" />
		</form>
	</div>
</body>
</html>