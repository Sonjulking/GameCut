<jsp:useBean id="board" class="com.gamecut.vo.BoardVO" scope="request"/>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
            <h3>💬 댓글</h3>

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
                <p style="color: #ccc;">댓글을 작성하려면 <a href="login.do" style="color: #f39c12;">로그인</a>하세요.
                </p>
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
            console.log("boardNo  : " + boardNo);

            function loadComments() {
                $.get("listParentComment.do?boardNo=" + boardNo, function (res) {
                    $.each(res, function (index, comment) {
                        const commentContent = comment.commentContent;
                        const commentCreateDate = comment.commentCreateDate;
                        const commentNo = comment.commentNo;
                        const parentCommentNo = comment.parentCommentNo;
                        const userNo = comment.userNo;
                        console.log(comment);
                        console.log(commentContent);
                        let commentContainer = '<div>' + commentContent + '</div>';
                        $("#commentList").append(commentContainer);
                    });
                });
            }


            loadComments();
        </script>

        <div id="comment-container"></div>

        <script>
            function loadBoard() {
                $.get("mainBoard.do", function (arr) {
                    $.each(arr, function () {
                        const board = this.board;
                        const file = this.file;

                        const boardTitle = board.boardTitle;
                        const boardContent = board.boardContent;
                        const userNickname = board.userNickname;
                        const fileUrl = file.fileUrl;

                        let videoContainer =
                                '<div class="main_content_div video_container">' +
                                '<div class="video_wrapper">' +
                                '<video class="video_player" controls muted loop playsinline>' +
                                '<source src="' + fileUrl + '" type="video/mp4">' +
                                '브라우저가 비디오 태그를 지원하지 않습니다.' +
                                '</video>' +
                                '<div class="video_texts">' +
                                '<div class="video_title"> ' + userNickname + '</div>' +
                                '<div class="video_title"> 제목 : ' + boardTitle + '</div>' +
                                '<div class="video_content">내용 : ' + boardContent + '</div>' +
                                '</div>' +
                                '</div>' +
                                '<div class="video_side_buttons_wrapper">' +
                                '<img src="img/main/icons/like_icon.png" class="video_side_buttons" alt="">' +
                                '<img src="img/main/icons/comment_icon.png" class="video_side_buttons" alt="">' +
                                '<img src="img/main/icons/share_icon.png" class="video_side_buttons" alt="">' +
                                '<img src="img/main/icons/save_icon.png" class="video_side_buttons" alt="">' +
                                '<img src="img/main/icons/report_icon.png" class="video_side_buttons" alt="">' +
                                '</div>' +
                                '<div class="main_comment_wrapper comment-box">' +
                                '<div class="comment-title">댓글</div>' +
                                '<hr>' +
                                '<div class="comment-list">' +
                                '<div class="comment"><span class="nickname">우진</span> : 와 대박 미쳤다. <span class="comment_write_date">2025-05-19</span></div>' +
                                '</div>' +
                                '<div class="comment-input">' +
                                '<input type="text" placeholder="댓글쓰기"/>' +
                                '<button>↑</button>' +
                                '</div>' +
                                '</div>' +
                                '</div>';

                        $(".video_wrap").append(videoContainer);
                        videoCount++;

                        // 10개 초과 시 위에서부터 제거
                        if (videoCount > maxVideos) {
                            $(".video_wrap .video_container").first().remove();
                            videoCount--;
                        }
                    });

                    // IntersectionObserver 다시 적용
                    $(".video_player").each(function () {
                        observer.observe(this);
                    });
                });
            }
        </script>

    </body>
</html>