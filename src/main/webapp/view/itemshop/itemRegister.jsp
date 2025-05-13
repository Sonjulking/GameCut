<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>상품 등록</title>
    <link rel="stylesheet" href="/css/popup.css">
</head>
<body>
<div class="register-popup">
    <h2>상품 등록</h2>
    <form action="itemRegisterOK.do" method="post" enctype="multipart/form-data">
        <label for="itemName">아이템 이름:</label>
        <input type="text" name="itemName" id="itemName" required>

        <label for="itemPrice">아이템 가격:</label>
        <input type="number" name="itemPrice" id="itemPrice" min="0" required>

        <label for="itemImage">아이템 이미지:</label>
        <input type="file" name="itemImage" id="itemImage" accept="image/*" required>

        <button type="submit">등록</button>
    </form>
</div>
</body>
</html>
