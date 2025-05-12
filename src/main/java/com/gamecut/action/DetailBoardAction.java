package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.BoardDAO;
import com.gamecut.dao.LikeBoardDAO;
import com.gamecut.vo.BoardVO;
import com.gamecut.vo.LikeBoardVO;
import com.gamecut.vo.UserVO;

public class DetailBoardAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));

        BoardDAO boardDAO = new BoardDAO();
        BoardVO board = boardDAO.findById(boardNo); 

        HttpSession session = request.getSession();
        UserVO loginUSER = (UserVO) session.getAttribute("loginUSER");

//        if (loginUSER != null) {
//            LikeBoardVO likeVO = new LikeBoardVO();
//            likeVO.setUserNo(loginUSER.getUserNo());
//            likeVO.setBoardNo(boardNo);
//
//            LikeBoardDAO likeDAO = new LikeBoardDAO();
//            boolean liked = likeDAO.isLiked(likeVO);
//            board.setLikedByCurrentUser(liked);  
//        } else {
//            board.setLikedByCurrentUser(false); 
//        }

        request.setAttribute("board", board); 
        return "/view/board/detailBoard.jsp";
    }

}
