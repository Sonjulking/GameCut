<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="main_container">
    <div class="main_content">
        <div class="mypage_sidebar">
            <h2 class="mypage_title">마이페이지</h2>
            <nav class="mypage_menu">
                <a href="" class="mypage_menu_item">내 쪽지</a>
                <a href="myBoard.do" class="mypage_menu_item active">내 게시글</a>
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
                
                <!-- 검색 폼 -->
                <div class="mypage_search_form">
                    <form action="searchBoard.do" method="get">
                        <select name="category" class="mypage_select">
                            <option value="nickname">닉네임</option>
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                        </select>
                        <input type="text" name="keyword" placeholder="검색어를 입력하세요" class="mypage_input">
                        <button type="submit" class="mypage_search_btn">검색</button>
                    </form>
                </div>
                
                <!-- 페이징 처리 (있을 경우) -->
                <c:if test="${!empty pagingInfo}">
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

    /* 게시판 컨테이너 */
    .mypage_board_container {
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding: 1.5rem;
        overflow: hidden;
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