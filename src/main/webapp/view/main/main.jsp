<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
    <video id="game_video" controls>
        <source src="<c:url value="/upload/videos/2025/05/test02.mp4"/>" type="video/mp4">
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
</script>