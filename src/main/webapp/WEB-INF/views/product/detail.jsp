<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="bank" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"	referrerpolicy="no-referrer"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

<script>
	$(document).ready(function() {		
		/* 수정 모드 진입 여부 묻는 메세지 창 */
		$("#into_edit_mode_button").click(function(e) {
			e.preventDefault();
						
			if (confirm("상품 정보 수정/삭제모드로 진입하시겠습니까?")) { // 확인 누를시 진입
				let form1 = $("#form1");
				let actionAttr1 = "${appRoot}/product/edit";
				form1.attr("action", actionAttr1);
				
				form1.submit();
			} else { // 취소 누를시 현재 페이지에 그대로
									
			}
		});	
		
		/* 계좌개설 메뉴 이동 여부 묻는 메세지 창 */
		$("#open_an_account_button").click(function(e) {
			e.preventDefault();
			
			if (confirm("계좌개설 메뉴로 이동하시겠습니까?")) { // 확인 누를시 진입
				let form1 = $("#form1");
				let actionAttr2 = "${appRoot}/account/account_register";
				form1.attr("action", actionAttr2);
				
				form1.submit();
			} else { // 취소 누를시 현재 페이지에 그대로
				
			}
		});	
	});
	
	<!-- Modal 창 -->
	$(document).ready(function(){
		var result = '<c:out value="${message}"/>';
		
		check_modal(result);
		
		function check_modal(result) {
			if (result === '') {
				return ;
			}
			
			if (parseInt(result) > 0) {
				$(".modal-body").html("${message}");
			}
			
			$("#my_modal").modal("show");
		}
	});
	
	$(function() {
		
		// 상품평 list가져오는 메소드
		const list_rev = function(){
			// 리스트에 쓰이는 데이터 : 상품id
			const data = { product_rev_item_id : ${product.id} };	
			
			// 상품평, 상품평대댓글 list (ajax)
			$.ajax({
				url : "${appRoot}/product_review/list",
				type : "get",
				data : data,
				success : function(list) {
					
					const rev_list_element = $("#rev_list1");
					rev_list_element.empty();
					
					for(let i = 0; i < list.length; i++){
						const rev_element = $("<li class='list-group-item' />");
						
						// 대댓글 표시하는 icon : 미리 조건 설정 후 html에 그리게 만듬
						let reply_icon = "";
						if (list[i].product_rev_group_depth > 0) {
							reply_icon = `<i class="bi bi-arrow-return-right"></i>`;
						}
						
						rev_element.html(`
								<%-- 댓글 화면 구성 --%>
								<div style="margin-left :\${list[i].product_rev_group_depth * 30}px;" id="rev_display_container\${list[i].id }">
									<div class="fw-bold">
										\${reply_icon}					
										<i class="fa-solid fa-comment"></i> 
										\${list[i].product_rev_inserted}
										
										<sec:authorize access="isAuthenticated()">
										<span class="rev_reply_form badge bg-success" 
											  id="rev_reply_form\${list[i].id }" 
											  data-reply-id="\${list[i].id }">
											  <i class="fa-solid fa-reply"></i>
										</span>
										</sec:authorize>		
								<%-- 댓글 수정 삭제 버튼 : 권한이 있으면 html에 그리게함 --%>												
								 	<span id="modify_button_wrapper\${list[i].id }"></span>
									</div>
										<span class="badge bg-light text-dark">
										<i class="fa-solid fa-user"></i>
										\${list[i].product_rev_user_id}
										</span> 
								<%-- 댓글 내용 : css공격을 받을 수 있어서 내용을 나중에 삽입하는 방식으로 만듬--%>		
							 			<span id="rev_content\${list[i].id}"></span>
								</div>
								
								<%-- 대댓글 작성화면 --%>
								<div id="rev_reply_form_container\${list[i].id }"
									style="display: none;">
									<form action="${appRoot }/product_review/reply_insert" method="post">
										<div class="input-group">
											<input type="hidden" name="product_rev_item_id" value="${product.id }" />
											<input type="hidden" name="id" value="\${list[i].id }" />
											<input class="form-control" type="text" name="product_rev_content" required />
											<button data-reply-id="\${list[i].id}" 
													class="rev_reply_insert_submit btn btn-outline-secondary">
												<i class="fa-solid fa-comment-dots"></i>
											</button>
										</div>
									</form>
								</div>
								
								<%-- 댓글 수정화면--%>
								<div id="rev_edit_form_container\${list[i].id }"
									style="display: none;">
									<form action="${appRoot }/product_review/modify" method="post">
										<div class="input-group">
											<input type="hidden" name="product_rev_item_id" value="${product.id }" />
											<input type="hidden" name="id" value="\${list[i].id }" />
											<input class="form-control" value="\${list[i].product_rev_content }"
												type="text" name="product_rev_content" required />
											<button data-reply-id="\${list[i].id}" 
													class="rev_modify_submit btn btn-outline-secondary">
												<i class="fa-solid fa-comment-dots"></i>
											</button>
										</div>
									</form>
								</div>
							`);
						rev_list_element.append(rev_element);					
						
						// 댓글내용 삽입
						$("#rev_content"+ list[i].id).text(list[i].product_rev_content);
						
						// own(사용자 일치여부)가 true일때만, 수정 삭제 버튼 보임
						if (list[i].own) {
							$("#modify_button_wrapper" + list[i].id).html(`
								<span class="rev_edit_toggle_button badge bg-info text-dark"
									id="rev_edit_toggle_button\${list[i].id }"
									data-reply-id="\${list[i].id }">
									<i class="fa-solid fa-pen-to-square"></i>
								</span>
								<span class="rev_delete_button badge bg-danger"
									data-reply-id="\${list[i].id }">
									<i class="fa-solid fa-trash-can"></i>
								</span>
							`);
						}
				
					} // end of for
					
					//상품평수정글쓰기버튼 클릭시 
					$(".rev_modify_submit").click(function(e) {
						e.preventDefault();
						
						// 넘겨줄 data가공
						const id = $(this).attr("data-reply-id");
						const formElem = $("#rev_edit_form_container" + id).find("form");
						const data = {
							product_rev_item_id : formElem.find("[name=product_rev_item_id]").val(),
							id : formElem.find("[name=id]").val(),
							product_rev_content : formElem.find("[name=product_rev_content]").val()
						};
						
						$.ajax({
							url : "${appRoot }/product_review/modify",
							type : "put",
							data : JSON.stringify(data),
							contentType : "application/json",
							success : function(data) {
								console.log("수정 성공");
														
							},
							error : function() {
								
								console.log("수정 실패");
							},
							complete : function() {
								// 댓글 refresh
								list_rev();
								console.log("수정 종료");
							}
						});
					});
					
					//상품평대댓글쓰기버튼 클릭시
					$(".rev_reply_insert_submit").click(function(e) {
						e.preventDefault();
						
						const id = $(this).attr("data-reply-id");
						const formElem = $("#rev_reply_form_container" + id).find("form");
						const data = formElem.serialize();
										
						$.ajax({
								url : "${appRoot}/product_review/reply_insert",
								type : "post",
								data : data,
								
								success : function(data) {
									// text input 초기화
									formElem.find("[name=product_rev_content]").val("");
									$("#insert_rev_container").removeClass("d-none");
									// 모든 댓글 가져오는 ajax요청
									list_rev();
								},

								error : function() {
									console.log("문제 발생");
								},
					
								complete : function() {
									console.log("요청 완료");
								}
						});
					});
					
					//상품평, 상품평대댓글 수정버튼 클릭시
					$(".rev_edit_toggle_button").click(function() {
						
						const rev_id = $(this).attr("data-reply-id");
						const display_div_id = "#rev_display_container" + rev_id;
						const edit_form_id = "#rev_edit_form_container" + rev_id;
						const rev_reply_form_id = "#rev_reply_form_container" + rev_id;
												
						$(display_div_id).hide();
						$(edit_form_id).show();
						$(rev_reply_form_id).hide();
					});	
					
					//상품평대댓글버튼 클릭시
					$(".rev_reply_form").click(function() {
						
						const rev_id = $(this).attr("data-reply-id");
						const edit_form_id = "#rev_edit_form_container" + rev_id;
						const rev_reply_form_id = "#rev_reply_form_container" + rev_id;
												
						$(edit_form_id).hide();
						$("#insert_rev_container").addClass("d-none");
						$(rev_reply_form_id).show();
					});
					
					//상품평, 상품평대댓글 삭제버튼 클릭시
					$(".rev_delete_button").click(function() {
						const rev_id = $(this).attr("data-reply-id");
						const message = "댓글을 삭제하시겠습니까?";
						
						if (confirm(message)) {
														
							$.ajax({
								url : "${appRoot}/product_review/delete/" + rev_id,
								type : "delete",
								success : function(data){
										// 댓글 list refresh
										list_rev();
								},
									
								error : function(){
									console.log(rev_id + "댓글 삭제 중 문제 발생");
									
								},
								complete : function(){
									console.log(rev_id + "댓글 삭제 끝");
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
		
		list_rev();
		
		// 상품평글쓰기버튼 클릭시
		$("#add_rev_submit1").click(function(e) {
			e.preventDefault();
			
			const data = $("#insert_rev_form1").serialize();
				
			$.ajax({
				url : "${appRoot}/product_review/insert",
				type : "post",
				data : data,
				success : function(data) {
					// text input 초기화
					$("#insert_rev_content_input1").val("");
					// 모든 댓글 가져오는 ajax요청
					list_rev();
				},

				error : function() {
					console.log("문제 발생");
				},
	
				complete : function() {
					console.log("요청 완료");
				}
		
			});
		});	 
	});
</script>
	
<title>상품 상세정보 페이지</title>
</head>
<body>

	<bank:navBar></bank:navBar>
	
	<!-- 상품 수정 여부 표시 modal -->
	<c:if test="${not empty message }">
		<div class="modal" id="my_modal" tabindex="-1" role="dialog" area-labelledby="my_modal_lable" aria-hidden="true">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="my_modal_lable">상품 수정 여부</h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" aria-hidden="true"></button>
		      </div>
		      <div class="modal-body">
		        <p>${message }</p>
		      </div> 
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">확인</button>		        
		      </div>
		    </div>
		  </div>
		</div>		
	</c:if>	
			
	<form id="form1" action="" method="get">	
	<div class="container">				 
		<input type="hidden" name="id" value="${product.id }" />
				
		<div class="mt-5 mb-3">
			<div class="input-group">
			  <span class="input-group-text"><strong>상품명</strong></span>
			  <textarea class="form-control" name="item_name" id="item_name" rows="1" required readonly>${product.item_name }</textarea>
			</div>	
		</div>
		<div class="mt-1 mb-3">
			<div class="input-group">
			  <span class="input-group-text"><strong>상품요약</strong></span>
			  <textarea class="form-control" name="summary" id="summary" rows="2" required readonly>${product.summary }</textarea>
			</div>
		</div>
	    <div class="mt-3">
		    <div class="row justify-content-md-center">
			    <div class="col col-lg-2">
			      <div class="input-group mb-3">
					  <span class="input-group-text" id="sav_method"><strong>상품종류</strong>
					  <input type="text" class="form-control" name="sav_method" value="${product.sav_method }" aria-label="Username" aria-describedby="sav_method" required readonly />
					  </span>							  
					</div>
			    </div>
			    <div class="col col-lg-2">
			      <c:if test="${product.exp_period != 0 }">						
					<div class="input-group mb-3">
					  <span class="input-group-text" id="exp_period"><strong>가입기간</strong>
					  <input type="text" class="form-control" name="exp_period" value="${product.exp_period }" aria-label="Username" aria-describedby="exp_period" readonly /> 개월								  
					  </span>
					</div>					
				  </c:if>
			    </div>
			    <div class="col col-lg-2">
			      <div class="input-group mb-3">
					  <span class="input-group-text" id="rate"><strong>연 이율</strong>
					  	<input type="text" class="form-control" name="rate" value="${product.rate * 100}" aria-label="Username" aria-describedby="rate" required readonly /> %
					  </span>
				  </div>	
			    </div>
		  	</div>
		</div>						
	   
		<div class="mt-1 mb-3">
			<div class="input-group">
			  <span class="input-group-text"><strong>상품 상세내용</strong></span>
			  <textarea class="form-control" name="detail" id="detail" rows="5" readonly>${product.detail }</textarea>
			</div>		    
		</div>			
	 </div>
		
		<div class="mt-1 d-md-flex justify-content-md-center gap-2" role="group" aria-label="Basic mixed styles example">
		  <button type="button" id="return_search1" onclick="location.href='${appRoot}/product/search'" class="btn btn-primary">상품목록</button>			  			  
	
		  <sec:authorize access="hasAnyRole('ADMIN, PRODUCT')">
		  	<button type="button" id="into_edit_mode_button" class="btn btn-warning">상품정보 수정/삭제모드</button>
		  </sec:authorize>	
		
		  <sec:authorize access="isAuthenticated()">
		  	<button type="button" id="open_an_account_button" class="btn btn-info">계좌개설하기</button>
		  </sec:authorize>		
		</div>	
	
	</form>    
	
	<%-- 댓글 목록 화면 --%>
	<div class="container mt-3">
		<div class="row">
			<div class="col">
				<h5>상품평</h5>			
				<ul id="rev_list1" class="list-group">
				
				</ul>
			</div>
		</div>
	</div>
	
	<%-- 댓글 추가 화면 --%>
	<sec:authorize access="isAuthenticated()">
	<div id="insert_rev_container" class="container mt-3">
		<div class="row">
			<div class="col">
				<form id="insert_rev_form1" method="post">
					<div class="input-group">
						<input type="hidden" name="product_rev_item_id" value="${product.id }" />
						<input id="insert_rev_content_input1" class="form-control" type="text" name="product_rev_content" required /> 
						<button id="add_rev_submit1" class="btn btn-outline-secondary">
							<i class="fa-solid fa-comment-dots"></i>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	</sec:authorize>
	
</body>
</html>