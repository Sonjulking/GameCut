package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;

public class UpdateBoardFormAction implements GameCutAction 
{
	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));

        BoardDAO dao = new BoardDAO();
        BoardVO board = dao.findById(boardNo);

        request.setAttribute("board", board);
        return "view/board/updateBoard.jsp";
        }
	}
	
