<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>게시판 메인</title>
  <style>

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

    th.sortable {
      cursor: pointer;
      user-select: none;
    }

    .arrow {
      margin-left: 4px;
      font-size: 12px;
      color: #bbb;
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

    th:nth-child(1), td:nth-child(1) { width: 45%; }
    th:nth-child(2), td:nth-child(2) { width: 20%; }
    th:nth-child(3), td:nth-child(3) { width: 15%; }
    th:nth-child(4), td:nth-child(4) { width: 10%; }
    th:nth-child(5), td:nth-child(5) { width: 10%; }

    td:nth-child(1) a {
      display: inline-block;
      max-width: 100%;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
  </style>
</head>
<body>

  <div class="top-bar">
    <div>
      <span class="tab-btn ${param.boardTypeNo == '1' ? 'active' : ''}" data-type="1">자유게시판</span>
      <span class="tab-btn ${param.boardTypeNo == '2' ? 'active' : ''}" data-type="2">팁게시판</span>
      <span class="tab-btn ${param.boardTypeNo == '3' ? 'active' : ''}" data-type="3">영상게시판</span>
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
          <th class="sortable" data-sort="view">
            조회수 <span class="arrow" data-field="view">▼</span>
          </th>
          <th class="sortable" data-sort="like">
            좋아요 <span class="arrow" data-field="like">▼</span>
          </th>
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
    // 탭 전환
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
          .catch(err => console.error("AJAX 오류:", err));
      });
    });

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
            .catch(err => console.error("AJAX 오류:", err));
        });
      });

      // 정렬 토글
      let currentSort = null;
      let currentOrder = "desc";

      document.querySelectorAll(".sortable").forEach(th => {
        th.addEventListener("click", function (e) {
          // 클릭한 곳이 <th> 또는 내부 <span>일 수 있으므로 sort는 항상 th에서 가져옴
          const thElement = e.currentTarget;
          const sort = thElement.dataset.sort;
          const type = document.getElementById("selectedBoardType").value;

          if (!sort || !type) return;

          // 정렬 방향 토글
          if (currentSort === sort) {
            currentOrder = currentOrder === "desc" ? "asc" : "desc";
          } else {
            currentSort = sort;
            currentOrder = "desc";
          }

          // 모든 화살표 ▼로 초기화
          document.querySelectorAll(".arrow").forEach(arrow => {
            arrow.textContent = "▼";
          });

          // 현재 화살표만 방향 변경
          const currentArrow = thElement.querySelector(".arrow");
          if (currentArrow) {
            currentArrow.textContent = currentOrder === "desc" ? "▼" : "▲";
          }

          // AJAX로 정렬된 목록 요청
          fetch(`getBoardListAjax.do?type=${type}&sort=${sort}&order=${currentOrder}`)
            .then(res => res.text())
            .then(html => {
              document.getElementById("boardListBody").innerHTML = html;
            })
            .catch(err => console.error("정렬 AJAX 오류:", err));
        });
      });
  </script>
</body>
</html>

