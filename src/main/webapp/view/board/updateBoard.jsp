<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>게시글 수정</title>
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

    select, input[type="text"], input[type="number"], textarea {
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
  </style>
</head>
<body>

  <div class="form-container">
    <h2>게시글 수정</h2>

    <form action="updateBoard.do" method="post">
      <input type="hidden" name="boardNo" value="${board.boardNo}" />

      <label>게시판 선택</label>
      <select name="boardTypeNo" required>
        <option value="1" ${board.boardTypeNo == 1 ? 'selected' : ''}>자유게시판</option>
        <option value="2" ${board.boardTypeNo == 2 ? 'selected' : ''}>팁게시판</option>
        <option value="3" ${board.boardTypeNo == 3 ? 'selected' : ''}>영상게시판</option>
      </select>

      <label>제목</label>
      <input type="text" name="boardTitle" value="${board.boardTitle}" required />

      <label>내용</label>
      <textarea name="boardContent" rows="8" required>${board.boardContent}</textarea>

      <label>영상 번호 (선택)</label>
      <input type="number" name="videoNo" value="${board.videoNo}" placeholder="없으면 비워두세요" />

      <input type="submit" value="수정 완료" />
    </form>
  </div>

</body>
</html>
