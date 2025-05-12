<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	body {
		background-color: #121212;
		color: #ffffff;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		margin: 0;
		padding: 20px;
	}


	#title{
		display: flex;
		justify-content : center;
		margin-top: 15px;
		margin-bottom: 5px;
		color: #cccccc;
		font-size: 20px;
	}

	.password-form-container label {
		display: block;
		margin-top: 15px;
		margin-bottom: 5px;
		color: #cccccc;
		font-size: 14px;
	}

	.password-form-container input[type="text"],
	.password-form-container input[type="password"] {
		width: 100%;
		padding: 10px;
		border: none;
		border-radius: 5px;
		background-color: #2c2c2c;
		color: #ffffff;
		box-sizing: border-box;
	}

	.password-form-container input[type="button"] {
		margin-top: 20px;
		width: 100%;
		padding: 10px;
		background-color: #007bff;
		color: #ffffff;
		border: none;
		border-radius: 5px;
		cursor: pointer;
		transition: background-color 0.3s ease;
	}

	.password-form-container input[type="button"]:hover {
		background-color: #0056b3;
	}
</style>

<div class="password-form-container">
	
	<form action="updatePasswordOK.do" method="post">
		<label id="title">비밀번호 변경</label>
		
		<label for="userPassword">현재 비밀번호</label>
		<input type="password" id="userPassword" name="userPassword">

		<label for="newUserPassword">새로운 비밀번호</label>
		<input type="password" id="newUserPassword" name="newUserPassword">

		<label for="newUserPassword2">새로운 비밀번호 확인</label>
		<input type="password" id="newUserPassword2">

		<input type="hidden" id="userID" name="userID" value="${loginUSER.userId}">

		<input type="button" id="btnOK" value="변경하기">
	</form>
</div>

<script type="text/javascript">
	$(function(){
		$("#btnOK").click(function(){
			let formUserPw = $("#userPassword").val().trim();
			let newPw = $("#newUserPassword").val().trim();
			let newPw2 = $("#newUserPassword2").val().trim();
			let userID = "${loginUSER.userId}";
			let userPW = "${loginUSER.userPwd}";
			
			if (formUserPw === "") {
				alert("아이디와 기존 비밀번호를 입력해주세요.");
				return;
			}
			
			if (formUserPw !== userPW){
				alert("기존 비밀번호가 다릅니다.");
				return;
			}

			if (newPw === "" || newPw2 === "") {
				alert("새 비밀번호를 입력해주세요.");
				return;
			}

			if (newPw !== newPw2) {
				alert("새 비밀번호가 서로 다릅니다.");
				return;
			}

			$("form").submit(); // 최종 제출
		});
	});
</script>