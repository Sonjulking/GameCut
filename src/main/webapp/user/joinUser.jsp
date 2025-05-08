<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="joinBody">
<h2>회원가입</h2>
<hr>
<form action="joinUserOK.do" method="post" enctype="multipart/form-data">
	아이디 : <input type ="text" name = "user_id"><button id="checkID">중복확인</button><br>
	비밀번호 : <input type="password" name ="pwd"><br>
	비밀번호 확인 : <input type="password" name="pwd2"><br>
	사용자이름 : <input type="text" name ="user_name"><br>
	사용자닉네임 : <input type="text" name ="user_nickname"><br>
	핸드폰번호 : <input type="text" name ="phone"><br>
	이메일 : <input type="text" name="email"><br>
	프로필 : <input type="file" name="profile"><br> 
	<input type="submit" value="등록" id ="btnOK">
	<input type="reset" value="다시" id="btnReset">
</form>
</body>
</html>