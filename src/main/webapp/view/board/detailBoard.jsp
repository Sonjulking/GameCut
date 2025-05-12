<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${board.boardTitle}</title>
    <style>
        .like-btn {
            cursor: pointer;
            font-size: 24px;
            user-select: none;
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

    <!-- ✅ 좋아요 버튼 (로그인 여부 관계없이 사용 가능) -->
    <div class="like-btn" data-boardno="${board.boardNo}">
        <span id="heart-icon">♡</span>
        <span id="like-count">${board.boardLike}</span>
    </div>

    <br><br>

    <!-- 신고 버튼 (원하는 경우에만 로그인 체크) -->
    <a href="reportBoardForm.do?boardNo=${board.boardNo}&targetUserNo=${board.userNo}">신고하기</a>

    <!-- 좋아요 AJAX 스크립트 -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const likeBtn = document.querySelector(".like-btn");
            const heart = document.getElementById("heart-icon");
            const count = document.getElementById("like-count");
            const boardNo = likeBtn.dataset.boardno;

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
                })
                .catch(err => console.error("좋아요 AJAX 오류", err));
            });
        });
    </script>

</body>
</html>

