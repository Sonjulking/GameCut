<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>게시판 메인</title>
  <style>
    body {
      background-color: #121212;
      color: #f0f0f0;
      font-family: 'Arial', sans-serif;
      padding: 30px;
    }

    .top-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }

    .tab-btn {
      margin-right: 10px;
      cursor: pointer;
      font-weight: bold;
      color: #aaa;
    }

    .tab-btn.active {
      color: #4ea6ff;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background-color: #1e1e1e;
      margin-bottom: 20px;
    }

    th, td {
      border: 1px solid #333;
      padding: 10px;
      text-align: center;
    }

    th {
      background-color: #222;
      color: #ddd;
    }

    td a {
      color: #4ea6ff;
      text-decoration: none;
    }

    td a:hover {
      text-decoration: underline;
    }

    input[type="submit"], button {
      background-color: #333;
      color: #f0f0f0;
      border: 1px solid #555;
      padding: 6px 14px;
      border-radius: 6px;
      cursor: pointer;
    }

    input[type="submit"]:hover, button:hover {
      background-color: #555;
    }

    .search-bar {
      display: flex;
      justify-content: flex-end;
      gap: 8px;
      align-items: center;
      margin-bottom: 20px;
    }

    select, input[type="text"] {
      padding: 6px;
      border-radius: 4px;
      border: 1px solid #555;
      background-color: #1a1a1a;
      color: #f0f0f0;
    }
  </style>
</head>
<body>

  <div class="top-bar">
    <div>
      <span class="tab-btn active" data-type="1">자유게시판</span>
      <span class="tab-btn" data-type="2">팁게시판</span>
      <span class="tab-btn" data-type="3">영상게시판</span>
    </div>
    <form id="writeForm" action="insertBoardForm.do" method="get">
      <input type="hidden" name="boardTypeNo" id="selectedBoardType" value="1" />
      <input type="submit" value="글쓰기" />
    </form>
  </div>

  <div id="boardListArea">
    <table>
      <thead>
        <tr>
          <th>제목</th>
          <th>작성자</th>
          <th>작성일</th>
          <th>조회수</th>
          <th>좋아요</th>
        </tr>
      </thead>
      <tbody id="boardListBody">
        <c:forEach var="b" items="${list}">
          <tr>
            <td><a href="detailBoard.do?boardNo=${b.boardNo}">${b.boardTitle}</a></td>
            <td>${b.userNickname}</td>
            <td>${b.boardCreateDate}</td>
            <td>${b.boardCount}</td>
            <td>${b.boardLike}</td>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </div>

<form action="searchBoard.do" method="get" class="search-bar">
  <input type="hidden" name="boardTypeNo" id="searchBoardType" value="1" />
  <select name="category">
    <option value="title">제목</option>
    <option value="nickname">작성자</option>
    <option value="content">내용</option>
  </select>
  <input type="text" name="keyword" placeholder="검색어를 입력하세요" required />
  <input type="submit" value="검색" />
</form>


  <script>
    document.querySelectorAll(".tab-btn").forEach(btn => {
      btn.addEventListener("click", function () {
        const type = btn.dataset.type;

        document.querySelectorAll(".tab-btn").forEach(b => b.classList.remove("active"));
        btn.classList.add("active");

        document.getElementById("selectedBoardType").value = type;
        document.getElementById("searchBoardType").value = type;

        fetch("getBoardListAjax.do?type=" + type)
          .then(res => res.text())
          .then(html => {
            document.getElementById("boardListBody").innerHTML = html;
          })
          .catch(err => {
            console.error("AJAX 오류:", err);
          });
      });
    });
  </script>

</body>
</html>