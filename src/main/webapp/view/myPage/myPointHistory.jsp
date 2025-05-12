html
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                <a href="myPointHistory.do" class="mypage_menu_item active">내 포인트 내역</a>
                <a href="myFollow.do" class="mypage_menu_item">팔로우</a>
                <a href="myGTRHistory.do" class="mypage_menu_item">게스더랭크 기록</a>
                <a href="myReport.do" class="mypage_menu_item">신고 기록</a>
            </nav>
        </div>
        
        <div class="mypage_user_section">
            <h2 class="mypage_section_title">포인트 사용내역</h2>
            
            <div class="mypage_point_summary">
                <div class="mypage_point_current">
                    <span class="mypage_point_label">현재 포인트</span>
                    <span class="mypage_point_value">${user.userPoint}P</span>
                </div>
            </div>
            
            <div class="mypage_point_container">
                <!-- 포인트 내역 테이블 -->
                <table class="mypage_point_table">
                    <thead>
                        <tr>
                            <th>번호</th>
                            <th>내용</th>
                            <th>포인트 변동</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty pointHistoryList}">
                            <tr class="mypage_empty_row">
                                <td colspan="4">포인트 사용내역이 없습니다.</td>
                            </tr>
                        </c:if>
                        
                        <c:forEach var="point" items="${pointHistoryList}" varStatus="status">
                            <tr>
                                <td>${status.count}</td>
                                <td>${point.pointSource}</td>
                                <td class="point_amount ${point.pointAmount > 0 ? 'plus' : 'minus'}">
                                    ${point.pointAmount > 0 ? '+' : ''}${point.pointAmount}P
                                </td>
                                <td><fmt:formatDate value="${point.pointDate}" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <!-- 페이징 처리 -->
                <c:if test="${!empty pointHistoryList}">
                    <div class="mypage_pagination">
                        <c:if test="${currentPage > 1}">
                            <a href="myPointHistory.do?page=${currentPage - 1}" class="page_btn prev">&lt;</a>
                        </c:if>
                        
                        <c:forEach var="i" begin="${startPage}" end="${endPage}">
                            <a href="myPointHistory.do?page=${i}" class="page_btn ${currentPage == i ? 'active' : ''}">${i}</a>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <a href="myPointHistory.do?page=${currentPage + 1}" class="page_btn next">&gt;</a>
                        </c:if>
                    </div>
                </c:if>
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

    /* 포인트 요약 정보 */
    .mypage_point_summary {
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding: 1.5rem;
        margin-bottom: 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .mypage_point_current {
        display: flex;
        align-items: center;
        gap: 1rem;
    }

    .mypage_point_label {
        font-size: 1rem;
        color: #ccc;
    }

    .mypage_point_value {
        font-size: 1.5rem;
        font-weight: bold;
        color: #4CAF50;
    }

    /* 포인트 내역 컨테이너 */
    .mypage_point_container {
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding: 1.5rem;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    /* 포인트 내역 테이블 */
    .mypage_point_table {
        width: 100%;
        border-collapse: collapse;
    }

    .mypage_point_table th,
    .mypage_point_table td {
        padding: 0.875rem 1rem;
        text-align: left;
        border-bottom: 0.0625rem solid #3a3a3a;
    }

    .mypage_point_table th {
        font-weight: bold;
        color: #f0f0f0;
        background-color: #2a2a2a;
    }

    .mypage_point_table th:first-child,
    .mypage_point_table td:first-child {
        width: 5rem;
        text-align: center;
    }

    .mypage_point_table th:last-child,
    .mypage_point_table td:last-child {
        width: 10rem;
        text-align: center;
    }

    .mypage_point_table th:nth-child(3),
    .mypage_point_table td:nth-child(3) {
        width: 9rem;
        text-align: right;
    }

    .mypage_point_table tbody tr:hover {
        background-color: #2a2a2a;
    }

    .point_amount.plus {
        color: #4CAF50;
    }

    .point_amount.minus {
        color: #c62828;
    }

    .mypage_empty_row td {
        text-align: center;
        color: #999;
        padding: 3rem 0;
    }

    /* 페이징 */
    .mypage_pagination {
        display: flex;
        justify-content: center;
        gap: 0.5rem;
        margin-top: 1.5rem;
    }

    .page_btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 2rem;
        height: 2rem;
        border-radius: 0.375rem;
        background-color: #2a2a2a;
        color: #ccc;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .page_btn:hover,
    .page_btn.active {
        background-color: #3a3a3a;
        color: white;
    }

    .page_btn.active {
        font-weight: bold;
        color: #4CAF50;
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
        padding: 0 !important;
    }

    /* 반응형 디자인 */
    @media (max-width: 48rem) { /* 768px */
        .mypage_point_table {
            font-size: 0.875rem;
        }
        
        .mypage_point_table th,
        .mypage_point_table td {
            padding: 0.75rem 0.5rem;
        }
        
        .mypage_point_table th:first-child,
        .mypage_point_table td:first-child {
            width: 3rem;
        }
        
        .mypage_point_table th:last-child,
        .mypage_point_table td:last-child {
            width: 7rem;
        }
    }
</style>
