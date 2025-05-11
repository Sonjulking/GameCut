<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<div class="main_container">
    <div class="main_content">
        <div class="mypage_sidebar">
            <h2 class="mypage_title">마이페이지</h2>
            <nav class="mypage_menu">
                <a href="" class="mypage_menu_item">내 쪽지</a>
                <a href="myBoard.do" class="mypage_menu_item">내 게시글</a>
                <a href="myComment.do" class="mypage_menu_item">내 댓글</a>
                <a href="myVideo.do" class="mypage_menu_item">내 영상</a>
                <a href="myItem.do" class="mypage_menu_item">내 아이템</a>
                <a href="myPointHistory.do" class="mypage_menu_item">내 포인트 내역</a>
                <a href="myFollow.do" class="mypage_menu_item">팔로우</a>
                <a href="myGTRHistory.do" class="mypage_menu_item">게스더랭크 기록</a>
                <a href="myReport.do" class="mypage_menu_item">신고 기록</a>
            </nav>
        </div>
        
        <div class="mypage_user_section">
            <div class="mypage_profile">
                <div id="userImg" class="mypage_user_image">
                    <img alt="프로필 이미지" src="${file.fileUrl}">
                </div>
                <div class="mypage_user_details">
                    <div id="userId" class="mypage_user_id">${user.userId}</div>
                    <div id="userNickname" class="mypage_user_nickname">${user.userNickname}</div>
                    <div id="userPoint" class="mypage_user_point">포인트: <span>${user.userPoint}</span>P</div>
                </div>
            </div>
            
            <div class="mypage_actions">
                <a href="updateMyPage.do" class="mypage_action_btn">내 정보 수정</a>
                <a href="updatePassword.do" class="mypage_action_btn">비밀번호 변경</a>
                <a href="deleteUser.do" class="mypage_action_btn mypage_danger">탈퇴하기</a>
            </div>
        </div>
    </div>
</div>

<style>
    /* 마이페이지 전용 클래스 - 기존 스타일과 충돌 방지 */
    .mypage_sidebar {
        width: 250px;
        background-color: #2c2c2c;
        padding: 2rem;
        border-radius: 0.75rem;
    }

    .mypage_title {
        font-size: 1.5rem;
        color: #f0f0f0;
        margin-bottom: 2rem;
        font-weight: bold;
        border-bottom: 1px solid #3a3a3a;
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
        border: 1px solid transparent;
    }

    .mypage_menu_item:hover {
        background-color: #3a3a3a;
        color: white;
        border-color: #555;
    }

    .mypage_user_section {
        flex: 1;
        padding: 3rem;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 3rem;
    }

    .mypage_profile {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1.5rem;
    }

    .mypage_user_image {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        overflow: hidden;
        border: 2px solid #3a3a3a;
    }

    .mypage_user_image img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .mypage_user_details {
        text-align: center;
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .mypage_user_id {
        font-size: 1rem;
        color: #ccc;
    }

    .mypage_user_nickname {
        font-size: 1.5rem;
        font-weight: bold;
        color: #f0f0f0;
    }

    .mypage_user_point {
        font-size: 0.925rem;
        color: #ccc;
    }

    .mypage_user_point span {
        color: #4CAF50;
        font-weight: bold;
    }

    .mypage_actions {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        width: 100%;
        max-width: 300px;
    }

    .mypage_action_btn {
        padding: 0.75rem;
        border: none;
        border-radius: 0.375rem;
        background-color: #3a3a3a;
        color: white;
        text-decoration: none;
        cursor: pointer;
        font-weight: 500;
        font-size: 0.925rem;
        text-align: center;
        transition: background-color 0.2s ease;
    }

    .mypage_action_btn:hover {
        background-color: #555;
    }

    .mypage_action_btn.mypage_danger {
        background-color: #c62828;
    }

    .mypage_action_btn.mypage_danger:hover {
        background-color: #ef5350;
    }

    /* 기존 main_content의 flex 스타일을 오버라이드 */
    .main_container > .main_content {
        display: flex;
        flex-direction: row;
        background-color: #1a1a1a;
        border-radius: 0.75rem;
        min-height: 600px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.3);
        align-items: stretch;
    }

    /* 기존 스타일 오버라이드 방지 */
    .main_container > .main_content > div {
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: stretch;
        justify-content: flex-start;
    }
</style>
```