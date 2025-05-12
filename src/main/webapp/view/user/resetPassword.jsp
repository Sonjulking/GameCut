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
	
	<form action="resetPasswordOK.do" method="post">
		<label id="title">비밀번호 변경</label>
		
		<label for="userId">사용자 아이디</label>
		<input type="text" id="userId" name="userId">
		
		<label for="userName">사용자 이름</label>
		<input type="text" id="userName" name="userName">
		
		<label for="userEmail">사용자 이메일</label>
		<input type="text" id="userEmail" name="userEmail">
		
		<label for="newUserPassword">변경할 비밀번호</label>
		<input type="password" id="newUserPassword" name="newUserPassword">

		<label for="newUserPassword2">변경할 비밀번호 확인</label>
		<input type="password" id="newUserPassword2">
		
		<input type="button" id="btnOK" value="변경하기">
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