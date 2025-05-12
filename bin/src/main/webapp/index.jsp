<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ include file="/view/layout/header.jsp"%>
<div class="main_container">
    <div class="sidebar">
        <%@ include file="/view/layout/sidebar.jsp"%>
    </div>
    <div class="main_content">
        <c:if test="${viewPage == null}">
            <jsp:include page="view/main/main.jsp"/>
        </c:if>
        <c:if test="${viewPage != null}">
            <jsp:include page="${viewPage}"/>
        </c:if>
    </div>
</div>
<%@ include file="view/layout/footer.jsp"%>
