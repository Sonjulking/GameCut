package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;

public class InsertBoardAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		int boardTypeNo = Integer.parseInt(request.getParameter("boardTypeNo"));
		String boardTitle = request.getParameter("boardTitle");
		String boardContent = request.getParameter("boardContent");
		String videoNoStr = request.getParameter("videoNo"); 
		Integer videoNo = null;
		if (videoNoStr != null && !videoNoStr.isEmpty()) {
		    videoNo = Integer.parseInt(videoNoStr);
		}
		
		BoardVO vo = new BoardVO();
		vo.setUserNo(userNo);
		vo.setBoardTypeNo(boardTypeNo);
		vo.setBoardTitle(boardTitle);
		vo.setBoardContent(boardContent);
		vo.setVideoNo(videoNo);
		
		BoardDAO dao = new BoardDAO();
		int result = dao.insert(vo);
		
		if(result > 0) {
			return "selectAllBoards.do";
		}else {
			request.setAttribute("error", "등록 실패");
			return "view/board/detailBoard.jsp";
		}

	}

}
