<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="../../css/video.css">
<div class="video_container">
    <video class="video_player" muted loop playsinline>
        <source src="/upload/videos/2025/05/test01.mp4" type="video/mp4">
        브라우저가 비디오 태그를 지원하지 않습니다.
    </video>
</div>
<div class="video_container">
    <video class="video_player" muted loop playsinline>
        <source src="/upload/videos/2025/05/test02.mp4" type="video/mp4">
        브라우저가 비디오 태그를 지원하지 않습니다.
    </video>
</div>
<div class="video_container">
    <video class="video_player" muted loop playsinline>
        <source src="/upload/videos/2025/05/test03.mp4" type="video/mp4">
        브라우저가 비디오 태그를 지원하지 않습니다.
    </video>
</div>
<script>
    // 스크롤 시 보이는 영상만 재생
    const videos = document.querySelectorAll(".video_player");

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
