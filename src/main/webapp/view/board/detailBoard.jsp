<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${board.boardTitle}</title>
        <style>
            .board-container {
                background-color: #1e1e1e;
                padding: 2rem;
                border-radius: 12px;
                box-shadow: 0 0 10px rgba(255, 255, 255, 0.05);
                margin-bottom: 2rem;
                max-height: 500px; /* 원하는 높이로 설정 */
                overflow-y: auto; /* 세로 스크롤만 표시 */
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

            .heightVideo {
                height: 30rem;
            }

            .widthVideo {
                height: 30rem;
            }

            .video_player {
                display: block;
                margin: 1rem auto;
                border-radius: 10px;
                border: 1px solid #444;
            }
            /* 댓글 입력 영역 컴팩트하게 */
.comment-box textarea {
    width: 100%;
    background-color: #2a2a2a;
    border: 1px solid #444;
    color: #eee;
    padding: 0.8rem 1rem;
    border-radius: 8px;
    font-size: 14px;
    resize: vertical;
    height: 130px;
    max-height: 180px;
    box-sizing: border-box;
    line-height: 1.5;
}

/* 댓글 작성 버튼 */
.comment-box button[type="submit"] {
    background-color: #333;
    color: #f0f0f0;
    font-size: 13px;
    border: 1px solid #555;
    border-radius: 6px;
    padding: 6px 14px;
    margin-top: 0.5rem;
    cursor: pointer;
    transition: background 0.2s ease;
}

.comment-box button[type="submit"]:hover {
    background-color: #555;
}

/* 댓글 header */
.comment-header {
    display: flex;
    justify-content: space-between;
    font-size: 12.5px;
    color: #bbb;
    margin-bottom: 0.25rem;
}

.comment-writer {
    font-weight: 600;
    color: #ccc;
    font-size: 12.5px;
}

.comment-date {
    font-size: 12px;
    color: #888;
}

/* 댓글 본문 */
.comment-body {
    font-size: 14px;
    color: #e0e0e0;
    line-height: 1.5;
}

/* 전체 댓글 영역 */
.comment-box {
    background-color: #1e1e1e;
    color: white;
    padding: 1.2rem;
    margin: 2rem 0;
    border-radius: 1rem;
    width: 80%;
    box-shadow: 0 0 6px rgba(255, 255, 255, 0.05);
}

/* 댓글 한 개 */
.comment-item {
    border-bottom: 1px solid #333;
    padding: 1rem 0;
}
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body>
        <div class="board-container">
            <div class="board-title">${board.boardTitle}</div>
            <div class="board-meta">
                <span><strong>작성자:</strong> ${board.userNickname}</span>
                <span><strong>작성일:</strong> ${board.boardCreateDate}</span>
                <span><strong>조회수:</strong> ${board.boardCount}</span>
            </div>
            <div class="board-content">
                <c:if test="${not empty fileUrl}">
                    <video class="video_player" src="${fileUrl}" controls></video>
                </c:if>
                ${board.boardContent}
            </div>

            <div class="like-wrapper">
                <div class="like-btn" data-boardno="${board.boardNo}">
                    <span id="heart-icon">🤍</span>
                    <span id="like-count">${board.boardLike}</span>
                </div>
            </div>
            <br>
            <div class="button-group">
                <form action="selectAllBoards.do" method="get" style="display:inline;">
                    <input type="submit" value="목록으로"/>
                </form>

                <form action="reportBoardForm.do" method="get" style="display:inline;">
                    <input type="hidden" name="boardNo" value="${board.boardNo}"/>
                    <input type="hidden" name="targetUserNo" value="${board.userNo}"/>
                    <input type="submit" value="신고하기"/>
                </form>

                <c:if test="${sessionScope.loginUSER.userNo == board.userNo}">
                    <form action="updateBoardForm.do" method="get" style="display:inline;">
                        <input type="hidden" name="boardNo" value="${board.boardNo}"/>
                        <input type="submit" value="글 수정"/>
                    </form>

                    <form
                            action="deleteBoard.do" method="post" style="display:inline;"
                            onsubmit="return confirm('정말 삭제하시겠습니까?');"
                    >
                        <input type="hidden" name="boardNo" value="${board.boardNo}"/>
                        <input type="submit" value="삭제"/>
                    </form>
                </c:if>
            </div>

            <div id="commentSection" class="comment-box">
                <h3>댓글</h3>

                <!-- 로그인 시 댓글 작성 -->
                <c:if test="${not empty sessionScope.loginUSER}">
                    <form id="commentForm" onsubmit="return false;">
                        <input type="hidden" name="boardNo" value="${board.boardNo}">
                        <input type="hidden" name="parentCommentNo" value="0">
                        <textarea
                                name="commentContent" rows="3" placeholder="댓글을 입력하세요..."
                        ></textarea><br>
                        <button type="submit">댓글 작성</button>
                    </form>
                    <hr>
                </c:if>
                

                <!-- 비로그인 시 안내 -->
                <c:if test="${empty sessionScope.loginUSER}">
                    <p style="color: #ccc;">댓글을 작성하려면 <a
                            href="login.do" style="color: #f39c12;"
                    >로그인</a>하세요.</p>
                    <hr>
                </c:if>

                <!-- 댓글 리스트 -->
                <div id="commentList"></div>

                <!-- 페이징 영역 -->
                <div id="commentPagination" class="pagination"></div>
            </div>
        </div>
        <!-- ✅ 스크립트 -->
        <script>
            const boardNo = '${board.boardNo}';
            const loginUserNo = "${sessionScope.loginUSER.userNo}";
            console.log("boardNo  : " + boardNo);

            /*
            function loadComments() {
                $("#commentList").empty();  // 기존 댓글들 제거

                $.get("listParentComment.do?boardNo=" + boardNo, function(res) {
                    $.each(res, function(index, comment) {
                        // 서버에서 넘어오는 JSON 속성
                        const writer  = comment.commentWriter;      // 닉네임
                        const date    = comment.commentCreateDate;  // 작성일
                        const content = comment.commentContent;     // 본문
                        const no = comment.commentNo;
                        
						console.log(no);
						console.log(loginUserNo);
						
                        // 원하는 HTML 템플릿
                        let commentHtml = `
                            <div class="comment-item">
                                <div class="comment-header">
                                    <span class="comment-writer">`+writer+`</span>
                                    <span class="comment-date">`+ date +`</span>
                                </div>
                                <div class="comment-body">`+ content +`</div>
                                <div style="text-align:right;">
	                                <button class="deleteCommentBtn" no="${comment.commentNo}" style="background:#333; border:1px solid #666; color:#ccc; border-radius:5px; padding:4px 10px; cursor:pointer;">삭제</button>
	                            </div>
                            </div>
                        `;
                        $("#commentList").append(commentHtml);
                    });
                });
            }
            */
            
            function loadComments() {
                $("#commentList").empty();

                $.get("listParentComment.do?boardNo=" + boardNo, function(res) {
                    $.each(res, function(index, comment) {
                        const writer  = comment.commentWriter;
                        const date    = comment.commentCreateDate;
                        const content = comment.commentContent;
                        const no      = comment.commentNo;
                        const userNo  = comment.userNo; // 댓글 작성자 번호
                        
                        let commentHtml = `
                            <div class="comment-item">
                                <div class="comment-header" style="display:flex; justify-content:space-between;">
                                    <span class="comment-writer">` + writer + `</span>
                                    <span class="comment-date">` + date + `</span>
                                </div>
                                <div class="comment-body">` + content + `</div>
                        `;

                        // ✅ 댓글 작성자와 로그인 유저가 같을 때만 삭제 버튼 표시
                        if (loginUserNo && loginUserNo == userNo) {
                            commentHtml += `
                                <div style="text-align:right;">
                                    <button class="deleteCommentBtn" data-comment-no="` + no + `"
                                        style="background:#333; border:1px solid #666; color:#ccc; border-radius:5px; padding:4px 10px; cursor:pointer;">
                                        삭제
                                    </button>
                                </div>
                            `;
                        }

                        commentHtml += '</div>';
                        $("#commentList").append(commentHtml);
                    });
                });
            }

			
            loadComments();

            // 댓글 작성 버튼 클릭 시 AJAX로 서버에 전송
            $("#commentForm button[type='submit']").on("click", function () {
                const boardNo = $("input[name='boardNo']").val();
                const parentCommentNo = $("input[name='parentCommentNo']").val();
                const commentContent = $("textarea[name='commentContent']").val();

                if (commentContent.trim() === "") {
                    alert("댓글 내용을 입력해주세요.");
                    return;
                }

                $.post("insertComment.do", {
                    boardNo: boardNo,
                    parentCommentNo: parentCommentNo,
                    commentContent: commentContent
                }, function (result) {
                    if (result.trim() === "success") {
                        $("textarea[name='commentContent']").val(""); // 입력창 비움
                        $("#commentList").empty(); // 기존 댓글 비우고
                        loadComments(); // 다시 댓글 목록 불러오기
                    } else {
                        alert("댓글 작성 실패");
                    }
                }).fail(function () {
                    alert("서버 오류 발생");
                });
            });
            
            /*
            $(document).on("click", ".deleteCommentBtn", function () {
                const commentNo = $(this).data("comment-no");
				console.log(commentNo);
                 if (!confirm("정말 삭제하시겠습니까?")) return;

                $.post("deleteComment.do", { commentNo: commentNo }, function (result) {
                    if (result.trim() === "success") {
                        loadComments(); // 댓글 목록 갱신
                    } else {
                        alert("댓글 삭제 실패");
                    }
                }).fail(function () {
                    alert("서버 오류 발생");
                }); 
            });
            */
            
            $(document).on("click", ".deleteCommentBtn", function () {
                const commentNo = $(this).data("comment-no");
                if (!confirm("정말 삭제하시겠습니까?")) return;

                $.post("deleteComment.do", { commentNo: commentNo }, function (result) {
                    if (result.trim() === "success") {
                        loadComments(); // 목록 갱신
                    } else {
                        alert("댓글 삭제 실패");
                    }
                }).fail(function () {
                    alert("서버 오류 발생");
                });
            });

        </script>

        <script>
            // 스크롤 시 보이는 영상만 재생
            const videos = document.querySelectorAll(".video_player");

            videos.forEach(video => {
                video.addEventListener('loadedmetadata', function () {
                    if (video.videoWidth > video.videoHeight) {
                        // 세로 영상
                        video.classList.add('widthVideo');
                    } else {
                        // 세로 영상
                        video.classList.add('heightVideo');
                    }
                });
            });
        </script>
    </body>
</html>