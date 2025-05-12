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
    function loadBoard() {
        $.get("mainBoard.do", function (arr) {
            $(".test_div").empty(); // 기존 내용 비우기

            $.each(arr, function () {
                const board = this.board;
                const file = this.file;

                const title = board.boardTitle;
                const content = board.boardContent;
                const date = board.boardCreateDate;
                const fileUrl = file.fileUrl; // 예: "2025/05/test01.mp4"
                console.log(arr);
                console.log(title);
                console.log(content);
                console.log(fileUrl);

                let videoContainer =
                        '<div class="main_content_div video_container">' +
                        '<video class="video_player" controls muted loop playsinline>' +
                        '<source src="' + fileUrl + '" type="video/mp4">' +
                        '브라우저가 비디오 태그를 지원하지 않습니다.' +
                        '</video>' +
                        '<div class="video_side_buttons_wrapper">' +
                        '<img src="/img/main/icons/like_icon.png" class="video_side_buttons" alt="">' +
                        '<img src="/img/main/icons/comment_icon.png" class="video_side_buttons" alt="">' +
                        '<img src="/img/main/icons/share_icon.png" class="video_side_buttons" alt="">' +
                        '<img src="/img/main/icons/save_icon.png" class="video_side_buttons" alt="">' +
                        '<img src="/img/main/icons/report_icon.png" class="video_side_buttons" alt="">' +
                        '</div>' +
                        '<div class="main_comment_wrapper comment-box">' +
                        '<div class="comment-title">댓글</div>' +
                        '<hr>' +
                        '<div class="comment-list">' +
                        '<div class="comment"><span class="nickname">우진(아이디)</span> : 와 대박 미쳤다... <span class="comment_write_date">2025-05-19</span></div>' +
                        '</div>' +
                        '<div class="comment-input">' +
                        '<input type="text" placeholder="댓글쓰기"/>' +
                        '<button>↑</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>';

                $(".video_wrap").append(videoContainer);
                $(".video_player").each(function () {
                    observer.observe(this);
                });
            });
        });

    }

    loadBoard();

</script>
