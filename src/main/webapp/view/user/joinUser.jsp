<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="joinUserView">
	<h2 class="joinUserTitle">회원가입</h2>
	<hr>
	<form action="joinUserOK.do" method="post" enctype="multipart/form-data">
		아이디 : <input type ="text" name = "userId" id = "userId">
		<button type = "button" id="checkID">중복확인</button><br>
		비밀번호 : <input type="password" name ="userPwd" id="userPwd"><br>
		비밀번호 확인 : <input type="password" name="userPwd2" id="userPwd2"><br>
		사용자이름 : <input type="text" name ="userName"><br>
		사용자닉네임 : <input type="text" name ="userNickname" id="userNickname"><br>
		<button type = "button" id="checkNickname">중복확인</button><br>
		핸드폰번호 : <input type="text" name ="phone"><br>
		이메일 : <input type="text" name="email"><br>
		프로필사진 : <input type="file" name="profile"><br> 
		<input type="button" value="등록" id ="btnOK">
		<input type="reset" value="다시" id="btnReset">
	</form>
</div>
<script>
$(function(){
	
	let checkIdOK = false;
	let checkNickname = false;
	
	$("#checkID").click(function(){
		let id = $("#userId").val().trim();
		if (id === "") {
			alert("아이디를 입력해주세요.");
			return;
		}
		
		$.get("idCheck.do?id="+id,(data)=>{
			if(data.result == 1){
				alert("이미 사용 중인 아이디 입니다.");
				
			}else{
				alert("사용 가능한 아이디 입니다.");
				checkIdOK = true;
			}
		});
	});
	
	
	$("#checkNickname").click(function(){
		let userNickname = $("#userNickname").val().trim();
		if (userNickname === "") {
			alert("아이디를 입력해주세요.");
			return;
		}
		
		$.get("nickNameCheck.do?nickName="+userNickname,(data)=>{
			if(data.result == 1){
				alert("이미 사용 중인 닉네임 입니다.");
				
			}else{
				alert("사용 가능한 닉네임 입니다.");
				checkNickname = true;
			}
		});
		
	});
	
	
	$("#btnOK").click(function(){

		let pw1 = $("#userPwd").val();
		let pw2 = $("#userPwd2").val();
		if(checkIdOK == true && checkNickname == true){
			if(!(pw1 === pw2) || pw1 === ""){
				//비밀번호가 다름
				alert("비밀번호를 다시 확인해주세요.");
			}else{
				//회원가입성공
				$("form").submit();
			}
		}else{
			//아이디 중복을 확인해주세요.
			alert("아이디와 닉네임 중복 확인해주세요.");
		}
	});
});
	

</script>