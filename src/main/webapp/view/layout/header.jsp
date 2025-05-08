<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                <a href="login.do">
                    <img
                            src="img/main/icons/login_icon.png" alt="login_icon" id="login_icon"
                            class="header_icon"
                    />
                </a>
            </div>
        </header>

