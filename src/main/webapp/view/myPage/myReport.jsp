<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="main_container">
    <div class="main_content">
        <div class="content_wrapper">
            <!-- 왼쪽 사이드바 -->
            <jsp:include page="sidebar.jsp">
                <jsp:param name="activeMenu" value="board" />
            </jsp:include>
            
            <!-- 오른쪽 내 정보 섹션 -->
            <div class="mypage_user_section">
                <h2 class="mypage_section_title">내 신고 기록</h2>
                
                <div class="mypage_report_container">
                    <!-- 신고 내역 테이블 -->
                    <table class="mypage_report_table">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>신고 유형</th>
                                <th>신고 내용</th>
                                <th>신고 일자</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty reportList}">
                                <tr class="mypage_empty_row">
                                    <td colspan="4">신고한 내역이 없습니다.</td>
                                </tr>
                            </c:if>
                            
                            <c:forEach var="report" items="${reportList}" varStatus="status">
                                <tr onclick="goToBoard(${report.boardNo})" class="clickable_row">
                                    <td>${report.reportNo}</td>
                                    <td>${report.reportType}</td>
                                    <td>${report.reportContent}</td>
                                    <td><fmt:formatDate value="${report.reportDate}" pattern="yyyy-MM-dd"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <!-- 페이징 처리 (있을 경우) -->
                    <c:if test="${!empty pagingInfo}">
                        <div class="mypage_pagination">
                            <c:if test="${pagingInfo.currentPage > 1}">
                                <a href="myReport.do?page=${pagingInfo.currentPage - 1}" class="page_btn prev">&lt;</a>
                            </c:if>
                            
                            <c:forEach var="i" begin="${pagingInfo.startPage}" end="${pagingInfo.endPage}">
                                <a href="myReport.do?page=${i}" class="page_btn ${pagingInfo.currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            
                            <c:if test="${pagingInfo.currentPage < pagingInfo.totalPages}">
                                <a href="myReport.do?page=${pagingInfo.currentPage + 1}" class="page_btn next">&gt;</a>
                            </c:if>
                        </div>
                    </c:if>
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

    /* 신고 내역 컨테이너 */
    .mypage_report_container {
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding: 1.5rem;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
        height: 100%;
    }

    /* 신고 내역 테이블 */
    .mypage_report_table {
        width: 100%;
        border-collapse: collapse;
    }

    .mypage_report_table th,
    .mypage_report_table td {
        padding: 0.875rem 1rem;
        text-align: left;
        border-bottom: 0.0625rem solid #3a3a3a;
    }

    .mypage_report_table th {
        font-weight: bold;
        color: #f0f0f0;
        background-color: #2a2a2a;
    }

    .mypage_report_table th:first-child,
    .mypage_report_table td:first-child {
        width: 5rem;
        text-align: center;
    }

    .mypage_report_table th:nth-child(2),
    .mypage_report_table td:nth-child(2) {
        width: 8rem;
        text-align: center;
    }

    .mypage_report_table th:last-child,
    .mypage_report_table td:last-child {
        width: 9rem;
        text-align: center;
    }

    /* 클릭 가능한 행 */
    .clickable_row {
        cursor: pointer;
        transition: background-color 0.2s ease;
    }

    .clickable_row:hover {
        background-color: #2a2a2a;
    }

    /* 신고 내용 셀 스타일 */
    .report_content {
        position: relative;
        max-width: 30rem;
    }

    .content_preview {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .content_full {
        display: none;
        position: absolute;
        top: -0.5rem;
        left: 0;
        background-color: #2a2a2a;
        padding: 1rem;
        border-radius: 0.375rem;
        box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.3);
        z-index: 10;
        width: 20rem;
        white-space: normal;
    }

    .report_content:hover .content_full {
        display: block;
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
        
        .mypage_report_table {
            font-size: 0.875rem;
        }
        
        .mypage_report_table th,
        .mypage_report_table td {
            padding: 0.75rem 0.5rem;
        }
        
        .report_content {
            max-width: 10rem;
        }
    }
</style>

<script>
    // 게시글 상세 페이지로 이동하는 함수
    function goToBoard(boardNo) {
        location.href = "detailBoard.do?boardNo=" + boardNo;
    }
</script>