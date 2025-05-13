package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.PointHistoryDAO;
import com.gamecut.vo.PointHistoryVO;
import com.gamecut.vo.UserVO;

public class MyPointHistoryAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		UserVO vo = (UserVO) session.getAttribute("loginUSER");
		PointHistoryDAO dao = new PointHistoryDAO();
		ArrayList<PointHistoryVO> pointHistoryList = dao.getPointHistory(vo.getUserNo());
		request.setAttribute("pointHistoryList", pointHistoryList);
		request.setAttribute("user", vo);
		return "/view/myPage/myPointHistory.jsp";
	}

}
