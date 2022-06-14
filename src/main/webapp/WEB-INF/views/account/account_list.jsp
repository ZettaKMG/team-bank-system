<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "bank" tagdir="/WEB-INF/tags" %>
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
	<bank:navbar current="account_list"/>
    <div class="container">
        <div class="row">
            <div class="col">
                <table class="table table-bordered caption-top align-middle">
                    <caption style="text-align: center;">계좌리스트</caption>
                    <thead>
                        <tr class="text-center">
                            <th>계좌번호</th>
                            <th>유저번호</th>
                            <th>상품번호</th>
                            <th>비밀번호</th>
                            <th>잔고</th>
                            <th>계좌생성일</th>
                        </tr>

                    </thead>

                    <tbody>
						<c:forEach items="${account_list }" var="account">
							<tr class="text-center">
								<td>
									<c:url value="${account.account_num }" var="get_url" />
																		
									<a href="${get_url }">${account.account_num }</a>
								</td>
								<td>${account.account_user_id }</td>
								<td>${account.account_item_id }</td>
								<td>${account.account_pw }</td>
								<td>${account.account_balance }</td>
								<td>${account.account_date }</td>
							</tr>
						</c:forEach>
					</tbody>

                </table>
            </div>
        </div>
    </div>

</body>

</html>