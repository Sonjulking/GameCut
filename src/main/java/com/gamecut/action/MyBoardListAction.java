package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;
import com.gamecut.vo.UserVO;

public class MyBoardListAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		HttpSession session = request.getSession();
		UserVO vo = (UserVO) session.getAttribute("loginUSER");
		ArrayList<BoardVO> boardList = dao.search("nickname", vo.getUserNickname());
		request.setAttribute("list", boardList);
		return "/view/myPage/myBoard.jsp";
	}

}
