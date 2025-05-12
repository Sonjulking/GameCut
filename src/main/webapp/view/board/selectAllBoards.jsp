<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <h2>게시판 전체 글 목록</h2>

    <!-- 📋 게시글 리스트 -->
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자(번호)</th>
                <th>조회수</th>
                <th>좋아요</th>
                <th>작성일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="board" items="${list}">
                <tr>
                    <td>${board.boardNo}</td>
                    <td>
                        <a href="detailBoard.do?boardNo=${board.boardNo}">
                            ${board.boardTitle}
                        </a>
                    </td>
                    <td>${board.userNo}</td>
                    <td>${board.boardCount}</td>
                    <td>${board.boardLike}</td>
                    <td>${board.boardCreateDate}</td>
                </tr>
            </c:forEach>

            <c:if test="${empty list}">
                <tr>
                    <td colspan="6">등록된 게시글이 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

<form action="searchBoard.do" method="get">
    <select name="category">
        <option value="nickname">닉네임</option>
        <option value="title">제목</option>
        <option value="content">내용</option>
    </select>
    <input type="text" name="keyword" placeholder="검색어를 입력하세요">
    <button type="submit">검색</button>
</form>

</body>
</html>