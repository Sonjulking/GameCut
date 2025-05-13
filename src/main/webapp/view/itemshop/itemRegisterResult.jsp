<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    Boolean success = (Boolean) request.getAttribute("success");
%>
<script>
<% if (success != null && success) { %>
    alert("상품이 성공적으로 등록되었습니다.");
    window.opener.location.reload();
    window.close();
<% } else { %>
    alert("상품 등록에 실패했습니다.");
    window.close();
<% } %>
</script>