package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;

public class DetailBoardAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int BoardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDAO dao = new BoardDAO();
		BoardVO board = dao.findById(BoardNo);
		request.setAttribute("board", board);	
		return "detailBoard.jsp";
	}

}
