<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
    <video id="game_video" controls>
        <source src="<c:url value="/upload/videos/2025/05/test.mp4"/>" type="video/mp4">
        <%--<source src="<c:url value="/upload/videos/2025/05/test02.mp4"/>" type="video/mp4">--%>
        브라우저가 비디오 태그를 지원하지 않습니다.
    </video>
</div>
<script>
    const video = document.querySelector('#game_video');

    video.addEventListener('loadedmetadata', function () {
        if (video.videoWidth > video.videoHeight) {
            // 가로 영상
            video.classList.add('widthVideo');
        } else {
            // 세로 영상
            video.classList.add('heightVideo');
        }
    });

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
</script>
