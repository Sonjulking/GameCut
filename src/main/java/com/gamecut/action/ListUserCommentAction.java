package com.gamecut.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.CommentDAO;
import com.gamecut.vo.CommentVO;

public class ListUserCommentAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
        int userNo = (int) session.getAttribute("loginUserNo"); // 또는 파라미터

        CommentDAO dao = new CommentDAO();
        List<CommentVO> myComments = dao.selectUserComments(userNo);

        request.setAttribute("myComments", myComments);
        return "mypageComment.jsp";
	}

}
