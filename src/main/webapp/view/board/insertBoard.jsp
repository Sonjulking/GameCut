<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 작성</title>
    <style>
        body {
            background-color: #121212;
            color: #f0f0f0;
            font-family: 'Arial', sans-serif;
            padding: 2rem;
        }

        .form-container {
            background-color: #1e1e1e;
            padding: 2rem;
            border-radius: 12px;
            width: 600px;
            margin: 0 auto;
            box-shadow: 0 0 10px rgba(255,255,255,0.05);
        }

        h2 {
            text-align: center;
            color: #f39c12;
            margin-bottom: 1.5rem;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 0.4rem;
            margin-top: 1.2rem;
        }

        select, input[type="text"], input[type="file"], textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #444;
            background-color: #1a1a1a;
            color: #f0f0f0;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #333;
            color: #f0f0f0;
            border: 1px solid #555;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            margin-top: 1.5rem;
            display: block;
            margin-left: auto;
        }

        input[type="submit"]:hover {
            background-color: #555;
        }

        .error-msg {
            color: red;
            text-align: center;
            margin-top: 1rem;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>게시글 작성</h2>

        <form action="insertBoard.do" method="post" enctype="multipart/form-data">
            <label>게시판 선택</label>
            <select name="boardTypeNo" required>
                <option value="1" ${boardTypeNo == '1' ? 'selected' : ''}>자유게시판</option>
                <option value="2" ${boardTypeNo == '2' ? 'selected' : ''}>팁게시판</option>
                <option value="3" ${boardTypeNo == '3' ? 'selected' : ''}>영상게시판</option>
            </select>

            <label>제목</label>
            <input type="text" name="boardTitle" required/>

            <label>내용</label>
            <textarea name="boardContent" rows="8" required></textarea>

            <label>영상 업로드 (선택)</label>
            <input type="file" name="video" accept="video/*">

            <input type="submit" value="등록"/>
        </form>

        <c:if test="${not empty error}">
            <p class="error-msg">${error}</p>
        </c:if>
    </div>

</body>
</html>