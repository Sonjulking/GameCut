<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<h2>게시글 목록</h2>
<hr>
<table>
    <thead>
        <tr>
            <th>게시글 번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>IP</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="t" items="${list}">
            <tr>
                <td>${t.no}</td>
                <td>${t.title}</td>
                <td>${t.writer}</td>
                <td>${t.ip}</td>
            </tr>
        </c:forEach>
    </tbody>
</table>