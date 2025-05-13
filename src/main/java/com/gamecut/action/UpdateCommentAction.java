package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.CommentDAO;
import com.gamecut.vo.CommentVO;
import com.gamecut.vo.UserVO;

public class UpdateCommentAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
	    UserVO loginUser = (UserVO) session.getAttribute("loginUSER");

	    int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	    String content = request.getParameter("commentContent");

	    // 댓글 작성자 확인
	    CommentVO original = new CommentDAO().getCommentByNo(commentNo);
	    if (original == null || original.getUserNo() != loginUser.getUserNo()) {
	        response.setStatus(HttpServletResponse.SC_FORBIDDEN); // 권한 없음
	        return null;
	    }

	    CommentVO vo = new CommentVO();
	    vo.setCommentNo(commentNo);
	    vo.setCommentContent(content);

	    new CommentDAO().updateComment(vo);
	    return "commentResult.jsp";
	}

}
