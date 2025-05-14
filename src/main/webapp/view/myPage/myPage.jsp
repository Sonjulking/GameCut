<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="main_container">
    <div class="main_content">
        <div class="content_wrapper">
            <!-- 왼쪽 사이드바 -->
            <!-- 사이드바 include -->
            <jsp:include page="sidebar.jsp">
                <jsp:param name="activeMenu" value="board" />
            </jsp:include>
            
            <!-- 오른쪽 내 정보 섹션 -->
            <div class="mypage_user_section">
                <h2 class="mypage_section_title">내 정보</h2>
                
                <div class="mypage_profile">
                	<c:choose>
                		<c:when test="${user.photoNo == 0 || user.photoNo == null }">
		                    <div id="userImg" class="mypage_img_container">
		                        <img class="mypage_user_image" alt="프로필 이미지" src="img/main/icons/profile_icon.png">
		                    </div>
                		</c:when>
	                	<c:otherwise>
		                    <div id="userImg" class="mypage_img_container">
		                        <img class="mypage_user_image" alt="프로필 이미지" src="${file.fileUrl}">
		                    </div>
	                	</c:otherwise>
                	</c:choose>
                    <div class="mypage_user_details">
                        <c:if test="${user.role == 'role_admin' }">
                            <img alt="관리자이모티콘" src="/img/main/icons/admin.jpg" class="admin_icon">
                        </c:if>
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
</div>

<style>
    /* 전체 레이아웃 */
    .main_container {
        width: 100%;
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

    .mypage_profile {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 1.5rem;
        width: 100%;
        max-width: 25rem;
        margin: 0 auto;
    }

    /* 프로필 이미지 */
    .mypage_img_container {
        width: 10rem;
        height: 10rem;
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

    /* 관리자 아이콘 */
    .admin_icon {
        width: 2rem;
        height: 2rem;
        margin-bottom: 0.5rem;
    }

    /* 사용자 정보 */
    .mypage_user_details {
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 0.5rem;
        width: 100%;
    }

    .mypage_user_id {
        font-size: 1rem;
        color: #ccc;
        margin: 0;
    }

    .mypage_user_nickname {
        font-size: 1.75rem;
        font-weight: bold;
        color: #f0f0f0;
        margin: 0;
    }

    .mypage_user_point {
        font-size: 1rem;
        color: #ccc;
        margin: 0;
    }

    .mypage_user_point span {
        color: #4CAF50;
        font-weight: bold;
    }

    /* 액션 버튼 */
    .mypage_actions {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        width: 100%;
        max-width: 18.75rem;
        margin: 0 auto;
        margin-bottom: 1rem; /* 하단 여백 추가 */
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
        
        .mypage_img_container {
            width: 8rem;
            height: 8rem;
        }
        
        .main_content {
            max-height: none; /* 모바일에서는 최대 높이 제한 해제 */
            overflow-y: visible; /* 모바일에서는 스크롤 자동으로 처리 */
        }
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