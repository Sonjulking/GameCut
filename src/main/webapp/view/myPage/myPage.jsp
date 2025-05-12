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
                <a href="myGTRHistory.do" class="mypage_menu_item">	게스더랭크 기록</a>
                <a href="myReport.do" class="mypage_menu_item">신고 기록</a>
            </nav>
        </div>
        
        <div class="mypage_user_section">
            <div class="mypage_profile">
                <div id="userImg" class="mypage_img_container">
                    <img class="mypage_user_image" alt="프로필 이미지" src="${file.fileUrl}">
                </div>
                <div class="mypage_user_details">
                    <p id="userId" class="mypage_user_id">${user.userId}</p>
                    <p id="userNickname" class="mypage_user_nickname">${user.userNickname}</p>
                    <p id="userPoint" class="mypage_user_point">포인트: <span>${user.userPoint}</span>P</p>
                </div>
            </div>
            
            <div class="mypage_actions">
                <a href="updateMyPage.do" class="mypage_action_btn">내 정보 수정</a>
                <a href="updatePassword.do" class="mypage_action_btn">비밀번호 변경</a>
                <a href="javascript:void(0);" onclick="confirmDelete();" class="mypage_action_btn mypage_danger">탈퇴하기</a>
            </div>
        </div>
    </div>
</div>

<style>
    /* 마이페이지 전용 클래스 - 기존 스타일과 충돌 방지 */
    .mypage_sidebar {
        width: 15.625rem;
        background-color: #2c2c2c;
        padding: 2rem;
        border-radius: 0.75rem;
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

    .mypage_user_section {
        flex: 1;
        padding: 3rem;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        gap: 3rem;
        /* 중앙 정렬 문제 해결 */
        margin-left: auto;
        margin-right: auto;
    }

    .mypage_profile {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1.5rem;
        width: 100%;
        max-width: 25rem;
        margin: 0 auto;
    }

    /* 프로필 이미지 컨테이너를 추가하여 이미지 비율 문제 해결 */
    .mypage_img_container {
        width: 7.5rem;
        height: 7.5rem;
        overflow: hidden;
        border-radius: 50%;
        background-color: #3a3a3a;
        border: 0.125rem solid #3a3a3a;
        position: relative;
    }

    .mypage_user_image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        display: block;
        position: absolute;
        top: 0;
        left: 0;
    }

    .mypage_user_details {
        text-align: center;
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        width: 100%;
    }

    .mypage_user_id {
        font-size: 1rem;
        color: #ccc;
        margin: 0;
    }

    .mypage_user_nickname {
        font-size: 1.5rem;
        font-weight: bold;
        color: #f0f0f0;
        margin: 0;
    }

    .mypage_user_point {
        font-size: 0.925rem;
        color: #ccc;
        margin: 0;
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
        max-width: 18.75rem;
        margin: 0 auto;
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
        min-height: 37.5rem;
        box-shadow: 0 0.25rem 0.375rem rgba(0, 0, 0, 0.3);
        align-items: stretch;
    }

    /* 이 페이지에 한해서만 기존 스타일 오버라이드 */
    .main_container > .main_content > div {
        display: flex !important;
        flex-direction: column !important;
        align-items: stretch !important;
        justify-content: flex-start !important;
        padding: 0 !important;
    }
</style>

<script>
    function confirmDelete() {
        if(confirm("정말 탈퇴하시겠습니까?")) {
            // '네'를 클릭한 경우 탈퇴 페이지로 이동
            window.location.href = "deleteUser.do";
        }
        // '아니오'를 클릭한 경우 아무 일도 일어나지 않음
    }
</script>
