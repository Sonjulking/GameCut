package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;

public class UpdateBoardSubmitAction implements GameCutAction 
{
	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        int boardTypeNo = Integer.parseInt(request.getParameter("boardTypeNo"));
        String boardTitle = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");
        String videoNoStr = request.getParameter("videoNo");
        Integer videoNo = (videoNoStr != null && !videoNoStr.trim().isEmpty()) ? Integer.parseInt(videoNoStr.trim()) : null;

        BoardVO board = new BoardVO();
        board.setBoardNo(boardNo);
        board.setBoardTypeNo(boardTypeNo);
        board.setBoardTitle(boardTitle);
        board.setBoardContent(boardContent);
        board.setVideoNo(videoNo);

        BoardDAO dao = new BoardDAO();
        int result = dao.update(board);

        if (result > 0) {
            return "detailBoard.do?boardNo=" + boardNo;
        } else {
            request.setAttribute("error", "수정 실패");
            return "updateBoard.jsp";

        	}
        }
	}
	
