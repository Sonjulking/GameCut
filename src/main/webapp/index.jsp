<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ include file="layout/header.jsp"%>

<div class="main_container">
    <div class="sidebar">
        <%@ include file="layout/sidebar.jsp"%>
    </div>
    <div class="main_content">
        <c:if test="${viewPage == null}">
            <a href="test.do">게시판 목록</a>
        </c:if>
        <c:if test="${viewPage != null}">
            <jsp:include page="${viewPage}"/>
        </c:if>
    </div>
</div>
<%@ include file="layout/footer.jsp"%>
