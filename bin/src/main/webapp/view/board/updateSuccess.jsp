<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>수정 완료</title>
  <script>
    window.onload = function () {
      alert("수정이 완료되었습니다.");
      location.href = "detailBoard.do?boardNo=${boardNo}";
    }
  </script>
</head>
<body>
</body>
</html>
