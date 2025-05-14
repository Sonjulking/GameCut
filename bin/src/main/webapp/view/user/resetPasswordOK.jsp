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
	<c:if test="${re != 0 }">
			비밀번호 변경 성공!
		<script>
			alert("비밀번호 변경 완료!")
			location.href = 'login.do;
		</script>
	</c:if>
	<c:if test="${re == 0 }">
			비밀번호 변경 실패!
		<script>
			alert("비밀번호 변경 실패!")
			location.href = 'login.do';
		</script>
	</c:if>
</body>
</html>