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
	<c:if test="${re != -1 }">
			회원가입성공! 잠시 후 메인홈으로 돌아갑니다.
		<script>
			setTimeout(function() {
				location.href = 'index.jsp';
			}, 2000); 
		</script>
	</c:if>
	<c:if test="${re == -1 }">
			회원가입실패! 잠시 후 메인홈으로 돌아갑니다.
		<script>
			setTimeout(function() {
				location.href = 'index.jsp';
			}, 2000); 
		</script>
	</c:if>
</body>
</html>