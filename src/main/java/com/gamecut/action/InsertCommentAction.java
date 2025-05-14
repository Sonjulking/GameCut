package com.gamecut.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

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
	    new PointHistoryDAO().addPoint(userNo, (parentNo == 0 ? "댓글 작성" : "대댓글 작성"), (parentNo == 0 ? 10 : 5));

	    // DispatcherServlet이 문자열 응답을 JSON으로 인식하도록 처리
	    return "\"success\""; // JSON 형식의 문자열 (주의: 따옴표 포함된 상태)
	}
}
