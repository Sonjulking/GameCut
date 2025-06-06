<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="<c:url value="/css/video.css"/>">
<style>
    video::-webkit-media-controls-fullscreen-button {
        display: none !important;
    }
</style>
<div class="main_content_div video_container">
    <video class="video_player" controls muted loop playsinline>
        <source src="<c:url value="/upload/videos/2025/05/test01.mp4"/>" type="video/mp4">
        브라우저가 비디오 태그를 지원하지 않습니다.
    </video>
    <div class="video_side_buttons_wrapper">
        <img src="<c:url value="/img/main/icons/like_icon.png"/>" class="video_side_buttons" alt="">
        <img
                src="<c:url value="/img/main/icons/comment_icon.png"/>" class="video_side_buttons"
                alt=""
        >
        <img
                src="<c:url value="/img/main/icons/share_icon.png"/>" class="video_side_buttons"
                alt=""
        >
        <img src="<c:url value="/img/main/icons/save_icon.png"/>" class="video_side_buttons" alt="">
        <img
                src="<c:url value="/img/main/icons/report_icon.png"/>" class="video_side_buttons"
                alt=""
        >
    </div>
    <div class="main_comment_wrapper comment-box">
        <div class="comment-title">댓글</div>
        <hr>
        <div class="comment-list">
            <div class="comment"><span class="nickname">희재</span> :우진님이 내꺼도와줌 <span
                    class="comment_write_date"
            >2025-05-19</span>
            <span class="nickname">강찬</span> :우진님은 이제 누워서 쉬세요^^ <span
                    class="comment_write_date"
            >2025-05-19</span>
            </div>
        </div>
        <div class="comment-input">
            <input type="text" placeholder="댓글쓰기"/>
            <button>↑</button>
        </div>
    </div>
</div>
<div class=" video_container">
    <video class="video_player" controls muted loop playsinline>
        <source src="<c:url value="/upload/videos/2025/05/test02.mp4"/>" type="video/mp4">
        브라우저가 비디오 태그를 지원하지 않습니다.
    </video>
    <div class="video_side_buttons_wrapper">
        <img src="<c:url value="/img/main/icons/like_icon.png"/>" class="video_side_buttons" alt="">
        <img
                src="<c:url value="/img/main/icons/comment_icon.png"/>" class="video_side_buttons"
                alt=""
        >
        <img
                src="<c:url value="/img/main/icons/share_icon.png"/>" class="video_side_buttons"
                alt=""
        >
        <img src="<c:url value="/img/main/icons/save_icon.png"/>" class="video_side_buttons" alt="">
        <img
                src="<c:url value="/img/main/icons/report_icon.png"/>" class="video_side_buttons"
                alt=""
        >
    </div>
    <!-- <div class="main_comment_wrapper">
        <div>우진님 주말에 너무 열심히하심</div>
        <div>ㄴ이제 편히 쉬셔도될듯</div>
        <div>ㄴ ㅇㅇ ㅇㅈ</div>
        <div>hell</div>
    </div> -->
    <div class="main_comment_wrapper comment-box">
        <div class="comment-title">댓글</div>
        <hr>
        <div class="comment-list">
           <!--  <div class="comment"><span class="nickname">희재</span> : 우진님이 내꺼도와줌 ㄷㄷ <span
                    class="comment_write_date"
            >2025-05-19</span>
            <div class="comment"><span class="nickname">강찬</span> : 우진님은 이제 쉬세요. <span
                    class="comment_write_date"
            >2025-05-19</span>
            </div> -->
        </div>
        <div class="comment-input">
            <input type="text" placeholder="댓글쓰기"/>
            <button>↑</button>
        </div>
    </div>
</div>
<div class="video_container">
    <video class="video_player" controls muted loop playsinline>
        <source src="<c:url value="/upload/videos/2025/05/test03.mp4"/>" type="video/mp4">
        브라우저가 비디오 태그를 지원하지 않습니다.
    </video>
    <div class="video_side_buttons_wrapper">
        <img src="<c:url value="/img/main/icons/like_icon.png"/>" class="video_side_buttons" alt="">
        <img
                src="<c:url value="/img/main/icons/comment_icon.png"/>" class="video_side_buttons"
                alt=""
        >
        <img
                src="<c:url value="/img/main/icons/share_icon.png"/>" class="video_side_buttons"
                alt=""
        >
        <img src="<c:url value="/img/main/icons/save_icon.png"/>" class="video_side_buttons" alt="">
        <img
                src="<c:url value="/img/main/icons/report_icon.png"/>" class="video_side_buttons"
                alt=""
        >
    </div>
		<div class="main_comment_wrapper comment-box">
		    <div class="comment-title">댓글</div>
		    <div class="comment-list">
		        <div class="comment">
		            <!-- <span class="nickname">희재</span>
		            우진님이 내꺼도와줌 ㄷㄷ
		            <span class="comment_write_date">2025-05-19</span>
		            <span class="nickname">강찬</span>
		            우진님은 이제 그만하고 쉬셈
		            <span class="comment_write_date">2025-05-19</span> -->
		        </div>
		        <!-- 필요시 댓글 추가 -->
		    </div>
		    <div class="comment-input">
		        <input type="text" placeholder="댓글을 입력하세요"/>
		        <button>↑</button>
		    </div>
		</div>
</div>
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
    const commentButtons = document.querySelectorAll('.video_side_buttons_wrapper .video_side_buttons:nth-child(2)');

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
