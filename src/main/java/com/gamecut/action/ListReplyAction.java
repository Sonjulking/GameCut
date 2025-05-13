package com.gamecut.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.CommentDAO;
import com.gamecut.vo.CommentVO;
import com.google.gson.Gson;

public class ListReplyAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int parentCommentNo = Integer.parseInt(request.getParameter("parentCommentNo"));

        CommentDAO dao = new CommentDAO();
        List<CommentVO> replyList = dao.selectReplies(parentCommentNo);

        response.setContentType("application/json; charset=UTF-8");
        String json = new Gson().toJson(replyList);
        response.getWriter().write(json);
        return null;
	}

}
