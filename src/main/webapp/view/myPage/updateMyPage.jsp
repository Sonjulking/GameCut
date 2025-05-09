<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="main_container">
    <div class="main_content">
		<h2 class="joinUserTitle">내 정보 수정</h2>
		<hr>
		<form action="updateMyPageOK.do" method="post" enctype="multipart/form-data">
			<c:if test="${empty file.originalFileName}">
				<img class="oldFileName" src="img/common/empty.png" width="200" height="200" style="border-radius: 100%;"> <br>
			</c:if>
			<c:if test="${!empty file.originalFileName}">
				<img class="oldFileName" src="${file.fileUrl }" width="200" height="200" style="border-radius: 100%;"> <br>
			</c:if>
			사용자닉네임 : "${user.userNickname }"<br>
			핸드폰번호 : value="${user.phone }"<br>
			이메일 : ${user.email }<br>
			프로필 : <input type="file" name="originalFileName"><br>
			<input type="hidden" name="oldFileName" value="${file.originalFileName }">
			<input type="text" name="userNo" value="${user.userNo }">
			<input type="button" id="deleteFile" value="프로필사진 삭제">
			<input type="submit" value="완료" id ="btnOK">
			<input type="reset" value="다시" id="btnReset">
		</form>
    </div>
<script type="text/javascript">
$(function() {
	$(".deleteFile").click(function() {
		$("#oldFileName").attr("src", "img/common/empty.png");
	})
})
</script>
</div>
