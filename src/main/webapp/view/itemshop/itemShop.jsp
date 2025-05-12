<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.gamecut.dao.ItemDAO, com.gamecut.vo.ItemVO, java.util.ArrayList, com.gamecut.vo.UserVO" %>
<%@ include file="/view/layout/header.jsp" %>
<%@ include file="/view/layout/nav.jsp" %>
<%@ include file="/view/layout/sidebar.jsp" %>
<link rel="stylesheet" href="main.css">

<%
    UserVO user = (UserVO) session.getAttribute("loginUSER");
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

<div class="shop-container">
  <div class="shop-header">
    <span>마이포인트: ${userPoint}P</span>
    <c:if test="${userRole eq 'admin'}">
      <a href="itemRegister.do" class="register-button">상품등록</a>
    </c:if>
  </div>

  <div class="item-grid">
    <c:forEach var="item" items="${items}">
      <div class="item-card">
        <img src="/images/item/${item.itemNo}.png"
             class="item-image"
             onclick="purchaseItem(${item.itemNo}, '${item.itemName}', ${userNo}, ${ownedItemNos.contains(item.itemNo)})">
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
function purchaseItem(itemNo, itemName, userNo, owned) {
  if (owned) {
    alert("이미 구매한 아이템입니다.");
    return;
  }
  if (confirm(itemName + "을(를) 구매하시겠습니까?")) {
    alert(itemName + "을(를) 구매하였습니다.");
    location.href = "itemShopOK.do?itemNo=" + itemNo + "&userNo=" + userNo;
  }
}
</script>

<%@ include file="/view/layout/footer.jsp" %>
