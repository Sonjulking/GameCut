package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;

public class UpdateBoardAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        int boardTypeNo = Integer.parseInt(request.getParameter("boardTypeNo"));
        String boardTitle = request.getParameter("boardTitle");
        String boardContent = request.getParameter("boardContent");
        String videoNoStr = request.getParameter("videoNo");

        Integer videoNo = null;
        if (videoNoStr != null && !videoNoStr.trim().isEmpty()) {
            videoNo = Integer.parseInt(videoNoStr);
        }

        BoardVO board = new BoardVO();
        board.setBoardTypeNo(boardTypeNo);
        board.setBoardNo(boardNo);
        board.setBoardTitle(boardTitle);
        board.setBoardContent(boardContent);
        board.setVideoNo(videoNo); // 선택사항

        BoardDAO dao = new BoardDAO();
        int result = dao.update(board);

        if (result > 0) {
            request.setAttribute("boardNo", boardNo);
            return "view/board/updateSuccess.jsp";
        } else {
            request.setAttribute("error", "수정에 실패했습니다.");
            request.setAttribute("board", board);
            return "view/board/updateBoard.jsp";
        }

	}

}
