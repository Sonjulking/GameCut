package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.CommentLikeDAO;
import com.gamecut.dao.PointHistoryDAO;
import com.gamecut.vo.UserVO;

public class ToggleCommentLikeAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
        int userNo = ((UserVO) session.getAttribute("loginUSER")).getUserNo();

        int commentNo = Integer.parseInt(request.getParameter("commentNo"));

        CommentLikeDAO dao = new CommentLikeDAO();
        boolean isLiked = dao.toggleLike(commentNo, userNo);

        if (isLiked) {
            new PointHistoryDAO().addPoint(userNo, "댓글 좋아요", 3);
        }

        int likeCount = dao.countLikes(commentNo);
        response.getWriter().print(likeCount);

        return null;
    }

}
