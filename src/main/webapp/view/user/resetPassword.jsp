<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	/* 기존 스타일 유지 */
	body {
		background-color: #121212;
		color: #ffffff;
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		margin: 0;
		padding: 20px;
	}

	#title {
		display: flex;
		justify-content: center;
		margin-top: 15px;
		margin-bottom: 15px;
		color: #cccccc;
		font-size: 18px;
	}

	.password-form-container {
		display: flex;
		justify-content: center;
	}

	form {
		width: 400px;
	}

	.form-row {
		display: flex;
		align-items: center;
		margin-bottom: 15px;
	}

	.form-row label {
		width: 120px;
		color: #cccccc;
		font-size: 14px;
	}

	.form-row input[type="text"],
	.form-row input[type="password"] {
		flex: 1;
		padding: 10px;
		border: none;
		border-radius: 5px;
		background-color: #2c2c2c;
		color: #ffffff;
		box-sizing: border-box;
	}

	input[type="button"] {
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

	input[type="button"]:hover {
		background-color: #0056b3;
	}
</style>

<div class="password-form-container">
	<form action="resetPasswordOK.do" method="post">
		<label id="title">비밀번호 변경</label>

		<div class="form-row">
			<label for="userId">사용자 아이디</label>
			<input type="text" id="userId" name="userId">
		</div>

		<div class="form-row">
			<label for="userName">사용자 이름</label>
			<input type="text" id="userName" name="userName">
		</div>

		<div class="form-row">
			<label for="userEmail">사용자 이메일</label>
			<input type="text" id="userEmail" name="userEmail">
		</div>

		<div class="form-row">
			<label for="newUserPassword">변경할 비밀번호</label>
			<input type="password" id="newUserPassword" name="newUserPassword">
		</div>

		<div class="form-row">
			<label for="newUserPassword2">비밀번호 확인</label>
			<input type="password" id="newUserPassword2">
		</div>

		<div>
			<input type="button" id="btnOK" value="변경하기">
		</div>
	</form>
</div>

<script type="text/javascript">
	$(function(){
		let limitOk = false;
		$("#btnOK").click(function(){
			let userID = $("#userId").val().trim();
			let userName = $("#userName").val().trim();
			let userEmail = $("#userEmail").val().trim();
			let newPw = $("#newUserPassword").val().trim();
			let newPw2 = $("#newUserPassword2").val().trim();
			
			
			if(userID === "" || userName === "" || userEmail === "" || newPw === "" || newPw2 === ""){
				alert("빈칸없이 전부 입력해주세요.");
				return;
			}
			if (newPw !== newPw2) {
				alert("새 비밀번호가 서로 다릅니다.");
				return;
			}
			
			 $.get("userInfoCheck.do?userId=" + userID + "&userName=" + userName + "&userEmail=" + userEmail, (data) => {
				
	                if (data.result != 1) {
	                    alert("사용자 정보가 일치하지않습니다.");
	                    return;
	                } else{
	                	if(limitOk == false){
	                		limitOk = true;
	                		$("form").submit(); // 최종 제출
	                	}
	                	
	                }
	          });
		});
	});
</script>