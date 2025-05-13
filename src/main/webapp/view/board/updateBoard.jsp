<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>게시글 수정</title>
</head>
<body>
  <h2>게시글 수정</h2>

  <form action="updateBoard.do" method="post">
    <input type="hidden" name="boardNo" value="${board.boardNo}" />
	<label>게시판 선택</label>
    <select name="boardTypeNo" required>
 	  <option value="1" ${board.boardTypeNo == 1 ? 'selected' : ''}>자유게시판</option>
	  <option value="2" ${board.boardTypeNo == 2 ? 'selected' : ''}>팁게시판</option>
	  <option value="3" ${board.boardTypeNo == 3 ? 'selected' : ''}>영상게시판</option>

</select><br><br>
    <label>제목</label>
    <input type="text" name="boardTitle" value="${board.boardTitle}" required /><br><br>

    <label>내용</label><br>
    <textarea name="boardContent" rows="8" required>${board.boardContent}</textarea><br><br>

    <label>영상 (선택)</label><br>
    <input type="number" name="videoNo" value="${board.videoNo}" placeholder="없으면 비워두세요" /><br><br>

    <input type="submit" value="수정 완료" />
  </form>
</body>
</html>
