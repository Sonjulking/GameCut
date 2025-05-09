package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.FileDAO;
import com.gamecut.dao.UserDAO;
import com.gamecut.vo.UserVO;

public class MyPageAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		UserVO vo = (UserVO) session.getAttribute("loginUSER");
		int userNo = vo.getUserNo();
		UserDAO userDao = new UserDAO();
		FileDAO fileDao = new FileDAO();
		request.setAttribute("user", userDao.selectUser(userNo));
		request.setAttribute("file", fileDao.selectProfileFileByUserId(userNo));
		return "/view/mypage/myPage.jsp";
	}
}
