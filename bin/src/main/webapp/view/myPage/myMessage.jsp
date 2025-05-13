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
                    <a href="myMessage.do" class="mypage_menu_item active">내 쪽지</a>
                    <a href="myBoard.do" class="mypage_menu_item">내 게시글</a>
                    <a href="myComment.do" class="mypage_menu_item">내 댓글</a>
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
                <h2 class="mypage_section_title">내 쪽지함</h2>
                
                <!-- 쪽지 관리 버튼 -->
                <div class="mypage_message_buttons">
                    <button id="newMessageBtn" class="mypage_message_btn">새 쪽지 작성</button>
                    <button id="deleteSelectedBtn" class="mypage_message_btn delete">선택 삭제</button>
                </div>
                
                <!-- 탭 버튼 -->
                <div class="mypage_tabs">
                    <button class="mypage_tab_btn active" data-tab="received">받은 쪽지</button>
                    <button class="mypage_tab_btn" data-tab="sent">보낸 쪽지</button>
                </div>
                
                <!-- 받은 쪽지 탭 내용 -->
                <div class="mypage_tab_content active" id="received_tab">
                    <div class="mypage_message_container">
                        <!-- 쪽지 목록 테이블 -->
                        <table class="mypage_message_table">
                            <thead>
                                <tr>
                                    <th class="checkbox_cell">
                                        <input type="checkbox" id="selectAllReceived" class="mypage_checkbox">
                                    </th>
                                    <th>보낸 사람</th>
                                    <th>제목</th>
                                    <th>날짜</th>
                                    <th>읽음</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty receivedMessages}">
                                    <tr class="mypage_empty_row">
                                        <td colspan="5">받은 쪽지가 없습니다.</td>
                                    </tr>
                                </c:if>
                                
                                <c:forEach var="message" items="${receivedMessages}">
                                    <tr class="${message.isRead ? '' : 'unread'}" onclick="viewMessage(${message.messageNo}, 'received')">
                                        <td class="checkbox_cell" onclick="event.stopPropagation()">
                                            <input type="checkbox" name="selectedMessages" value="${message.messageNo}" class="mypage_checkbox">
                                        </td>
                                        <td>${message.senderNickname}</td>
                                        <td class="message_title">${message.messageTitle}</td>
                                        <td><fmt:formatDate value="${message.messageDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <span class="read_status ${message.isRead ? 'read' : 'unread'}">
                                                ${message.isRead ? '읽음' : '안읽음'}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <!-- 페이징 처리 (있을 경우) -->
                        <c:if test="${!empty receivedPagingInfo}">
                            <div class="mypage_pagination">
                                <c:if test="${receivedPagingInfo.currentPage > 1}">
                                    <a href="myMessage.do?rPage=${receivedPagingInfo.currentPage - 1}" class="page_btn prev">&lt;</a>
                                </c:if>
                                
                                <c:forEach var="i" begin="${receivedPagingInfo.startPage}" end="${receivedPagingInfo.endPage}">
                                    <a href="myMessage.do?rPage=${i}" class="page_btn ${receivedPagingInfo.currentPage == i ? 'active' : ''}">${i}</a>
                                </c:forEach>
                                
                                <c:if test="${receivedPagingInfo.currentPage < receivedPagingInfo.totalPages}">
                                    <a href="myMessage.do?rPage=${receivedPagingInfo.currentPage + 1}" class="page_btn next">&gt;</a>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </div>
                
                <!-- 보낸 쪽지 탭 내용 -->
                <div class="mypage_tab_content" id="sent_tab">
                    <div class="mypage_message_container">
                        <!-- 쪽지 목록 테이블 -->
                        <table class="mypage_message_table">
                            <thead>
                                <tr>
                                    <th class="checkbox_cell">
                                        <input type="checkbox" id="selectAllSent" class="mypage_checkbox">
                                    </th>
                                    <th>받는 사람</th>
                                    <th>제목</th>
                                    <th>날짜</th>
                                    <th>읽음</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty sentMessages}">
                                    <tr class="mypage_empty_row">
                                        <td colspan="5">보낸 쪽지가 없습니다.</td>
                                    </tr>
                                </c:if>
                                
                                <c:forEach var="message" items="${sentMessages}">
                                    <tr onclick="viewMessage(${message.messageNo}, 'sent')">
                                        <td class="checkbox_cell" onclick="event.stopPropagation()">
                                            <input type="checkbox" name="selectedMessages" value="${message.messageNo}" class="mypage_checkbox">
                                        </td>
                                        <td>${message.receiverNickname}</td>
                                        <td class="message_title">${message.messageTitle}</td>
                                        <td><fmt:formatDate value="${message.messageDate}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <span class="read_status ${message.isRead ? 'read' : 'unread'}">
                                                ${message.isRead ? '읽음' : '안읽음'}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        
                        <!-- 페이징 처리 (있을 경우) -->
                        <c:if test="${!empty sentPagingInfo}">
                            <div class="mypage_pagination">
                                <c:if test="${sentPagingInfo.currentPage > 1}">
                                    <a href="myMessage.do?sPage=${sentPagingInfo.currentPage - 1}" class="page_btn prev">&lt;</a>
                                </c:if>
                                
                                <c:forEach var="i" begin="${sentPagingInfo.startPage}" end="${sentPagingInfo.endPage}">
                                    <a href="myMessage.do?sPage=${i}" class="page_btn ${sentPagingInfo.currentPage == i ? 'active' : ''}">${i}</a>
                                </c:forEach>
                                
                                <c:if test="${sentPagingInfo.currentPage < sentPagingInfo.totalPages}">
                                    <a href="myMessage.do?sPage=${sentPagingInfo.currentPage + 1}" class="page_btn next">&gt;</a>
                                </c:if>
                            </div>
                        </c:if>
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
        padding: 1rem;
        margin-bottom: 5rem; /* 푸터를 위한 여백 추가 */
    }

    .main_content {
        background-color: #1a1a1a;
        border-radius: 0.75rem;
        box-shadow: 0 0.25rem 0.375rem rgba(0, 0, 0, 0.3);
        padding: 1rem;
        margin-bottom: 2rem; /* 푸터와의 간격 */
    }
    
    /* 컨텐츠 래퍼 - 사이드바와 내 정보 섹션을 감싸는 컨테이너 */
    .content_wrapper {
        display: flex;
        gap: 2rem;
        align-items: flex-start;
        min-height: calc(100vh - 15rem); /* 푸터 공간 고려 */
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
        margin-bottom: 2rem; /* 푸터를 위한 추가 여백 */
    }

    .mypage_section_title {
        font-size: 1.5rem;
        color: #f0f0f0;
        margin: 0;
        padding-bottom: 1rem;
        border-bottom: 0.0625rem solid #3a3a3a;
    }

    /* 쪽지 관리 버튼 */
    .mypage_message_buttons {
        display: flex;
        gap: 1rem;
        justify-content: flex-end;
    }

    .mypage_message_btn {
        padding: 0.625rem 1rem;
        border: none;
        border-radius: 0.375rem;
        background-color: #3a3a3a;
        color: white;
        font-size: 0.875rem;
        cursor: pointer;
        transition: background-color 0.2s ease;
    }

    .mypage_message_btn:hover {
        background-color: #4CAF50;
    }

    .mypage_message_btn.delete {
        background-color: #c62828;
    }

    .mypage_message_btn.delete:hover {
        background-color: #ef5350;
    }

    /* 탭 버튼 */
    .mypage_tabs {
        display: flex;
        gap: 0.5rem;
        margin-bottom: 1rem;
        border-bottom: 0.0625rem solid #3a3a3a;
        padding-bottom: 0.5rem;
    }

    .mypage_tab_btn {
        padding: 0.625rem 1.25rem;
        border: none;
        background-color: transparent;
        color: #ccc;
        cursor: pointer;
        font-size: 1rem;
        border-radius: 0.375rem 0.375rem 0 0;
        transition: all 0.2s ease;
    }

    .mypage_tab_btn:hover {
        color: white;
        background-color: #3a3a3a;
    }

    .mypage_tab_btn.active {
        color: white;
        background-color: #3a3a3a;
        border-bottom: 0.1875rem solid #4CAF50;
    }

    /* 탭 내용 */
    .mypage_tab_content {
        display: none;
    }

    .mypage_tab_content.active {
        display: block;
    }

    /* 쪽지 컨테이너 */
    .mypage_message_container {
        background-color: #1f1f1f;
        border-radius: 0.75rem;
        padding: 1.5rem;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        gap: 1.5rem;
    }

    /* 쪽지 테이블 */
    .mypage_message_table {
        width: 100%;
        border-collapse: collapse;
    }

    .mypage_message_table th,
    .mypage_message_table td {
        padding: 0.875rem 1rem;
        text-align: left;
        border-bottom: 0.0625rem solid #3a3a3a;
    }

    .mypage_message_table th {
        font-weight: bold;
        color: #f0f0f0;
        background-color: #2a2a2a;
    }

    .mypage_message_table tr {
        cursor: pointer;
        transition: background-color 0.2s ease;
    }

    .mypage_message_table tr:hover {
        background-color: #2a2a2a;
    }

    .mypage_message_table tr.unread {
        font-weight: bold;
        background-color: rgba(76, 175, 80, 0.05);
    }

    .mypage_message_table tr.unread:hover {
        background-color: rgba(76, 175, 80, 0.1);
    }

    .mypage_message_table .checkbox_cell {
        width: 2.5rem;
        text-align: center;
    }

    .mypage_message_table th:nth-child(2),
    .mypage_message_table td:nth-child(2) {
        width: 8rem;
    }

    .mypage_message_table th:nth-child(4),
    .mypage_message_table td:nth-child(4) {
        width: 7rem;
        text-align: center;
    }

    .mypage_message_table th:nth-child(5),
    .mypage_message_table td:nth-child(5) {
        width: 5rem;
        text-align: center;
    }

    .message_title {
        max-width: 20rem;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    /* 읽음 상태 */
    .read_status {
        display: inline-block;
        padding: 0.25rem 0.5rem;
        border-radius: 1rem;
        font-size: 0.75rem;
        font-weight: normal;
    }

    .read_status.read {
        background-color: #3a3a3a;
        color: #aaa;
    }

    .read_status.unread {
        background-color: rgba(76, 175, 80, 0.2);
        color: #4CAF50;
    }

    /* 체크박스 스타일 */
    .mypage_checkbox {
        width: 1rem;
        height: 1rem;
        cursor: pointer;
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
        }
        
        .mypage_message_table th:nth-child(4),
        .mypage_message_table td:nth-child(4) {
            display: none;
        }
        
        .message_title {
            max-width: 10rem;
        }
    }
