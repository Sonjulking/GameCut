<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="main_container">
    <div class="main_content">
        <div class="content_wrapper">
            <!-- 왼쪽 사이드바 -->
            <jsp:include page="sidebar.jsp">
                <jsp:param name="activeMenu" value="board" />
            </jsp:include>
            
            <!-- 오른쪽 내 정보 섹션 -->
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
</div>

<style>
    /* 전체 레이아웃 */
    .main_container {
        width: 95%;
        margin-bottom: 4rem; /* 푸터와의 간격 추가 */
        min-height: calc(100vh - 8rem); /* 뷰포트 높이에서 헤더와 푸터 높이를 뺀 값 */
        position: relative;
    }

    .main_content {
        background-color: #1a1a1a;
        border-radius: 0.75rem;
        box-shadow: 0 0.25rem 0.375rem rgba(0, 0, 0, 0.3);
        padding: 1rem;
        max-height: calc(100vh - 10rem); /* 뷰포트 높이에서 헤더, 푸터, 마진 등을 뺀 값 */
        overflow-y: auto; /* 내용이 넘치면 스크롤 가능하게 */
    }
    
    /* 컨텐츠 래퍼 - 사이드바와 내 정보 섹션을 감싸는 컨테이너 */
    .content_wrapper {
        display: flex;
        gap: 2rem;
        align-items: flex-start;
    }

    /* 사이드바 */
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

    /* 사용자 섹션 */
    .mypage_user_section {
        flex: 1;
        background-color: #2c2c2c;
        padding: 2rem;
        border-radius: 0.75rem;
        display: flex;
        flex-direction: column;
        gap: 2rem;
        margin-right: 3rem;
        max-height: calc(100vh - 12rem); /* 최대 높이 설정 */
        overflow-y: auto; /* 내용이 넘치면 스크롤 가능하게 */
    }

    .mypage_section_title {
        font-size: 1.5rem;
        color: #f0f0f0;
        margin: 0;
        padding-bottom: 1rem;
        border-bottom: 0.0625rem solid #3a3a3a;
    }

    /* 팔로우/팔로워 섹션 스타일 - 좌우 배치 */
    .mypage_follow_container {
        display: flex;
        gap: 1.5rem;
        width: 100%;
        height: 100%;
    }

    .mypage_follow_section {
        flex: 1;
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding: 1.5rem;
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

    /* 유저 목록 - 세로 배치 */
    .mypage_follow_list {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }

    /* 유저 항목 - 가로 레이아웃 */
    .mypage_user_item {
        display: flex;
        align-items: center;
        gap: 1rem;
        padding: 0.75rem;
        border-radius: 0.5rem;
        background-color: #2a2a2a;
        transition: background-color 0.2s ease;
    }

    .mypage_user_item:hover {
        background-color: #333;
    }

    .mypage_user_item_img {
        width: 2.5rem;
        height: 2.5rem;
        border-radius: 50%;
        overflow: hidden;
        border: 0.125rem solid #3a3a3a;
        flex-shrink: 0;
        position: relative;
    }

    .mypage_user_item_img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        position: absolute;
        top: 0;
        left: 0;
    }

    .mypage_user_item_info {
        flex: 1;
        min-width: 0;
        display: flex;
        flex-direction: column;
    }

    .mypage_user_item_nickname {
        font-size: 1rem;
        font-weight: bold;
        color: #f0f0f0;
        margin: 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .mypage_user_item_id {
        font-size: 0.875rem;
        color: #999;
        margin: 0.25rem 0 0 0;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .mypage_follow_btn {
        padding: 0.5rem 0.75rem;
        border: none;
        border-radius: 0.375rem;
        background-color: #c62828;
        color: white;
        cursor: pointer;
        font-weight: 500;
        font-size: 0.875rem;
        text-align: center;
        transition: background-color 0.2s ease;
    }

    .mypage_follow_btn:hover {
        background-color: #ef5350;
    }

    .mypage_follow_btn.follow {
        background-color: #4CAF50;
    }

    .mypage_follow_btn.follow:hover {
        background-color: #66BB6A;
    }

    .mypage_empty_msg {
        color: #999;
        text-align: center;
        padding: 1rem 0;
        font-size: 0.925rem;
    }

    /* 폼 스타일 - 버튼만 표시되도록 */
    .mypage_user_item form {
        margin: 0;
        padding: 0;
        display: block;
    }

    /* 반응형 디자인 */
    @media (max-width: 48rem) { /* 768px */
        .content_wrapper {
            flex-direction: column;
        }
        
        .mypage_sidebar {
            width: 100%;
            position: static; /* 모바일에서는 고정 위치 해제 */
            max-height: none; /* 모바일에서는 최대 높이 제한 해제 */
        }
        
        .mypage_user_section {
            margin-right: 0;
            max-height: none; /* 모바일에서는 최대 높이 제한 해제 */
        }
        
        .main_content {
            max-height: none; /* 모바일에서는 최대 높이 제한 해제 */
            overflow-y: visible; /* 모바일에서는 스크롤 자동으로 처리 */
        }
        
        .mypage_follow_container {
            flex-direction: column;
        }
        
        .mypage_follow_section {
            min-height: 20rem;
            max-height: 20rem;
        }
    }
</style>