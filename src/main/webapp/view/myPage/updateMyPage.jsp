<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div class="main_container">
    <div class="main_content">
		<h2 class="joinUserTitle">내 정보 수정</h2>
		<hr>
		<form action="updateMyPageOK.do" method="post" enctype="multipart/form-data">
			<c:if test="${empty file.originalFileName}">
				<img class="oldFile" src="img/common/empty.png" width="200" height="200" style="border-radius: 100%;"> <br>
			</c:if>
			<c:if test="${!empty file.originalFileName}">
				<img class="oldFile" src="${file.fileUrl }" width="200" height="200" style="border-radius: 100%;"> <br>
			</c:if>
			이름 : <input type="text" name="userName" id="userName" value="${user.userName }"> <br>
			아이디 : <input type="text" name="userId" id="userId" value="${user.userId }" disabled> <br>
			사용자닉네임 : <input type="text" name="userNickname" id="userNickname" value="${user.userNickname }"> <br>
			<button type = "button" id="checkNickname">중복확인</button><br>
			핸드폰번호 :  <input type="text" name="phone" id="phone" value="${user.phone }"><br>
			이메일 :  <input type="text" name="email" id="email" value="${user.email }"><br>
			프로필 : <input type="file" name="originalFileName" id="originalFileName"><br>
			<input type="hidden" name="oldFileName" value="${file.originalFileName }">
			<input type="hidden" name="userNo" id="userNo" value="${user.userNo }">
			<input type="button" id="deleteFile" value="프로필사진 삭제">
			<input type="submit" value="완료" id ="btnOK">
			<input type="reset" value="다시" id="btnReset">
		</form>
    </div>
<script type="text/javascript">
$(function() {
	$("#deleteFile").click(function() {
		$(".oldFile").attr("src", "img/common/empty.png");
		console.log("작동함");
	})
	$("#btnReset").click(function() {
		$(".oldFile").attr("src", "${file.fileUrl }");
	})
	
	let checkNickname = false;
	$("#checkNickname").click(function(){
	    let userNickname = $("#userNickname").val().trim();
	    let userNo = $("#userNo").val().trim();
	    if (userNickname === "") {
	        alert("닉네임을 입력해주세요.");
	        return;
	    }

	    $.get("nicknameCheck.do?userNickname="+userNickname+"&userNo="+userNo, (data)=>{
	        if(data.result == 1){
	            alert("이미 사용 중인 닉네임입니다.");
	        } else {
	            alert("사용 가능한 닉네임입니다.");
	            checkNickname = true;
	        }
	    });
	});
	
	$("#btnOK").click(function(e) {
	    if(!checkNickname && $("#userNickname").val() !== "${user.userNickname}") {
	        alert("닉네임 중복 확인을 해주세요.");
	        e.preventDefault();
	        return false;
	    }
	});
})
</script>
</div>
