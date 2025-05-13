<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#profile_icon {
    border-radius: 50%;         
    object-fit: cover;          
    width: 40px;               
    height: 40px;
}

</style>
<html>
    <head>
        <title>인생겜컷</title>
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        
        <!-- 로그인시 프로필사진 보이기 -->
    <c:if test="${loginUSER != null}">
		<c:if test="${profileUrl != null}">
			<c:set var="profileImageUrl" value="${profileUrl}" />
		</c:if>
		<c:if test="${profileUrl == null}">
			<c:set var="profileImageUrl" value="img/main/icons/profile_icon.png" />
		</c:if>
	</c:if>
	
         <!-- 자동 로그아웃 스크립트 (로그인된 사용자에만 작동) -->
    <c:if test="${loginUSER != null}">
        <script>
            let idleTimer;
            const maxIdleTime = 10 * 60 * 1000; // 시간설정.

            function resetIdleTimer() {
                clearTimeout(idleTimer);
                idleTimer = setTimeout(() => {
                    alert("10분 동안 활동이 없어 자동 로그아웃됩니다.");
                    location.href = "logout.do";
                }, maxIdleTime);
            }

            // 사용자 이벤트 감지
            ["click", "mousemove", "keydown", "scroll", "touchstart"].forEach(evt => {
                document.addEventListener(evt, resetIdleTimer);
            });

            window.onload = resetIdleTimer;
        </script>
    </c:if>
        
        
    </head>
    <body>
        <header>
            <a href="<c:url value="/"/>">
                <img src="img/main/logo/gamecut_logo.png" alt="logo" id="gamecut_logo"/>
            </a>
            <div>
                <a href="search.do">
                    <img
                            src="img/main/icons/search_icon.png" alt="search_icon" id="search_icon"
                            class="header_icon"
                    />
                </a>
                <c:if test="${loginUSER != null }">
                   <a href="logout.do">
                       <img
                               src="img/main/icons/logout_icon.png" alt="logout_icon" id="logout_icon"
                               class="header_icon"
                       />
                   </a>
                   <a href="myPage.do">
                       <img
                               src="${profileImageUrl}" alt="profile_icon" id="profile_icon"
                               class="header_icon"
                       />
                   </a>
                </c:if>
                <c:if test="${loginUSER == null }">
                   <a href="login.do">
                       <img
                               src="img/main/icons/login_icon.png" alt="login_icon" id="login_icon"
                               class="header_icon"
                       />
                   </a>
                </c:if>
            </div>
        </header>