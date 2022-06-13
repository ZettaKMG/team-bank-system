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

				<form action="${appRoot }/account/account_register" method="post">
					<label for="input1" class="form-label">계좌번호</label>
					<div class="input-group mb-3">
						<input id="input1" class="form-control" type="text" name="account_num" />
						<button class="btn btn-secondary" type="button">계좌번호 중복 확인</button>
					</div>

					<label for="password_input1" class="form-label">패스워드</label>
					<input class="form-control" id="passwordInput1" type="text"
						name="account_pw" />

					<label for="password_input2" class="form-label">패스워드 확인</label>
					<input class="form-control" id="passwordInput2" type="text"
						name="account_pw_confirm" />

					<label for="input2" class="form-label">유저번호</label>
					<div class="input-group mb-3">
						<input id="input2" class="form-control" type="text" name="account_user_id"/>
					</div>

					<!-- <label for="input3" class="form-label">계좌주</label>
					<div class="input-group mb-3">
						<input id="input3" class="form-control" type="text" />
					</div>
 -->
					<label for="input4" class="form-label">상품명</label>
					<div class="input-group mb-3">
						<input id="input4" class="form-control" type="text" name="account_item_id"/>
					</div>

					<button class="mt-3 btn btn-primary" type="submit">계좌등록</button>
				</form>
			</div>
		</div>
	</div>
   
</body>
</html>