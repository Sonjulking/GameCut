<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>게시글 작성</title>
        <style>
            form {
                width: 600px;
                margin: 40px auto;
            }

            input, select, textarea {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
            }

            input[type="submit"] {
                width: auto;
                padding: 10px 20px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>

        <h2 style="text-align: center;">게시글 작성</h2>

        <form action="insertBoard.do" method="post" enctype="multipart/form-data">


            <label>게시판 선택</label>
            <select name="boardTypeNo" required>
                <option value="1" ${boardTypeNo == '1' ? 'selected' : ''}>자유게시판</option>
                <option value="2" ${boardTypeNo == '2' ? 'selected' : ''}>팁게시판</option>
                <option value="3" ${boardTypeNo == '3' ? 'selected' : ''}>영상게시판</option>
            </select>


            <label>제목</label>
            <input type="text" name="boardTitle" required/><br>

            <label>내용</label>
            <textarea name="boardContent" rows="8" required></textarea>

            <label>영상 번호 (선택)</label>
            <%--<input type="number" name="videoNo" placeholder="없으면 비워두세요"/>--%>
            <input type="file" name="video" accept="video/*">

            <input type="submit" value="등록"/>
        </form>

        <c:if test="${not empty error}">
            <p style="color: red; text-align: center;">${error}</p>
        </c:if>

    </body>
</html>

