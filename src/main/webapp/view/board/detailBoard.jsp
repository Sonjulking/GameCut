
<jsp:useBean id="board" class="com.gamecut.vo.BoardVO" scope="request" />
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

input[type="submit"]:hover {
    background-color: #555;
}
    </style>
</head>
<body>

    <h2>${board.boardTitle}</h2>
    <p><strong>내용:</strong> ${board.boardContent}</p>
    <p><strong>작성자:</strong> ${board.userNo}</p>
    <p><strong>작성일:</strong> ${board.boardCreateDate}</p>
    <p><strong>조회수:</strong> ${board.boardCount}</p>

    <hr>

    <div class="like-btn" data-boardno="${board.boardNo}">
        <span id="heart-icon">🤍</span>
        <span id="like-count">${board.boardLike}</span>
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
    fetch("listParentComment.do?boardNo=" + boardNo)
        .then(res => res.json())
        .then(data => {
            const listArea = document.getElementById("commentList");
            listArea.innerHTML = "";

            data.forEach(comment => {
                const commentHtml = `
                    <div class='comment-item'>
                        <strong>작성자:</strong> 사용자번호 ${comment.userNo}<br>
                        <p>${comment.commentContent}</p>
                        <button onclick="updateComment(${comment.commentNo})">수정</button>
                        <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                    </div>
                `;
                listArea.innerHTML += commentHtml;
            });

            document.getElementById("commentPagination").innerHTML = ""; // 현재 페이징 없음
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    const boardNo = ${board.boardNo};

    // 부모 댓글 불러오기
    $.ajax({
        url: "listParentComment.do",
        data: { boardNo: boardNo },
        success: function (comments) {
            $("#comment-container").empty();
            comments.forEach(comment => {
                let html = `
                    <div class="comment">
                        <p><strong>익명</strong> | ${comment.commentCreateDate}</p>
                        <p>${comment.commentContent}</p>
                        <div class="reply-container" id="replies-${comment.commentNo}"></div>
                        <button onclick="loadReplies(${comment.commentNo})">답글 보기</button>
                    </div>
                    <hr>
                `;
                $("#comment-container").append(html);
            });
        }
    });
});

// 대댓글 불러오기
function loadReplies(parentCommentNo) {
    $.ajax({
        url: "listReply.do",
        data: { parentCommentNo: parentCommentNo },
        success: function (replies) {
            const replyBox = $(`#replies-${parentCommentNo}`);
            replyBox.empty();
            replies.forEach(reply => {
                const html = `
                    <div class="reply" style="margin-left: 2rem;">
                        <p><strong>익명</strong> | ${reply.commentCreateDate}</p>
                        <p>${reply.commentContent}</p>
                    </div>
                `;
                replyBox.append(html);
            });
        }
    });
}
</script>

<div id="comment-container"></div>
    

</body>
</html>