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
    <div class="main_comment_wrapper">
        <p>댓글</p>
        <hr>
        <div>우진님 주말에 너무 열심히하심</div>
        <div>ㄴ이제 편히 쉬셔도될듯</div>
        <div>ㄴ ㅇㅇ ㅇㅈ</div>
        <div>hell</div>
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
    <div class="main_comment_wrapper">
        <div>우진님 주말에 너무 열심히하심</div>
        <div>ㄴ이제 편히 쉬셔도될듯</div>
        <div>ㄴ ㅇㅇ ㅇㅈ</div>
        <div>hell</div>
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
    <div class="main_comment_wrapper">
        <div>hell</div>
    </div>
</div>
<script>
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
