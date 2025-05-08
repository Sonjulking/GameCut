package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;
import com.gamecut.vo.UserVO;

public class MyPageAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userNo = 1;
		UserDAO dao = new UserDAO();
		request.setAttribute("user", dao.selectUser(userNo));
		return "/view/myPage.jsp";
	}

}
