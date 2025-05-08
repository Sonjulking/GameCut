<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ include file="/view/layout/header.jsp"%>
<div class="main_container">
    <div class="main_content">
		<h2 class="joinUserTitle">회원가입</h2>
		<hr>
		<form action="" method="post" enctype="multipart/form-data">
		
		   사용자닉네임 : <input type="text" name ="userNickname" value="${user.userNickname }"><br>
		   핸드폰번호 : <input type="text" name ="phone" value="${user.phone }"><br>
		   이메일 : <input type="text" name="email" value="${user.email }"><br>
		   프로필 : <input type="file" name="profile" value="${file.originalFileName }"><br>
		   <input type="submit" value="등록" id ="btnOK">
		   <input type="reset" value="다시" id="btnReset">
		</form>
    </div>
</div>
