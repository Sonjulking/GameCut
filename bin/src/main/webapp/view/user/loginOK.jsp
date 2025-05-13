<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${re == -1 }">
		로그인실패! 아이디가 없습니다.
		<script>
			setTimeout(function() {
				location.href = "login.do";
			}, 1500); 
		</script>
</c:if>
<c:if test="${re == 0 }">
		로그인실패! 비밀번호를 확인해주세요!
		<script>
			alert("로그인실패! 비밀번호 불일치");
			location.href = 'login.do';
		</script>
</c:if>
<c:if test="${re == 1 }">
		로그인성공! 잠시후 메인홈으로 이동합니다.
		<script>
		alert("${loginUSER.userName}님 로그인성공!");
		location.href = 'index.jsp';
		</script>
</c:if>
<c:if test="${re == 2 }">
		로그인실패! 이미탈퇴한 유저입니다.
		<script>
		alert("이미 탈퇴한 유저입니다.");
		location.href = 'index.jsp';
		</script>
</c:if>
	
      