<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 신고</title>
    <style>
        body {
            background-color: #121212;
            color: #f0f0f0;
            font-family: 'Arial', sans-serif;
            padding: 2rem;
        }

        .report-container {
            background-color: #1e1e1e;
            padding: 2rem;
            border-radius: 12px;
            width: 600px;
            margin: 0 auto;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.05);
        }

        h2 {
            text-align: center;
            color: #f39c12;
            margin-bottom: 1.5rem;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 1rem;
            margin-bottom: 0.5rem;
        }

        select, textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #444;
            background-color: #1a1a1a;
            color: #f0f0f0;
            resize: vertical;
        }

        button[type="submit"] {
            display: block;
    margin-left: auto;
    background-color: #333;
    color: #f0f0f0;
    border: 1px solid #555;
    padding: 8px 16px;
    border-radius: 6px;
    cursor: pointer;
    margin-top: 1.5rem;
        }

        button[type="submit"]:hover {
            background-color: #555;
        }
    </style>
</head>
<body>

<div class="report-container">
    <h2>게시글 신고</h2>
    <form action="reportBoard.do" method="post">
        <input type="hidden" name="boardNo" value="${boardNo}">
        <input type="hidden" name="targetUserNo" value="${targetUserNo}">

        <label for="reportType">신고 유형</label>
        <select name="reportType" id="reportType">
            <option value="스팸">스팸</option>
            <option value="욕설">욕설</option>
            <option value="불법광고">불법광고</option>
        </select>

        <label for="reportContent">신고 내용</label>
        <textarea name="reportContent" id="reportContent" rows="6" placeholder="신고 내용을 입력해주세요..."></textarea>

        <button type="submit">신고 제출</button>
    </form>
</div>

</body>
</html>
