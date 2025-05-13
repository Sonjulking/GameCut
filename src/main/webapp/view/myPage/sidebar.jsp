<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- 왼쪽 사이드바 -->
<div class="mypage_sidebar">
    <h2 class="mypage_title">마이페이지</h2>
    <nav class="mypage_menu">
        <a href="myPage.do" class="mypage_menu_item">내 정보</a>
        <a href="myMessage.do" class="mypage_menu_item ${param.activeMenu == 'message' ? 'active' : ''}">내 쪽지</a>
        <a href="myBoard.do" class="mypage_menu_item ${param.activeMenu == 'board' ? 'active' : ''}">내 게시글</a>
        <a href="myComment.do" class="mypage_menu_item ${param.activeMenu == 'comment' ? 'active' : ''}">내 댓글</a>
        <a href="myVideo.do" class="mypage_menu_item ${param.activeMenu == 'video' ? 'active' : ''}">내 영상</a>
        <a href="myItem.do" class="mypage_menu_item ${param.activeMenu == 'item' ? 'active' : ''}">내 아이템</a>
        <a href="myPointHistory.do" class="mypage_menu_item ${param.activeMenu == 'point' ? 'active' : ''}">내 포인트 내역</a>
        <a href="myFollow.do" class="mypage_menu_item ${param.activeMenu == 'follow' ? 'active' : ''}">팔로우</a>
        <a href="myGTRHistory.do" class="mypage_menu_item ${param.activeMenu == 'gtr' ? 'active' : ''}">게스더랭크 기록</a>
        <a href="myReport.do" class="mypage_menu_item ${param.activeMenu == 'report' ? 'active' : ''}">신고 기록</a>
    </nav>
</div>

<style>
/* 사이드바 스타일 */
.mypage_sidebar {
    width: 15.625rem;
    background-color: #2c2c2c;
    padding: 2rem;
    border-radius: 0.75rem;
    flex-shrink: 0;
    position: sticky;
    top: 1rem; /* 스크롤 시 상단에 고정 */
    max-height: calc(100vh - 12rem); /* 사이드바 최대 높이 설정 */
    overflow-y: auto; /* 내용이 넘치면 스크롤 가능하게 */
}

.mypage_title {
    font-size: 1.5rem;
    color: #f0f0f0;
    margin-bottom: 2rem;
    font-weight: bold;
    border-bottom: 0.0625rem solid #3a3a3a;
    padding-bottom: 1rem;
}

.mypage_menu {
    display: flex;
    flex-direction: column;
    gap: 0.75rem;
}

.mypage_menu_item {
    color: #ccc;
    text-decoration: none;
    font-size: 0.925rem;
    padding: 0.75rem 1rem;
    border-radius: 0.375rem;
    transition: all 0.2s ease;
    border: 0.0625rem solid transparent;
}

.mypage_menu_item:hover {
    background-color: #3a3a3a;
    color: white;
    border-color: #555;
}

/* 반응형 디자인 */
@media (max-width: 48rem) { /* 768px */
    .mypage_sidebar {
        width: 100%;
        position: static; /* 모바일에서는 고정 위치 해제 */
        max-height: none; /* 모바일에서는 최대 높이 제한 해제 */
    }
}
</style>