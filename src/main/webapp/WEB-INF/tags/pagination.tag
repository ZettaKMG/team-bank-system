<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="current"%>

<%-- page 넘기기 --%>
<div class="mt-3">
	<nav aria-label="page navigation example">
		<ul class="pagination pagination-sm justify-content-center">
			<c:if test="${page_info.left > 1 }">
				<c:url value="${current }" var="link">
					<c:param name="page" value="${page_info.left - 1 }"></c:param>
				</c:url>
				<li class="page-item">
					<a class="page-link" href="${link }">이전</a>
				</li>
			</c:if>
	
			<c:forEach begin="${page_info.left }" end="${page_info.right }" var="page_num">
				<c:url value="${current }" var="link">
					<c:param name="page" value="${page_num }"></c:param>
				</c:url>
	
				<li class="page-item ${page_info.current == page_num ? 'active' : '' }">
					<a class="page-link" href="${link }">${page_num }</a>
				</li>
			</c:forEach>
	
			<c:if test="${page_info.right < page_info.end }">
				<c:url value="${current }" var="link">
					<c:param name="page" value="${page_info.right + 1 }"></c:param>
				</c:url>
				<li class="page-item">
					<a class="page-link" href="${link }">다음</a>
				</li>
			</c:if>
		</ul>
	</nav>
</div>