package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.CommentDAO;
import com.gamecut.dao.PointHistoryDAO;
import com.gamecut.vo.CommentVO;
import com.gamecut.vo.UserVO;

public class InsertCommentAction implements GameCutAction {

    @Override
    public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        int userNo = ((UserVO) session.getAttribute("loginUSER")).getUserNo();

        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        String content = request.getParameter("commentContent");
        int parentNo = Integer.parseInt(request.getParameter("parentCommentNo"));

        CommentVO vo = new CommentVO();
        vo.setBoardNo(boardNo);
        vo.setUserNo(userNo);
        vo.setParentCommentNo(parentNo);
        vo.setCommentContent(content);

        new CommentDAO().insertComment(vo);

        String source = (parentNo == 0) ? "댓글 작성" : "대댓글 작성";
        int point = (parentNo == 0) ? 10 : 5;
        new PointHistoryDAO().addPoint(userNo, source, point);

        response.getWriter().print("success");
        return null;
    }
}
