 <%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${board.boardTitle}</title>
    <style>
        body {
            background-color: #121212;
            color: #f0f0f0;
            font-family: 'Arial', sans-serif;
            padding: 40px;
        }

        h2 {
            color: #ffffff;
            border-bottom: 1px solid #333;
            padding-bottom: 10px;
        }

        p {
            margin: 10px 0;
            line-height: 1.6;
        }

        strong {
            color: #bbbbbb;
        }

        a {
            color: #4ea6ff;
            text-decoration: none;
            margin-right: 10px;
        }

        a:hover {
            text-decoration: underline;
        }

        .like-btn {
            cursor: pointer;
            font-size: 24px;
            user-select: none;
            display: inline-block;
            margin-top: 10px;
        }

        form {
            display: inline;
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

        hr {
            border: 0;
            height: 1px;
            background-color: #333;
            margin: 20px 0;
        }

        .button-group {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <h2>${board.boardTitle}</h2>
    <p><strong>내용:</strong> ${board.boardContent}</p>
    <p><strong>작성자:</strong> ${board.userNickname}</p>
    <p><strong>작성일:</strong> ${board.boardCreateDate}</p>
    <p><strong>조회수:</strong> ${board.boardCount}</p>

    <hr>

    <c:if test="${not empty sessionScope.loginUSER}">
        <div class="like-btn" data-boardno="${board.boardNo}">
            <span id="heart-icon">
                <c:choose>
                    <c:when test="${board.likedByCurrentUser}">🖤</c:when>
                    <c:otherwise>♡</c:otherwise>
                </c:choose>
            </span>
            <span id="like-count">${board.boardLike}</span>
        </div>
    </c:if>

    <c:if test="${empty sessionScope.loginUSER}">
        <p>로그인한 사용자만 좋아요를 누를 수 있어요.</p>
    </c:if>

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


    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const likeBtn = document.querySelector(".like-btn");
            if (!likeBtn) return;

            const heart = document.getElementById("heart-icon");
            const count = document.getElementById("like-count");
            const boardNo = likeBtn.dataset.boardno;

            likeBtn.addEventListener("click", function () {
                fetch("likeBoard.do", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: "boardNo=" + boardNo
                })
                .then(res => res.json())
                .then(data => {
                    if (data.status === "liked") {
                        heart.innerText = "🖤";
                    } else if (data.status === "unliked") {
                        heart.innerText = "♡";
                    } else if (data.status === "error") {
                        alert(data.message);
                    }
                    count.innerText = data.likeCount;
                })
                .catch(err => console.error("좋아요 오류:", err));
            });
        });
    </script>

</body>
</html>
--%>

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
    </style>
</head>
<body>

    <h2>${board.boardTitle}</h2>
    <p><strong>내용:</strong> ${board.boardContent}</p>
    <p><strong>작성자:</strong> ${board.userNo}</p>
    <p><strong>작성일:</strong> ${board.boardCreateDate}</p>
    <p><strong>조회수:</strong> ${board.boardCount}</p>

    <hr>

    <!-- ✅ 좋아요 버튼 -->
    <div class="like-btn" data-boardno="${board.boardNo}">
        <span id="heart-icon">♡</span>
        <span id="like-count">${board.boardLike}</span>
    </div>

    <br>

    <!-- ✅ 신고 버튼 -->
    <a href="reportBoardForm.do?boardNo=${board.boardNo}&targetUserNo=${board.userNo}">신고하기</a>

    <hr>

    <!-- ✅ 댓글 영역 -->
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
                heart.innerText = liked ? "🖤" : "♡";

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
