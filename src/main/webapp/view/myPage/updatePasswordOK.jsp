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
			비밀번호 변경 성공!
		<script>
			alert("비밀번호변경성공!")
			location.href = 'myPage.do';
		</script>
	</c:if>
	<c:if test="${re == -1 }">
			비밀번호 변경 실패!
		<script>
			alert("비밀번호변경실패!")
			location.href = 'myPage.do';
		</script>
	</c:if>
</body>
</html>