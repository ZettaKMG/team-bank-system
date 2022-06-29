<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="current" %>

<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">
		<li class="page-item">
			<c:url value="${current }" var="prev_link">
				<c:if test="${not empty keyword }">
					<c:param name="keyword" value="${keyword }"></c:param>
					<c:param name="sav_method" value="${sav_method }"></c:param>
					<c:param name="exp_period" value="${exp_period }"></c:param>
					<c:param name="rate" value="${rate }"></c:param>
				</c:if>
				<c:param name="page" value="${product_page_info.current_page - 1 }"></c:param>
			</c:url>
			<c:if test="${(product_page_info.current_page - 1) > 0}">
				<a class="page-link" href="${prev_link }" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span> 
				</a>
			</c:if>
		</li>
		<c:forEach begin="${product_page_info.left }" end="${product_page_info.right }" var="page_num">
			<c:url value="${current }" var="present_link">
				<c:if test="${not empty keyword }">
					<c:param name="keyword" value="${keyword }"></c:param>
					<c:param name="sav_method" value="${sav_method }"></c:param>
					<c:param name="exp_period" value="${exp_period }"></c:param>
					<c:param name="rate" value="${rate }"></c:param>
				</c:if>
				<c:param name="page" value="${page_num }"></c:param>
			</c:url>
			<li class="page-item ${product_page_info.current_page == page_num ? 'active' : '' }">
				<a class="page-link" href="${present_link }">${page_num }</a>
			</li>
		</c:forEach>

		<c:url value="${current }" var="next_link">
			<c:if test="${not empty keyword }">
				<c:param name="keyword" value="${keyword }"></c:param>
				<c:param name="sav_method" value="${sav_method }"></c:param>
				<c:param name="exp_period" value="${exp_period }"></c:param>
				<c:param name="rate" value="${rate }"></c:param>
			</c:if>
			<c:param name="page" value="${product_page_info.current_page + 1 }"></c:param>
		</c:url>
		<li class="page-item">
			<c:if test="${(product_page_info.current_page + 1) <= product_page_info.end_page }">
			<a class="page-link" href="${next_link }" aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
			</c:if>
		</li>
	</ul>
</nav>