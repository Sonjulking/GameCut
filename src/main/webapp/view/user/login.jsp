<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<h2>로그인</h2>
<hr>
<form action="loginOK.do">
	아이디 : <input type="text" name="userId"><br>
	비밀번호 : <input type="password" name="userPwd"><br>
	<input type="submit" value="확인">
	<input type="reset" value="다시">
	<input type="button" value="회원가입" id ="joinBtn">
</form>
<script type="text/javascript">
	$(function(){
		$("#joinBtn").click(function(){
			location.href = "joinUser.do";
		});
	})
</script>