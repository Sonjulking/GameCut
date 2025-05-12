package com.gamecut.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.CommentDAO;
import com.gamecut.vo.CommentVO;

public class ListParentCommentAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));

        CommentDAO dao = new CommentDAO();
        List<CommentVO> commentList = dao.selectParentComments(boardNo);

        request.setAttribute("commentList", commentList);
        return "commentList.jsp";
	}

}
