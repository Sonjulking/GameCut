package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;

public class DeleteBoardAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));

        BoardDAO dao = new BoardDAO();
        int result = dao.delete(boardNo);

        if (result > 0) {
            return "view/board/deleteSuccess.jsp";
        } else {
            request.setAttribute("error", "삭제에 실패했습니다.");
            return "view/board/detailBoard.jsp";
        }
	}

}
