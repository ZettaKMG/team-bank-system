<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
        crossorigin="anonymous"></script>

<title>Insert title here</title>
</head>
<body>

	<div class="container">
		<div class="row justify-content-center">
			<div class="border border-info col-12 col-lg-6">

				<label for="Input1" class="form-label">보내는사람</label>
				<div class="input-group mb-3">
					<input id="Input1" class="form-control" type="text" />
				</div>

				<!-- ajax처리 -->
				<div class="d-none">
					<label for="Input2" class="form-label">잔고</label>
					<div class="input-group mb-3">
						<input id="Input2" class="form-control" type="text" disabled />
					</div>
				</div>

				<label for="Input3" class="form-label">계좌번호</label>
				<div class="input-group mb-3">
					<input id="Input3" class="form-control" type="text" />
					<button class="btn btn-secondary" type="button">계좌확인</button>
				</div>

				<label for="Input4" class="form-label">받는사람</label>
				<div class="input-group mb-3">
					<input id="Input4" class="form-control" type="text" />
				</div>

				<label for="Input5" class="form-label">계좌번호</label>
				<div class="input-group mb-3">
					<input id="Input5" class="form-control" type="text" />
					<button class="btn btn-secondary" type="button">계좌확인</button>
				</div>

				<button class="mt-3 btn btn-primary" data-bs-toggle="modal" data-bs-target="#Modal1">계좌이체</button>

			</div>
		</div>
	</div>

	<div class="modal fade" id="Modal1" tabindex="-1" aria-labelledby="ModalLabel1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel1">비밀번호</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>비밀번호를 입력하세요</p>
					<input type="password" name="" id="">
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#Modal2">확인</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>

				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="Modal2" tabindex="-1" aria-labelledby="ModalLabel2" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="ModalLabel2">계좌이체</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>비밀번호 일치여부</p>
					<p>계좌이체를 진행하시겠습니까?</p>	 
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">진행</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>

				</div>
			</div>
		</div>
	</div>



</body>

</html>