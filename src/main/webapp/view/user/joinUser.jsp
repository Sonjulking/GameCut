<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="joinUserView">
	<h2 class="joinUserTitle">회원가입</h2>
	<hr>
	<form action="joinUserOK.do" method="post" enctype="multipart/form-data">
		아이디 : <input type ="text" name = "userId">
		<button type = "button" id="checkID">중복확인</button><br>
		비밀번호 : <input type="password" name ="userPwd"><br>
		비밀번호 확인 : <input type="password" name="userPwd2"><br>
		사용자이름 : <input type="text" name ="userName"><br>
		사용자닉네임 : <input type="text" name ="userNickname"><br>
		핸드폰번호 : <input type="text" name ="phone"><br>
		이메일 : <input type="text" name="email"><br>
		프로필사진 : <input type="file" name="profile"><br> 
		<input type="submit" value="등록" id ="btnOK">
		<input type="reset" value="다시" id="btnReset">
	</form>
</div>
<script>
	document.getElementById("checkID").addEventListener("click", function() {
		alert("중복 확인을 실행합니다.");
	});
</script>