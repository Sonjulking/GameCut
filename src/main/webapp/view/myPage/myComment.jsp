<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="main_container">
    <div class="main_content">
        <div class="content_wrapper">
            <!-- 왼쪽 사이드바 -->
            <div class="mypage_sidebar">
                <h2 class="mypage_title">마이페이지</h2>
                <nav class="mypage_menu">
                    <a href="myMessage.do" class="mypage_menu_item">내 쪽지</a>
                    <a href="myBoard.do" class="mypage_menu_item">내 게시글</a>
                    <a href="myComment.do" class="mypage_menu_item active">내 댓글</a>
                    <a href="myVideo.do" class="mypage_menu_item">내 영상</a>
                    <a href="myItem.do" class="mypage_menu_item">내 아이템</a>
                    <a href="myPointHistory.do" class="mypage_menu_item">내 포인트 내역</a>
                    <a href="myFollow.do" class="mypage_menu_item">팔로우</a>
                    <a href="myGTRHistory.do" class="mypage_menu_item">게스더랭크 기록</a>
                    <a href="myReport.do" class="mypage_menu_item">신고 기록</a>
                </nav>
            </div>
            
            <!-- 오른쪽 내 정보 섹션 -->
            <div class="mypage_user_section">
                <h2 class="mypage_section_title">내 댓글 목록</h2>
                
                <div class="mypage_comment_container">
                    <!-- 댓글 리스트 테이블 -->
                    <table class="mypage_comment_table">
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>댓글 내용</th>
                                <th>원글 번호</th>
                                <th>작성일</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:if test="${empty commentList}">
                                <tr class="mypage_empty_row">
                                    <td colspan="5">작성한 댓글이 없습니다.</td>
                                </tr>
                            </c:if>
                            
                            <c:forEach var="comment" items="${commentList}">
                                <tr>
                                    <td>${comment.commentNo}</td>
                                    <td class="comment_cell">
                                        <a href="detailBoard.do?boardNo=${comment.boardNo}#comment-${comment.commentNo}" class="comment_link">
                                            <c:if test="${comment.parentCommentNo > 0}">
                                                <span class="reply_icon">↪</span>
                                            </c:if>
                                            ${comment.commentContent}
                                            <c:if test="${not empty comment.commentDeleteDate}">
                                                <span class="deleted_comment">(삭제됨)</span>
                                            </c:if>
                                        </a>
                                    </td>
                                    <td>
                                        <a href="detailBoard.do?boardNo=${comment.boardNo}" class="board_link">
                                            ${comment.boardNo}
                                        </a>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${comment.commentCreateDate}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td class="comment_actions">
                                        <c:if test="${empty comment.commentDeleteDate}">
                                            <button onclick="deleteComment(${comment.commentNo})" class="comment_delete_btn">삭제</button>
                                        </c:if>
                                        <c:if test="${not empty comment.commentDeleteDate}">
                                            <span class="already_deleted">삭제됨</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    
                    <!-- 페이징 처리 (있을 경우) -->
                    <c:if test="${!empty pagingInfo}">
                        <div class="mypage_pagination">
                            <c:if test="${pagingInfo.currentPage > 1}">
                                <a href="myComment.do?page=${pagingInfo.currentPage - 1}" class="page_btn prev">&lt;</a>
                            </c:if>
                            
                            <c:forEach var="i" begin="${pagingInfo.startPage}" end="${pagingInfo.endPage}">
                                <a href="myComment.do?page=${i}" class="page_btn ${pagingInfo.currentPage == i ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            
                            <c:if test="${pagingInfo.currentPage < pagingInfo.totalPages}">
                                <a href="myComment.do?page=${pagingInfo.currentPage + 1}" class="page_btn next">&gt;</a>
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
    padding: 1rem;
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

.mypage_menu_item:hover, .mypage_menu_item.active {
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

/* 댓글 컨테이너 */
.mypage_comment_container {
    display: flex;
    flex-direction: column;
    gap: 1.5rem;
    height: 100%;
    overflow-y: auto;
}

/* 댓글 테이블 */
.mypage_comment_table {
    width: 100%;
    border-collapse: collapse;
}

.mypage_comment_table th,
.mypage_comment_table td {
    padding: 0.875rem 1rem;
    text-align: left;
    border-bottom: 0.0625rem solid #3a3a3a;
}

.mypage_comment_table th {
    font-weight: bold;
    color: #f0f0f0;
    background-color: #2a2a2a;
}

.mypage_comment_table th:first-child,
.mypage_comment_table td:first-child {
    width: 4rem;
    text-align: center;
}

.mypage_comment_table th:nth-child(3),
.mypage_comment_table td:nth-child(3) {
    width: 6rem;
    text-align: center;
}

.mypage_comment_table th:nth-child(4),
.mypage_comment_table td:nth-child(4) {
    width: 8rem;
    text-align: center;
}

.mypage_comment_table th:last-child,
.mypage_comment_table td:last-child {
    width: 5rem;
    text-align: center;
}

.comment_cell {
    max-width: 25rem;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.comment_link {
    color: #f0f0f0;
    text-decoration: none;
    transition: color 0.2s ease;
    display: inline-block;
    max-width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.comment_link:hover {
    color: #4CAF50;
    text-decoration: underline;
}

.board_link {
    color: #f0f0f0;
    text-decoration: none;
    transition: color 0.2s ease;
}

.board_link:hover {
    color: #4CAF50;
    text-decoration: underline;
}

.reply_icon {
    display: inline-block;
    margin-right: 0.375rem;
    color: #4CAF50;
    font-weight: bold;
}

.deleted_comment {
    color: #999;
    font-style: italic;
    margin-left: 0.5rem;
}

.mypage_comment_table tbody tr:hover {
    background-color: #2a2a2a;
}

.mypage_empty_row td {
    text-align: center;
    color: #999;
    padding: 3rem 0;
}

/* 댓글 관리 버튼 */
.comment_delete_btn {
    padding: 0.375rem 0.625rem;
    border: none;
    border-radius: 0.25rem;
    background-color: #c62828;
    color: white;
    font-size: 0.75rem;
    cursor: pointer;
    transition: background-color 0.2s ease;
}

.comment_delete_btn:hover {
    background-color: #ef5350;
}

.already_deleted {
    color: #999;
    font-size: 0.75rem;
    font-style: italic;
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
    
    .mypage_comment_table {
        font-size: 0.875rem;
    }
    
    .mypage_comment_table th,
    .mypage_comment_table td {
        padding: 0.75rem 0.5rem;
    }
    
    .comment_cell {
        max-width: 10rem;
    }
    
    .mypage_comment_table th:nth-child(4),
    .mypage_comment_table td:nth-child(4) {
        display: none;
    }
}
</style>

<script>
    // 댓글 삭제 확인 함수
    function deleteComment(commentNo) {
        if(confirm('이 댓글을 삭제하시겠습니까?')) {
            // 서버로 삭제 요청
            location.href = 'deleteComment.do?commentNo=' + commentNo;
        }
    }
</script>