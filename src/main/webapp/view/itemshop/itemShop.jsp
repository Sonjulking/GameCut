<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page
	import="com.gamecut.dao.ItemDAO, com.gamecut.vo.ItemVO, java.util.ArrayList, com.gamecut.vo.UserVO"%>

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
	<c:forEach var="item" items="${items}">
		<div class="item-card">
			<c:choose>
				<c:when test="${ownedItemNos.contains(item.itemNo)}">
					<img src="/upload/items${item.itemNo}.png"
						onclick="alert('이미 구매한 아이템입니다.')" class="item-image"
						alt="${item.itemName}">
				</c:when>
				<c:otherwise>
					<img src="/upload/items${item.itemNo}.png"
						onclick="purchaseItem(${item.itemNo}, '${item.itemName}', ${userNo})"
						class="item-image" alt="${item.itemName}">
				</c:otherwise>
			</c:choose>

			<div class="item-info">
				<div class="text-block">
					<p>
						<strong>상품명:</strong>
						<c:out value="${empty item.itemName ? '' : item.itemName}" />
					</p>
					<p>
						<strong>가격:</strong>
						<c:choose>
							<c:when test="${ownedItemNos.contains(item.itemNo)}">보유중</c:when>
							<c:when test="${empty item.itemPrice}">0P</c:when>
							<c:otherwise>${item.itemPrice}P</c:otherwise>
						</c:choose>
					</p>
				</div>
			</div>
		</div>
	</c:forEach>
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