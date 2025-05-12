<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                <a href="myFollow.do" class="mypage_menu_item active">팔로우</a>
                <a href="myGTRHistory.do" class="mypage_menu_item">게스더랭크 기록</a>
                <a href="myReport.do" class="mypage_menu_item">신고 기록</a>
            </nav>
        </div>
        
        <div class="mypage_user_section">
            <h2 class="mypage_section_title">팔로우 관리</h2>
            
            <!-- 팔로우/팔로워 섹션은 좌우 배치 유지 -->
            <div class="mypage_follow_container">
                <!-- 팔로우 목록 (내가 팔로우하는 사람들) -->
                <div class="mypage_follow_section">
                    <h3 class="mypage_follow_title">내 팔로우 목록</h3>
                    <div class="mypage_follow_list">
                        <c:if test="${empty followList}">
                            <p class="mypage_empty_msg">팔로우하는 사용자가 없습니다.</p>
                        </c:if>
                        
                        <c:forEach var="follow" items="${followList}" varStatus="status">
                            <div class="mypage_user_item">
                                <div class="mypage_user_item_img">
                                    <img src="${followImgUrlList[status.index]}" alt="프로필 이미지">
                                </div>
                                <div class="mypage_user_item_info">
                                    <p class="mypage_user_item_nickname">${follow.userNickname}</p>
                                    <p class="mypage_user_item_id">${follow.userId}</p>
                                </div>
                                <form action="unfollowUser.do" method="post" onsubmit="return confirm('해당 사용자를 언팔로우하시겠습니까?');">
                                    <input type="hidden" name="followNo" value="${follow.userNo}">
                                    <button type="submit" class="mypage_follow_btn">언팔로우</button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                
                <!-- 팔로워 목록 (나를 팔로우하는 사람들) -->
                <div class="mypage_follow_section">
                    <h3 class="mypage_follow_title">내 팔로워 목록</h3>
                    <div class="mypage_follow_list">
                        <c:if test="${empty followerList}">
                            <p class="mypage_empty_msg">팔로워가 없습니다.</p>
                        </c:if>
                        
                        <c:forEach var="follower" items="${followerList}" varStatus="status">
                            <div class="mypage_user_item">
                                <div class="mypage_user_item_img">
                                    <img src="${followerImgUrlList[status.index]}" alt="프로필 이미지">
                                </div>
                                <div class="mypage_user_item_info">
                                    <p class="mypage_user_item_nickname">${follower.userNickname}</p>
                                    <p class="mypage_user_item_id">${follower.userId}</p>
                                </div>
                                
                                <!-- 이미 팔로우 중인지 확인 -->
                                <c:set var="isFollowing" value="false" />
                                <c:forEach var="follow" items="${followList}">
                                    <c:if test="${follow.userNo == follower.userNo}">
                                        <c:set var="isFollowing" value="true" />
                                    </c:if>
                                </c:forEach>
                                
                                <c:choose>
                                    <c:when test="${isFollowing}">
                                        <!-- 이미 팔로우 중이면 언팔로우 버튼 표시 -->
                                        <form action="unfollowUser.do" method="post" onsubmit="return confirm('해당 사용자를 언팔로우하시겠습니까?');">
                                            <input type="hidden" name="followNo" value="${follower.userNo}">
                                            <button type="submit" class="mypage_follow_btn">언팔로우</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 팔로우 안 했으면 팔로우 버튼 표시 -->
                                        <form action="followUser.do" method="post" onsubmit="return confirm('해당 사용자를 팔로우하시겠습니까?');">
                                            <input type="hidden" name="followNo" value="${follower.userNo}">
                                            <button type="submit" class="mypage_follow_btn follow">팔로우</button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:forEach>
                    </div>
                </div>
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

    .mypage_menu_item:hover, .mypage_menu_item.active {
        background-color: #3a3a3a;
        color: white;
        border-color: #555;
    }

    .mypage_user_section {
        flex: 1;
        padding: 2rem;
        display: flex;
        flex-direction: column;
        gap: 2rem;
    }

    .mypage_section_title {
        font-size: 1.5rem;
        color: #f0f0f0;
        margin: 0 0 1rem 0;
        padding-bottom: 0.5rem;
        border-bottom: 0.0625rem solid #3a3a3a;
    }

    /* 팔로우/팔로워 섹션 스타일 - 좌우 배치 */
    .mypage_follow_container {
        display: flex;
        gap: 1.5rem;
        width: 100%;
    }

    .mypage_follow_section {
        flex: 1;
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding : 0;
        overflow-y: auto;
        min-height: 30rem;
        max-height: 30rem;
    }

    .mypage_follow_title {
        font-size: 1.125rem;
        color: #f0f0f0;
        margin: 0 0 1.5rem 0;
        padding-bottom: 0.5rem;
        border-bottom: 0.0625rem solid #3a3a3a;
    }

    /* 유저 목록 - 세로 배치 (강제 적용) */
    .mypage_follow_list {
        display: flex !important;
        flex-direction: column !important;
        gap: 1rem !important;
    }

    /* 유저 항목 - 세로 레이아웃 */
    .mypage_user_item {
        display: flex !important;
        flex-direction: row !important;
        align-items: center !important;
        gap: 1rem !important;
        padding: 0.75rem !important;
        border-radius: 0.5rem !important;
        background-color: #2a2a2a !important;
        transition: background-color 0.2s ease !important;
        width: 100% !important;
    }

    .mypage_user_item:hover {
        background-color: #333 !important;
    }

    .mypage_user_item_img {
        width: 2rem !important;  
        height: 2rem !important;
        border-radius: 100% !important; 
        overflow: hidden !important;
        border: 0.125rem solid #3a3a3a !important;
        flex-shrink: 0 !important;
        position: relative !important; 
        display: block !important;
    }

    .mypage_user_item_img img {
        width: 100% !important;
        height: 100% !important;
        object-fit: cover !important;
        position: absolute !important; /* 이미지 위치 고정 */
        top: 0 !important;
        left: 0 !important;
    }

    .mypage_user_item_info {
        flex: 1 !important;
        min-width: 0 !important;
        display: flex !important;
        flex-direction: column !important;
    }

    .mypage_user_item_nickname {
        font-size: 0.925rem !important; /* 폰트 크기 줄임 */
        font-weight: bold !important;
        color: #f0f0f0 !important;
        margin: 0 !important;
        overflow: hidden !important;
        text-overflow: ellipsis !important;
        white-space: nowrap !important;
    }

    .mypage_user_item_id {
        font-size: 0.8125rem !important; /* 폰트 크기 줄임 */
        color: #999 !important;
        margin: 0.25rem 0 0 0 !important;
        overflow: hidden !important;
        text-overflow: ellipsis !important;
        white-space: nowrap !important;
    }

    .mypage_follow_btn {
        padding: 0.375rem 0.625rem !important; /* 버튼 크기 줄임 */
        border: none !important;
        border-radius: 0.375rem !important;
        background-color: #c62828 !important;
        color: white !important;
        cursor: pointer !important;
        font-weight: 500 !important;
        font-size: 0.8125rem !important; /* 폰트 크기 줄임 */
        text-align: center !important;
        transition: background-color 0.2s ease !important;
    }

    .mypage_follow_btn:hover {
        background-color: #ef5350 !important;
    }

    .mypage_follow_btn.follow {
        background-color: #4CAF50 !important;
    }

    .mypage_follow_btn.follow:hover {
        background-color: #66BB6A !important;
    }

    .mypage_empty_msg {
        color: #999 !important;
        text-align: center !important;
        padding: 1rem 0 !important;
        font-size: 0.925rem !important;
    }

    /* 폼 스타일 - 버튼만 표시되도록 */
    .mypage_user_item form {
        margin: 0 !important;
        padding: 0 !important;
        display: block !important;
    }

    /* 기존 main_content의 flex 스타일을 오버라이드 */
    .main_container > .main_content {
        display: flex !important;
        flex-direction: row !important;
        background-color: #1a1a1a !important;
        border-radius: 0.75rem !important;
        min-height: 37.5rem !important;
        box-shadow: 0 0.25rem 0.375rem rgba(0, 0, 0, 0.3) !important;
        align-items: stretch !important;
    }

    /* 이 페이지에 한해서만 기존 스타일 오버라이드 */
    .main_container > .main_content > div {
        display: flex !important;
        flex-direction: column !important;
        align-items: stretch !important;
        justify-content: flex-start !important;
        padding: 2rem 1rem 0 0 !important;
    }

    /* 반응형 디자인 */
    @media (max-width: 48rem) { /* 768px */
        .mypage_follow_container {
            flex-direction: column !important;
        }
        
        .mypage_follow_section {
            min-height: 20rem !important;
            max-height: 20rem !important;
        }
    }
</style>
