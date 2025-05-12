<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page
	import="com.gamecut.dao.ItemDAO, com.gamecut.vo.ItemVO, java.util.ArrayList, com.gamecut.vo.UserVO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<link rel="stylesheet" href="main.css">

<%
UserVO user = (UserVO) session.getAttribute("loginUSER");
if (user != null) {
	request.setAttribute("userNo", user.getUserNo());
	request.setAttribute("userPoint", user.getUserPoint());
	request.setAttribute("userRole", user.getRole());
}
ItemDAO dao = new ItemDAO();
ArrayList<ItemVO> items = dao.selectAllItems();
request.setAttribute("items", items);
    /* UserVO user = (UserVO) session.getAttribute("loginUSER");
    boolean isAdmin = user != null && "admin".equals(user.getRole());
    int userNo = user.getUserNo();
    int userPoint = user.getUserPoint();

    ItemDAO dao = new ItemDAO();
    ArrayList<ItemVO> items = dao.selectAllItems(); */
%>

<div class="shop-header-container">
	<div class="shop-header">
		<span class="user-point">마이포인트: ${userPoint}P</span> &nbsp; &nbsp;
		<c:if test="${userRole eq 'ROLE_ADMIN'}">
			<button class="register-button" onclick="openItemRegisterPopup()">상품 등록</button>
		</c:if>
	</div>
</div>

<div class="item-grid">
    <div class="item-grid">
        <c:forEach var="item" items="${items}">
            <div class="item-card">
                <img
                        src="/images/item/${item.itemNo}.png"
                        class="item-image"
                        onclick="purchaseItem(${item.itemNo}, '${item.itemName}', ${userNo}, ${ownedItemNos.contains(item.itemNo)})"
                >
                <div class="item-info">
                    <span>${item.itemName}</span><br>
                    <c:choose>
                        <c:when test="${ownedItemNos.contains(item.itemNo)}">
                            <strong>보유중</strong>
                        </c:when>
                        <c:otherwise>
                            <strong>${item.itemPrice}P</strong>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
function purchaseItem(itemNo, itemName, userNo) {
    if (confirm(itemName + "을(를) 구매하시겠습니까?")) {
        alert(itemName + "을(를) 구매하였습니다.");
        location.href = "itemShopOK.do?itemNo=" + itemNo + "&userNo=" + userNo;
    }
}

function openItemRegisterPopup() {
    window.open(
        "itemRegister.do",
        "itemRegister",
        "width=500,height=500,top=100,left=200,resizable=no,scrollbars=yes"
    );
}
</script>