package com.gamecut.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.gamecut.dao.LikeBoardDAO;

public class LikeBoardAction implements GameCutAction {

    @Override
    public String pro(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json; charset=UTF-8");

        String boardNoStr = request.getParameter("boardNo");
        String status = request.getParameter("status");

        if (boardNoStr == null || status == null || boardNoStr.isEmpty() || status.isEmpty()) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"잘못된 요청입니다.\"}");
            return null;
        }

        int boardNo = Integer.parseInt(boardNoStr.trim());

        LikeBoardDAO dao = new LikeBoardDAO();
        dao.updateLikeCount(boardNo, "liked".equals(status.trim()));

        int likeCount = dao.getLikeCount(boardNo);
        String json = String.format("{\"status\":\"%s\", \"likeCount\":%d}", status, likeCount);

        response.getWriter().write(json);
        return null;
    }
}

