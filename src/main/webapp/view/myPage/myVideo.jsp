<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="main_container">
    <div class="main_content">
        <div class="content_wrapper">
            <!-- 왼쪽 사이드바 -->
            <jsp:include page="sidebar.jsp">
                <jsp:param name="activeMenu" value="board" />
            </jsp:include>
            
            <!-- 오른쪽 내 정보 섹션 -->
            <div class="mypage_user_section">
                <h2 class="mypage_section_title">내 영상 관리</h2>
                
                <div class="mypage_video_container">
                    <div class="mypage_not_implemented">
                        <p>아직 미구현 기능입니다.</p>
                    </div>
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

    /* 영상 관리 미구현 컨테이너 */
    .mypage_video_container {
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding: 1.5rem;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        min-height: 20rem;
    }

    /* 미구현 메시지 스타일 */
    .mypage_not_implemented {
        text-align: center;
        padding: 3rem 2rem;
    }

    .mypage_not_implemented p {
        font-size: 1.5rem;
        color: #aaa;
        margin: 0;
        font-weight: 500;
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
        
        .mypage_not_implemented p {
            font-size: 1.25rem;
        }
    }
</style>