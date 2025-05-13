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
                <h2 class="mypage_section_title">게시판 전체 글 목록</h2>
                
                <div class="mypage_board_container">
                    <!-- 게시글 리스트 테이블 -->
                    <table class="mypage_board_table">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자(번호)</th>
                                <th>조회수</th>
                                <th>좋아요</th>
                                <th>작성일</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="board" items="${list}">
                                <tr>
                                    <td>${board.boardNo}</td>
                                    <td class="title_cell">
                                        <a href="detailBoard.do?boardNo=${board.boardNo}" class="board_title_link">
                                            ${board.boardTitle}
                                        </a>
                                    </td>
                                    <td>${board.userNo}</td>
                                    <td>${board.boardCount}</td>
                                    <td>${board.boardLike}</td>
                                    <td>${board.boardCreateDate}</td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty list}">
                                <tr class="mypage_empty_row">
                                    <td colspan="6">등록된 게시글이 없습니다.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                    
                    <!-- 페이징 처리 (있을 경우) -->
                    <%-- <c:if test="${!empty pagingInfo}">
                        <div class="mypage_pagination">
                            <c:if test="${pagingInfo.currentPage > 1}">
                                <a href="myBoard.do?page=${pagingInfo.currentPage - 1}" class="page_btn prev">&lt;</a>
                            </c:if>
                            
                            <c:forEach var="i" begin="${pagingInfo.startPage}" end="${pagingInfo.endPage}">
                                <a href="myBoard.do?page=${i}" class="page_btn ${pagingInfo.currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            
                            <c:if test="${pagingInfo.currentPage < pagingInfo.totalPages}">
                                <a href="myBoard.do?page=${pagingInfo.currentPage + 1}" class="page_btn next">&gt;</a>
                            </c:if>
                        </div>
                    </c:if> --%>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
/* 전체 레이아웃 */
.main_container {
    width: 100%;
}

.main_content {
    background-color: #1a1a1a;
    border-radius: 0.75rem;
    box-shadow: 0 0.25rem 0.375rem rgba(0, 0, 0, 0.3);
    padding: 1rem;
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
}

.mypage_section_title {
    font-size: 1.5rem;
    color: #f0f0f0;
    margin: 0;
    padding-bottom: 1rem;
    border-bottom: 0.0625rem solid #3a3a3a;
}

/* 게시판 컨테이너 */
.mypage_board_container {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
}

/* 게시판 테이블 */
.mypage_board_table {
    width: 100%;
    border-collapse: collapse;
}

.mypage_board_table th,
.mypage_board_table td {
    padding: 0.875rem 1rem;
    text-align: left;
    border-bottom: 0.0625rem solid #3a3a3a;
}

.mypage_board_table th {
    font-weight: bold;
    color: #f0f0f0;
    background-color: #2a2a2a;
}

.mypage_board_table th:first-child,
.mypage_board_table td:first-child {
    width: 4rem;
    text-align: center;
}

.mypage_board_table th:nth-child(3),
.mypage_board_table td:nth-child(3) {
    width: 8rem;
    text-align: center;
}

.mypage_board_table th:nth-child(4),
.mypage_board_table td:nth-child(4),
.mypage_board_table th:nth-child(5),
.mypage_board_table td:nth-child(5) {
    width: 5rem;
    text-align: center;
}

.mypage_board_table th:last-child,
.mypage_board_table td:last-child {
    width: 10rem;
    text-align: center;
}

.title_cell {
    max-width: 20rem;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.board_title_link {
    color: #f0f0f0;
    text-decoration: none;
    transition: color 0.2s ease;
}

.board_title_link:hover {
    color: #4CAF50;
    text-decoration: underline;
}

.mypage_board_table tbody tr:hover {
    background-color: #2a2a2a;
}

.mypage_empty_row td {
    text-align: center;
    color: #999;
    padding: 3rem 0;
}

/* 검색 폼 */
.mypage_search_form {
    display: flex;
    justify-content: center;
    margin-top: 1rem;
}

.mypage_search_form form {
    display: flex;
    gap: 0.5rem;
}

.mypage_select {
    padding: 0.625rem;
    border: none;
    border-radius: 0.375rem;
    background-color: #2a2a2a;
    color: white;
}

.mypage_input {
    padding: 0.625rem;
    border: none;
    border-radius: 0.375rem;
    background-color: #2a2a2a;
    color: white;
    width: 15rem;
}

.mypage_search_btn {
    padding: 0.625rem 1rem;
    border: none;
    border-radius: 0.375rem;
    background-color: #3a3a3a;
    color: white;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.mypage_search_btn:hover {
    background-color: #4CAF50;
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
    }
    
    .mypage_board_table {
        font-size: 0.875rem;
    }
    
    .mypage_board_table th,
    .mypage_board_table td {
        padding: 0.75rem 0.5rem;
    }
    
    .title_cell {
        max-width: 10rem;
    }
}
</style>