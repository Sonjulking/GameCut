<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>

<a href="">내 쪽지</a>
<a href="myBoard.do">내 게시글</a>
<a href="myComment.do">내 댓글</a>
<a href="myVideo.do">내 영상</a>
<a href="myItem.do">내 아이템</a>
<a href="myPointHistory.do">내 포인트 내역</a>
<a href="myFollow.do">팔로우</a>
<a href="myGTRHistory.do">게스더랭크 기록</a>
<a href="myReport.do">신고 기록</a>

이름 :${user.userName }<br>
아이디 : ${user.userId }<br>
사용자닉네임 : ${user.userNickname } <br>
핸드폰번호 :  ${user.phone }<br>
이메일 :  ${user.email }<br>
<a href="updateMyPage.do">내 정보 수정</a>
<a href="deleteUser.do">탈퇴하기</a>
