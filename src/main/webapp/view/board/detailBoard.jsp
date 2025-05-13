

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${board.boardTitle}</title>
    <style>
        body {
            background-color: #121212;
            color: white;
            font-family: Arial, sans-serif;
            padding: 2rem;
        }
        
        .board-container {
    background-color: #1e1e1e;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(255,255,255,0.05);
    margin-bottom: 2rem;
}

.board-title {
    font-size: 28px;
    font-weight: bold;
    color: #f39c12;
    margin-bottom: 1rem;
}

.board-meta {
    font-size: 14px;
    color: #aaa;
    display: flex;
    gap: 1.5rem;
    margin-bottom: 1rem;
}

.board-content {
    font-size: 16px;
    line-height: 1.7;
    color: #e0e0e0;
    white-space: pre-wrap;
    margin-top: 1.5rem;
    border-top: 1px solid #333;
    padding-top: 1rem;
}

.button-group {
    margin-top: 1rem;
}

.button-group form {
    display: inline-block;
    margin-right: 10px;
}
        .like-btn {
            cursor: pointer;
            font-size: 24px;
            user-select: none;
        }
        .comment-box {
            background-color: #1e1e1e;
            color: white;
            padding: 1rem;
            margin: 2rem 0;
            border-radius: 1rem;
            width: 80%;
        }
        .comment-item {
            border-bottom: 1px solid #444;
            padding: 1rem 0;
        }
        .pagination a {
            margin: 0 5px;
            color: #aaa;
            text-decoration: none;
        }
        .pagination a.active {
            color: #f39c12;
            font-weight: bold;
        }
        textarea {
            width: 100%;
            resize: vertical;
        }
        
        input[type="submit"] {
    background-color: #333;
    color: #f0f0f0;
    border: 1px solid #555;
    padding: 5px 12px;
    border-radius: 6px;
    cursor: pointer;
    margin-left: 5px;
}

.like-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 1rem 0 0 0; 
}

.like-btn {
    cursor: pointer;
    font-size: 26px;
    user-select: none;
    display: flex;
    align-items: center;
    gap: 10px;
}

.button-group {
    display: flex;
    justify-content: flex-end; /* ✅ 오른쪽 정렬 */
    gap: 10px;
    margin-top: 1rem;
    flex-wrap: wrap;
}

.button-group form {
    display: inline-block;
}


input[type="submit"]:hover {
    background-color: #555;
}
    </style>
</head>
<body>

    <div class="board-container">
    <div class="board-title">${board.boardTitle}</div>
    <div class="board-meta">
        <span><strong>작성자:</strong> ${board.userNickname}</span>
        <span><strong>작성일:</strong> ${board.boardCreateDate}</span>
        <span><strong>조회수:</strong> ${board.boardCount}</span>
    </div>
    <div class="board-content">${board.boardContent}</div>
    
    <div class="like-wrapper">
    <div class="like-btn" data-boardno="${board.boardNo}">
        <span id="heart-icon">🤍</span>
        <span id="like-count">${board.boardLike}</span>
    </div>
</div>
</div>
    <br>
    <div class="button-group">
    <form action="selectAllBoards.do" method="get" style="display:inline;">
        <input type="submit" value="목록으로" />
    </form>

    <form action="reportBoardForm.do" method="get" style="display:inline;">
        <input type="hidden" name="boardNo" value="${board.boardNo}" />
        <input type="hidden" name="targetUserNo" value="${board.userNo}" />
        <input type="submit" value="신고하기" />
    </form>

    <c:if test="${sessionScope.loginUSER.userNo == board.userNo}">
        <form action="updateBoardForm.do" method="get" style="display:inline;">
            <input type="hidden" name="boardNo" value="${board.boardNo}" />
            <input type="submit" value="글 수정" />
        </form>

        <form action="deleteBoard.do" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
            <input type="hidden" name="boardNo" value="${board.boardNo}" />
            <input type="submit" value="삭제" />
        </form>
    </c:if>
</div>

    <div id="commentSection" class="comment-box">
        <h3>💬 댓글</h3>

        <!-- 로그인 시 댓글 작성 -->
        <c:if test="${not empty sessionScope.loginUSER}">
            <form id="commentForm" onsubmit="return false;">
                <input type="hidden" name="boardNo" value="${board.boardNo}">
                <input type="hidden" name="parentCommentNo" value="0">
                <textarea name="commentContent" rows="3" placeholder="댓글을 입력하세요..."></textarea><br>
                <button type="submit">댓글 작성</button>
            </form>
            <hr>
        </c:if>

        <!-- 비로그인 시 안내 -->
        <c:if test="${empty sessionScope.loginUSER}">
            <p style="color: #ccc;">댓글을 작성하려면 <a href="login.do" style="color: #f39c12;">로그인</a>하세요.</p>
            <hr>
        </c:if>

        <!-- 댓글 리스트 -->
        <div id="commentList"></div>

        <!-- 페이징 영역 -->
        <div id="commentPagination" class="pagination"></div>
    </div>

    <!-- ✅ 스크립트 -->
    <script>
        const boardNo = '${board.boardNo}';

        // 댓글 불러오기
        function loadComments(page) {
            fetch("ajaxCommentList.do?boardNo=" + boardNo + "&page=" + page)
                .then(res => res.json())
                .then(data => {
                    document.getElementById("commentList").innerHTML = data.commentsHtml;
                    document.getElementById("commentPagination").innerHTML = data.paginationHtml;
                });
        }

        // 댓글 작성
        document.addEventListener("DOMContentLoaded", function () {
            loadComments(1);

            const likeBtn = document.querySelector(".like-btn");
            const heart = document.getElementById("heart-icon");
            const count = document.getElementById("like-count");

            let liked = false;
            likeBtn.addEventListener("click", function () {
                liked = !liked;
                heart.innerText = liked ? "🖤" : "🤍";

                fetch("likeBoard.do", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "boardNo=" + boardNo + "&status=" + (liked ? "liked" : "unliked")
                })
                .then(res => res.json())
                .then(data => {
                    count.innerText = data.likeCount;
                });
            });

            const form = document.getElementById("commentForm");
            if (form) {
                form.addEventListener("submit", function () {
                    const content = form.commentContent.value.trim();
                    if (content === "") {
                        alert("댓글 내용을 입력하세요.");
                        return;
                    }

                    const params = new URLSearchParams();
                    params.append("boardNo", form.boardNo.value);
                    params.append("parentCommentNo", form.parentCommentNo.value);
                    params.append("commentContent", content);

                    fetch("insertComment.do", {
                        method: "POST",
                        headers: { "Content-Type": "application/x-www-form-urlencoded" },
                        body: params.toString()
                    })
                    .then(res => res.text())
                    .then(result => {
                        if (result === "success") {
                            form.commentContent.value = "";
                            loadComments(1);
                        }
                    });
                });
            }
        });

        // 댓글 수정
        function updateComment(commentNo) {
            const content = prompt("댓글을 수정하세요:");
            if (!content) return;

            fetch("updateComment.do", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "commentNo=" + commentNo + "&commentContent=" + encodeURIComponent(content)
            })
            .then(res => res.text())
            .then(() => loadComments(1));
        }

        // 댓글 삭제
        function deleteComment(commentNo) {
            if (!confirm("정말 삭제하시겠습니까?")) return;

            fetch("deleteComment.do", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "commentNo=" + commentNo
            })
            .then(res => res.text())
            .then(() => loadComments(1));
        }
    </script>

</body>
</html>
