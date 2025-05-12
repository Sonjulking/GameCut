package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;

public class SelectAllBoardsAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardVO> list = dao.findAll();
		
		request.setAttribute("list", list);
		System.out.println("게시글 개수: " + list.size());
		return  "/view/board/selectAllBoards.jsp";
	}

}
