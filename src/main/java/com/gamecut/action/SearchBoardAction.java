package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;

public class SearchBoardAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category = request.getParameter("category");
        String keyword = request.getParameter("keyword");

        BoardDAO dao = new BoardDAO();
        ArrayList<BoardVO> list = dao.search(category, keyword);

        request.setAttribute("list", list);
        return "/view/board/selectAllBoards.jsp";
    }

}
