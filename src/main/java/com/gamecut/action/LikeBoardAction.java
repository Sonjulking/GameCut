package com.gamecut.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;

import com.gamecut.dao.LikeBoardDAO;
import com.gamecut.vo.LikeBoardVO;
import com.gamecut.vo.UserVO;

public class LikeBoardAction implements GameCutAction {

    @Override
    public String pro(HttpServletRequest request, HttpServletResponse response) throws IOException {
    	response.setContentType("application/json; charset=UTF-8");

        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUSER");

        if (loginUser == null) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"로그인이 필요합니다.\"}");
            return null;
        }

        int userNo = loginUser.getUserNo();
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));

        LikeBoardVO vo = new LikeBoardVO();
        vo.setUserNo(userNo);
        vo.setBoardNo(boardNo);

        LikeBoardDAO dao = new LikeBoardDAO();
        boolean alreadyLiked = dao.isLiked(vo);

        String status;
        if (!alreadyLiked) {
            dao.insertLike(vo);
            status = "liked";
        } else {
            dao.deleteLike(vo);
            status = "unliked";
        }

        int likeCount = dao.getLikeCount(boardNo);
        String json = String.format("{\"status\":\"%s\", \"likeCount\":%d}", status, likeCount);
        response.getWriter().write(json);
        return null;
    }
}

