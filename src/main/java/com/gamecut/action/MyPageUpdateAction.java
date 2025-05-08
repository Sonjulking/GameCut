package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.FileDAO;
import com.gamecut.dao.UserDAO;

public class MyPageUpdateAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userNo = 1;
		UserDAO uDao = new UserDAO();
		FileDAO fDao = new FileDAO();
		request.setAttribute("user", uDao.selectUser(userNo));
		request.setAttribute("file", fDao.selectProfileFileByUserId(userNo));
		return "/view/myPage/updateMyPage.jsp";
	}

}
