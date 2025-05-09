<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${loginUSER != null}">
    <c:set var="profileImageUrl" value="img/main/icons/friend_management_icon.png" />
    
</c:if>
<html>
    <head>
        <title>인생겜컷</title>
        <link rel="stylesheet" type="text/css" href="css/main.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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