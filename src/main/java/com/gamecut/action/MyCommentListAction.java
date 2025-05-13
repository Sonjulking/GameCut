package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.CommentDAO;
import com.gamecut.vo.CommentVO;
import com.gamecut.vo.UserVO;

public class MyCommentListAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        CommentDAO dao = new CommentDAO();
        int userNo = ((UserVO) session.getAttribute("loginUSER")).getUserNo();
        ArrayList<CommentVO> list =  dao.selectUserComments(userNo);
        request.setAttribute("commentList", list);
		return "view/myPage/myComment.jsp";
	}

}
