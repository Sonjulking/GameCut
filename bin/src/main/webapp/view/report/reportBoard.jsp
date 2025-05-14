<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="reportBoard.do" method="post">
    <input type="hidden" name="boardNo" value="${boardNo}">
    <input type="hidden" name="targetUserNo" value="${targetUserNo}">

    <label>신고 유형:</label>
    <select name="reportType">
        <option value="스팸">스팸</option>
        <option value="욕설">욕설</option>
        <option value="불법광고">불법광고</option>
    </select><br><br>

    <label>신고 내용:</label><br>
    <textarea name="reportContent" rows="5" cols="50"></textarea><br><br>

    <button type="submit">신고 제출</button>
</form>

</body>
</html>