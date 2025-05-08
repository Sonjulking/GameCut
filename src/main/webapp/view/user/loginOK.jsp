<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${re == -1 }">
		로그인실패! 아이디가 없습니다.
		<script>
			setTimeout(function() {
				location.href = 'index.jsp';
			}, 1000); 
		</script>
	</c:if>
	<c:if test="${re == 0 }">
		로그인실패! 비밀번호를 확인해주세요!
		<script>
			setTimeout(function() {
				location.href = 'index.jsp';
			}, 1000); 
		</script>
	</c:if>
	<c:if test="${re == 1 }">
		로그인성공! 잠시후 메인홈으로 이동합니다.
		<script>
			setTimeout(function() {
				location.href = 'index.jsp';
			}, 1000); 
		</script>
	</c:if>
</body>
</html>