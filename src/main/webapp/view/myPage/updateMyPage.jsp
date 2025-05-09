<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" ></script>
<div class="main_container">
    <div class="main_content">
		<h2 class="joinUserTitle">내 정보 수정</h2>
		<hr>
		<form action="updateMyPageOK.do" method="post" enctype="multipart/form-data">
			<c:if test="${empty file.originalFileName}">
			<img class="oldFile" id="previewImage" src="img/common/empty.png" width="200" height="200" style="border-radius: 100%;"> <br>
			</c:if>
			<c:if test="${!empty file.originalFileName}">
			<img class="oldFile" id="previewImage" src="${file.fileUrl}" width="200" height="200" style="border-radius: 100%;"> <br>
			</c:if>
			이름 : <input type="text" name="userName" id="userName" value="${user.userName }"> <br>
			아이디 : <input type="text" name="userId" id="userId" value="${user.userId }" disabled> <br>
			사용자닉네임 : <input type="text" name="userNickname" id="userNickname" value="${user.userNickname }"> <br>
			<button type = "button" id="checkNickname">중복확인</button><br>
			핸드폰번호 :  <input type="text" name="phone" id="phone" value="${user.phone }"><br>
			이메일 :  <input type="text" name="email" id="email" value="${user.email }"><br>
			프로필 : <input type="file" name="originalFileName" id="originalFileName"><br>
			<input type="hidden" name="oldFileName" value="${file.originalFileName }">
			<input type="hidden" name="isProfileDeleted" id="isProfileDeleted" value="false">
			<input type="hidden" name="userNo" id="userNo" value="${user.userNo }">
			<input type="hidden" name="oldfileUrl" value="${file.fileUrl }">
			<input type="button" id="deleteFile" value="프로필사진 삭제">
			<input type="submit" value="완료" id ="btnOK">
			<input type="reset" value="다시" id="btnReset">
		</form>
    </div>
<script type="text/javascript">
$(function() {
	var isProfileDeleted = false;
	// 프로필사진 삭제 이벤트
	$("#deleteFile").click(function() {
		$(".oldFile").attr("src", "img/common/empty.png");
	    $("#isProfileDeleted").val("true"); // 삭제 상태를 true로 설정
	    $("#originalFileName").val("");
	    isProfileDeleted = true;
	    console.log("프로필 삭제 상태: " + isProfileDeleted);
	});
	
	$("#btnReset").click(function() {
		$(".oldFile").attr("src", "${file.fileUrl }");
		 $("#isProfileDeleted").val("false"); // 삭제 상태 초기화
	    isProfileDeleted = false;
	})
	
	// 파일 선택 시 이미지 미리보기
    $("#originalFileName").change(function() {
        readURL(this);
    });
	
    // 이미지 미리보기 함수
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function(e) {
                $("#previewImage").attr("src", e.target.result);
                console.log("이미지 미리보기 로드됨");
            }
            
            reader.readAsDataURL(input.files[0]);
        }
    }
	
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