</style>

<script>
    // 탭 전환 기능
    document.addEventListener('DOMContentLoaded', function() {
        const tabButtons = document.querySelectorAll('.mypage_tab_btn');
        const tabContents = document.querySelectorAll('.mypage_tab_content');
        
        tabButtons.forEach(button => {
            button.addEventListener('click', function() {
                // 모든 탭 버튼에서 active 클래스 제거
                tabButtons.forEach(btn => btn.classList.remove('active'));
                // 클릭한 버튼에 active 클래스 추가
                this.classList.add('active');
                
                // 모든 탭 내용 숨기기
                tabContents.forEach(content => content.classList.remove('active'));
                // 클릭한 버튼에 해당하는 탭 내용 표시
                const tabId = this.getAttribute('data-tab') + '_tab';
                document.getElementById(tabId).classList.add('active');
            });
        });
        
        // 전체 선택 체크박스 기능
        const selectAllReceived = document.getElementById('selectAllReceived');
        const selectAllSent = document.getElementById('selectAllSent');
        
        if(selectAllReceived) {
            selectAllReceived.addEventListener('change', function() {
                const checkboxes = document.querySelectorAll('#received_tab input[name="selectedMessages"]');
                checkboxes.forEach(checkbox => {
                    checkbox.checked = this.checked;
                });
            });
        }
        
        if(selectAllSent) {
            selectAllSent.addEventListener('change', function() {
                const checkboxes = document.querySelectorAll('#sent_tab input[name="selectedMessages"]');
                checkboxes.forEach(checkbox => {
                    checkbox.checked = this.checked;
                });
            });
        }
        
        // 선택 삭제 버튼 이벤트
        const deleteSelectedBtn = document.getElementById('deleteSelectedBtn');
        if(deleteSelectedBtn) {
            deleteSelectedBtn.addEventListener('click', function() {
                const activeTab = document.querySelector('.mypage_tab_content.active');
                const selectedMessages = activeTab.querySelectorAll('input[name="selectedMessages"]:checked');
                
                if(selectedMessages.length === 0) {
                    alert('삭제할 쪽지를 선택해주세요.');
                    return;
                }
                
                if(confirm('선택한 쪽지를 삭제하시겠습니까?')) {
                    // 삭제 처리 로직
                    const messageIds = Array.from(selectedMessages).map(el => el.value).join(',');
                    const messageType = activeTab.id === 'received_tab' ? 'received' : 'sent';
                    
                    // 서버로 삭제 요청
                    location.href = 'deleteMessages.do?ids=' + messageIds + '&type=' + messageType;
                }
            });
        }
    });
    
    // 쪽지 상세 보기 함수
    function viewMessage(messageNo, type) {
        location.href = 'viewMessage.do?messageNo=' + messageNo + '&type=' + type;
    }
</script>