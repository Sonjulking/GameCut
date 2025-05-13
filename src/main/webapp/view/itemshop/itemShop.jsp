<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page
	import="com.gamecut.dao.ItemDAO, com.gamecut.vo.ItemVO, java.util.ArrayList, com.gamecut.vo.UserVO"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<link rel="stylesheet" href="main.css">
<style>
	.item-card{
		display: inline-block;
		margin: 10px;
	}
</style>

<%
UserVO user = (UserVO) session.getAttribute("loginUSER");
ItemDAO dao = new ItemDAO();
ArrayList<ItemVO> items = dao.selectAllItems();
request.setAttribute("items", items);
%>
<c:if test="${not empty user}">
    <c:set var="userNo" value="${user.userNo}" />
    <c:set var="userPoint" value="${user.userPoint}" />
    <c:set var="userRole" value="${user.role}" />
</c:if>



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
        <c:forEach var="item" items="${items}" varStatus="status">
            <div class="item-card">
                <img
                        src="${files[status.index].fileUrl}"
                        class="item-image"
                        onclick="purchaseItem(${item.itemNo}, '${item.itemName}', ${userNo}, ${ownedItemNos.contains(item.itemNo)})"
                >
                <div class="item-info">
                <p class="item-name">
                    <c:out value="${item.itemName}" />
                </p>
                <p class="item-price">
                    <c:choose>
                        <c:when test="${hasUserItem.contains(item.userNo, item.itemNo)}">보유중</c:when>
                        <c:otherwise>${item.itemPrice}P</c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
    </c:forEach>
</div>

<script>

function purchaseItem(itemNo, itemName, userNo, owned) {
    if (!itemNo || !userNo) {
        alert("유효하지 않은 요청입니다.");
        return;
    }

    if (owned) {
        alert("이미 구매한 아이템입니다.");
        return;
    }

    if (!confirm(itemName + "을(를) 구매하시겠습니까?")) {
        return;
    }

    fetch(`itemShopOK.do?itemNo=\${itemNo}&userNo=\${userNo}`, {method:'POST'})
        .then(response => response.text())
        .then(result => {
            result = result.trim();
            if (result === "SUCCESS") {
                alert(itemName + "을(를) 구매하였습니다.");
                location.reload();
            } else if (result === "NOT_ENOUGH_POINT") {
                alert("포인트가 부족합니다.");
            } else if (result === "ALREADY_OWNED") {
                alert("이미 구매한 아이템입니다.");
            } else {
                alert("구매에 실패하였습니다.");
            }
        })
        .catch(err => {
			console.log("구매 에러 발생")
            console.error(err);
            alert("이게 뭔 에러인지 저도 모르겠습니다.");
        });
}

function openItemRegisterPopup() {
    window.open(
        "itemRegister.do",
        "itemRegister",
        "width=500,height=500,top=100,left=200,resizable=no,scrollbars=yes"
    );
}
</script>