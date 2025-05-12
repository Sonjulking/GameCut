<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<div class="main_container">
    <div class="main_content">
        <div id="userImg"> <img alt="" src="upload/${file.originalFileName }"> </div>
        <div id="userId">${user.userId }</div>
        <div id="userNickname">${user.userNickname }</div>
        <div id="userPoint">${user.userPoint }</div>
        <a href="updateMyPage.do">내 정보 수정</a>
        <a href="deleteUser.do">탈퇴하기</a>
    </div>
</div>
