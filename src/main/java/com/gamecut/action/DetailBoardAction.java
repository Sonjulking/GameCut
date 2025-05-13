
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

        // 1. 게시글 조회 (조회수 증가 포함)
        BoardDAO boardDAO = new BoardDAO();
        BoardVO board = boardDAO.findById(boardNo);

        // 2. 로그인한 사용자 가져오기
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUSER");

        // 3. 로그인한 사용자가 이 게시글에 좋아요 눌렀는지 확인
        if (loginUser != null) {
            LikeBoardVO likeVO = new LikeBoardVO();
            likeVO.setUserNo(loginUser.getUserNo());
            likeVO.setBoardNo(boardNo);

            LikeBoardDAO likeDAO = new LikeBoardDAO();
            boolean liked = likeDAO.isLiked(likeVO);

            board.setLikedByCurrentUser(liked); // 💡 BoardVO에 이 필드 꼭 있어야 함
        } else {
            board.setLikedByCurrentUser(false); // 비로그인 유저는 기본 false
        }

        // 4. JSP로 전달
        request.setAttribute("board", board);
        return "view/board/detailBoard.jsp";
    }
   }



