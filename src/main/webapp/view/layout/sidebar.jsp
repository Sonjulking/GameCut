<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<aside class="left">
    <div>
        <a href="#">
            <img
                    src="img/main/icons/home_icon.png" alt="home_icon" class="sidebar_icons"
            >
        </a>
    </div>
    <div>
        <a href="selectAllBoards.do">
            <img
                    src="img/main/icons/board_view_icon.png" alt="board_view_icon"
                    class="sidebar_icons"
            >
        </a>
    </div>
    <div>
        <a href="myPage.do">
            <img
                    src="img/main/icons/profile_icon.png" alt="profile_icon" class="sidebar_icons"
            >
        </a>
    </div>
   <!--  <div>
        <a href="#">
            <img
                    src="img/main/icons/video_management_icon.png" alt="video_management_icon"
                    class="sidebar_icons"
            >
        </a>
    </div> -->
    <div>
        <a href="#">
            <img
                    src="img/main/icons/friend_management_icon.png" alt="friend_management_icon"
                    class="sidebar_icons"
            >
        </a>
    </div>
    <div>
        <a href="#">
            <img
                    src="img/main/icons/web_game_icon.png" alt="web_game_icon" class="sidebar_icons"
            >
        </a>
    </div>
    <c:if test="${not empty sessionScope.loginUSER}">
    <div>
        <a href="itemShop.do">
            <img src="img/main/icons/shopping_icon.png" alt="shopping_icon" class="sidebar_icons">
        </a>
    </div>
	</c:if>
    <div>
        <a href="#">
            <img
                    src="img/main/icons/season_ranking_icon.png" alt="season_ranking_icon"
                    class="sidebar_icons"
            >
        </a>
    </div>
    <div>
        <a href="#">
            <img
                    src="img/main/icons/setting_icon.png" alt="setting_icon" class="sidebar_icons"
            >
        </a>
    </div>
</aside>