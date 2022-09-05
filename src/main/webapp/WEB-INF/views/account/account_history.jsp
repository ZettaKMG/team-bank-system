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
	<bank:navBar current="account_history"/>
	
	<%-- 계좌 입출금 내역 화면 --%>
	<div class="container">
        <div class="row">
            <div class="col">
                <table class="table table-bordered caption-top align-middle">
                    <caption style="text-align: center;">계좌이력</caption>
                    <thead>
                        <tr class="text-center">
                            <th>번호</th>
                            <th>계좌번호</th>
                            <th>입출금구분</th>
                            <th>금액</th>
                            <th>입출금날짜</th>
                        </tr>
                    </thead>

                    <tbody>
						<c:forEach items="${account_history }" var="transfer">
							<tr class="text-center"> 
								
								<td>${transfer.trans_id}</td>
								<td>${transfer.trans_account_num}</td>
								<td>${transfer.trans_div }</td>
								<td>${transfer.trans_cost }원</td>
								<td>${transfer.trans_date }</td>
							</tr>
						</c:forEach>
					</tbody>

                </table>
            </div>
        </div>
    </div>
</body>
</html>