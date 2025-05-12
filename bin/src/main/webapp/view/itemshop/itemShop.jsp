<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gamecut.dao.ItemDAO, com.gamecut.vo.ItemVO, java.util.ArrayList, com.gamecut.vo.UserVO" %>

<link rel="stylesheet" href="main.css">

<%
    UserVO user = (UserVO) session.getAttribute("user");
    boolean isAdmin = user != null && "admin".equals(user.getRole());
    int userNo = user.getUserNo();
    int userPoint = user.getUserPoint();

    ItemDAO dao = new ItemDAO();
    ArrayList<ItemVO> items = dao.selectAllItems();
%>

<div class="top-right">
    <span>마이포인트: <%= userPoint %> P</span>
    <% if (isAdmin) { %>
        <button onclick="location.href='registerItem.jsp'">상품 등록</button>
    <% } %>
</div>

<div class="item-container">
    <% for (ItemVO item : items) {
        if (item.getItemDeleteDate() != null) continue;
    %>
        <div class="item-card">
            <img src="getItemImage.jsp?itemNo=<%= item.getItemNo() %>"
                 alt="<%= item.getItemName() %>"
                 onclick="confirmPurchase('<%= item.getItemName() %>', <%= item.getItemNo() %>)">
            <div><strong><%= item.getItemName() %></strong></div>
            <div><%= item.getItemPrice() %>P</div>
        </div>
    <% } %>
</div>

<script>
function confirmPurchase(name, itemNo) {
    if (confirm(name + " 을 구매하시겠습니까?")) {
        location.href = "itemShopProcess.jsp?itemNo=" + itemNo;
    }
}
</script>

