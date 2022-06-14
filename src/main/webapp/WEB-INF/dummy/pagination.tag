<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags"%>
<%@ attribute name="current" %>

<div class="mt-3">
	<nav aria-label="page navigation example">
		<ul class="pagination justify-content-center">
	    <li class="page-item disabled">
	      <a class="page-link">이전</a>
	    </li>
	    <li class="page-item"><a class="page-link" href="#">1</a></li>
	    <li class="page-item active" aria-current="page">
	      <a class="page-link" href="#">2</a>
	    </li>
	    <li class="page-item"><a class="page-link" href="#">3</a></li>
	    <li class="page-item">
	      <a class="page-link" href="#">다음</a>
	    </li>
	  </ul>
	</nav>
</div>

<!-- 
<div class="mt-3">
	<nav aria-label="page navigation example">
		<ul class="pagination justify-content-center">
			<c:if test="${pageInfo.left > 1 }">
				<c:url value="${path }" var="link">
					<c:param name="page" value="${pageInfo.left - 1 }"></c:param>
				</c:url>		
				<li class="page-item">
					<a class="page-link" href="${link }">이전</a>
				</li>
			</c:if>
			
			<c:forEach begin="${pageInfo.left }" end="${pageInfo.right }" var="pageNum">
				<c:url value="${path }" var="link">
					<c:param name="page" value="${pageNum }"></c:param>
				</c:url>
					
				<li class="page-item ${pageInfo.current == pageNum ? 'active' : '' }">
					<a class="page-link" href="${link }">${pageNum }</a>
				</li>			
			</c:forEach>
			
			<c:if test="${pageInfo.right < pageInfo.end }">
				<c:url value="${path }" var="link">
					<c:param name="page" value="${pageInfo.right + 1 }"></c:param>
				</c:url>		
				<li class="page-item">
					<a class="page-link" href="${link }">다음</a>
				</li>
			</c:if>
		</ul>
	</nav>
</div>
 -->