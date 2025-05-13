<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.gamecut.dao.ItemDAO, com.gamecut.vo.ItemVO, java.util.ArrayList, com.gamecut.vo.UserVO"%>

<div class="main_container">
    <div class="main_content">
        <div class="content_wrapper">
            <!-- 왼쪽 사이드바 -->
            <jsp:include page="sidebar.jsp">
                <jsp:param name="activeMenu" value="board" />
            </jsp:include>
            
            <!-- 오른쪽 내 정보 섹션 -->
            <div class="mypage_user_section">
                <h2 class="mypage_section_title">내 아이템 목록</h2>
                
                <div class="mypage_item_header">
                    <span class="user_point">보유 포인트: ${userPoint}P</span>
                    <a href="itemShop.do" class="shop_button">아이템 상점 가기</a>
                </div>
                
                <div class="mypage_item_container">
                    <c:if test="${empty file}">
                        <div class="mypage_empty_items">
                            <p>보유한 아이템이 없습니다.</p>
                            <a href="itemShop.do" class="empty_shop_link">아이템 상점에서 구매하기</a>
                        </div>
                    </c:if>
                    <div class="mypage_item_grid">
					    <c:forEach var="item" items="${userItem}" varStatus="status">
					        <div class="mypage_item_card">
					            <div class="mypage_item_image_container">
					                <img src="${file[status.index].fileUrl}" class="mypage_item_image" alt="${item.itemName}">
					            </div>
					            <div class="mypage_item_info">
					                <span class="mypage_item_name">${item.itemName}</span>
					                <span class="mypage_item_price">${item.itemPrice}P</span>
					                <button onclick="useItem(${item.itemNo}, '${item.itemName}')" class="mypage_item_use_btn">사용하기</button>
					            </div>
					        </div>
					    </c:forEach>
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

    /* 아이템 헤더 */
    .mypage_item_header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 1rem 0;
    }

    .user_point {
        font-size: 1.125rem;
        color: #4CAF50;
        font-weight: bold;
    }

    .shop_button {
        padding: 0.625rem 1rem;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 0.375rem;
        text-decoration: none;
        font-weight: 500;
        font-size: 0.925rem;
        transition: all 0.2s ease;
    }

    .shop_button:hover {
        background-color: #66BB6A;
    }

    /* 아이템 컨테이너 */
    .mypage_item_container {
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding: 1.5rem;
        overflow: hidden;
    }

    /* 빈 아이템 메시지 */
    .mypage_empty_items {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 3rem 1rem;
        text-align: center;
    }

    .mypage_empty_items p {
        font-size: 1.125rem;
        color: #aaa;
        margin-bottom: 1.5rem;
    }

    .empty_shop_link {
        padding: 0.75rem 1.25rem;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border-radius: 0.375rem;
        font-weight: 500;
        transition: all 0.2s ease;
    }

    .empty_shop_link:hover {
        background-color: #66BB6A;
    }

    /* 아이템 그리드 */
    .mypage_item_grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개의 아이템 */
        gap: 1.25rem;
    }

    /* 아이템 카드 */
    .mypage_item_card {
        background-color: #2a2a2a;
        border-radius: 0.625rem;
        overflow: hidden;
        box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.2);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .mypage_item_card:hover {
        transform: translateY(-0.25rem);
        box-shadow: 0 0.375rem 0.75rem rgba(0, 0, 0, 0.3);
    }

    .mypage_item_image_container {
        width: 100%;
        padding-top: 100%; /* 정사각형 비율 유지 */
        position: relative;
        background-color: #222;
        overflow: hidden;
    }

    .mypage_item_image {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }

    .mypage_item_card:hover .mypage_item_image {
        transform: scale(1.05);
    }

    .mypage_item_info {
        padding: 1rem;
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
    }

    .mypage_item_name {
        font-size: 1rem;
        color: #f0f0f0;
        font-weight: 500;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .mypage_item_price {
        font-size: 0.875rem;
        color: #4CAF50;
        font-weight: bold;
    }

    .mypage_item_use_btn {
        margin-top: 0.5rem;
        padding: 0.5rem;
        background-color: #3a3a3a;
        color: white;
        border: none;
        border-radius: 0.25rem;
        cursor: pointer;
        font-size: 0.875rem;
        transition: background-color 0.2s ease;
    }

    .mypage_item_use_btn:hover {
        background-color: #4CAF50;
    }

    /* 반응형 디자인 */
    @media (max-width: 64rem) { /* 1024px */
        .mypage_item_grid {
            grid-template-columns: repeat(3, 1fr); /* 태블릿에서는 한 줄에 3개 */
        }
    }

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
        
        .mypage_item_grid {
            grid-template-columns: repeat(2, 1fr); /* 모바일에서는 한 줄에 2개 */
        }
    }

    @media (max-width: 30rem) { /* 480px */
        .mypage_item_grid {
            grid-template-columns: 1fr; /* 작은 모바일에서는 한 줄에 1개 */
        }
    }
</style>

<script>
    function useItem(itemNo, itemName) {
        if (confirm(itemName + "을(를) 사용하시겠습니까?")) {
            // 서버에 아이템 사용 요청 전송
            location.href = "useItem.do?itemNo=" + itemNo;
        }
    }
</script>