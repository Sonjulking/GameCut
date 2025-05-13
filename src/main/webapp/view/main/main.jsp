<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value="/css/video.css"/>">
<style>
    video::-webkit-media-controls-fullscreen-button {
        display: none !important;
    }
</style>
<div class="video_wrap"></div>

<script>
    const commentLists = document.querySelectorAll('.comment-list');

    commentLists.forEach((list) => {
        list.addEventListener('wheel', function (e) {
            const isScrollable = this.scrollHeight > this.clientHeight;
            const atTop = this.scrollTop === 0;
            const atBottom = this.scrollTop + this.clientHeight >= this.scrollHeight;

            if (
                    (e.deltaY < 0 && atTop) || // 위로 스크롤하려는데 이미 맨 위면
                    (e.deltaY > 0 && atBottom) // 아래로 스크롤하려는데 이미 맨 아래면
            ) {
                // 이벤트 전파 허용 → 부모 scroll-snap 작동
            } else {
                e.stopPropagation(); // 내부 스크롤만 처리
            }
        });
    });

    // 댓글창 토글
    /*    const commentButtons = document.querySelectorAll('.video_side_buttons_wrapper .video_side_buttons:nth-child(2)');

        commentButtons.forEach((btn, index) => {
            btn.addEventListener('click', () => {
                const wrappers = document.querySelectorAll('.main_comment_wrapper');
                const targetWrapper = wrappers[index];
                if (targetWrapper.style.display === 'none' || targetWrapper.style.display === '') {
                    targetWrapper.style.display = 'block';
                } else {
                    targetWrapper.style.display = 'none';
                }
            });
        });*/

    $(document).on("click", ".video_side_buttons_wrapper .video_side_buttons:nth-child(2)", function () {
        const index = $(".video_side_buttons_wrapper .video_side_buttons:nth-child(2)").index(this);
        const wrapper = $(".main_comment_wrapper").eq(index);
        wrapper.toggle(); // display toggle
    });


    // 스크롤 시 보이는 영상만 재생
    const videos = document.querySelectorAll(".video_player");

    videos.forEach(video => {
        video.addEventListener('loadedmetadata', function () {
            if (video.videoWidth > video.videoHeight) {
            } else {
                // 세로 영상
                video.classList.add('heightVideo');
            }
        });
    });
    /*
                $(window).on('wheel', function (event) {
                // deltaY > 0 이면 휠을 아래로 내림 (휠다운)
                // deltaY < 0 이면 휠을 위로 올림 (휠업)
                if (event.originalEvent.deltaY > 0) {
                    video.src = "/upload/videos/2025/05/test02.mp4"
                    console.log('휠 아래로 내림!');
                } else {
                    video.src = "/upload/videos/2025/05/test.mp4"
                    console.log('휠 위로 올림!');
                }
            });

        */


    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.play();
                entry.target.style.opacity = "1";
            } else {
                entry.target.pause();
                entry.target.style.opacity = "0.5";
            }
        });
    }, {threshold: 0.6});

    videos.forEach(video => {
        observer.observe(video);
    });
</script>
<script>
    let videoCount = 0; // 총 비디오 개수
    const maxVideos = 10;

    function loadBoard() {
        $.get("mainBoard.do", function (arr) {
            $.each(arr, function () {
                const board = this.board;
                const file = this.file;

                const boardTitle = board.boardTitle;
                const boardContent = board.boardContent;
                const userNickname = board.userNickname;
                const fileUrl = file.fileUrl;
                const comments = this.commentVOList;
                let commentHtml = '';
                comments.forEach(comment => {
                    commentHtml +=
                            '<div class="comment">' +
                            '<span class="nickname">' + comment.commentWriter + '</span> : ' +
                            comment.commentContent +
                            '<span class="comment_write_date">' + comment.commentCreateDate + '</span>' +
                            '</div>';
                });

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
                        commentHtml +
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

    // 스크롤 이벤트 등록
    $(".video_wrap").on("scroll", function () {
        const scrollTop = $(this).scrollTop();
        const scrollHeight = $(this)[0].scrollHeight;
        const clientHeight = $(this).innerHeight();

        if (scrollTop + clientHeight >= scrollHeight - 10) {
            loadBoard(); // 스크롤 끝에 도달하면 5개 추가
        }
    });
    // 최초 실행
    loadBoard();
</script>
