package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;

public class UserInfoCheckAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String userId = request.getParameter("userId");
		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		UserDAO dao = new UserDAO();
		System.out.println("받아온 정보 유저아이디 : " + userId + "이름 : " + userName + "이메일 : " + userEmail);
		int re = dao.checkUserInfo(userId, userName, userEmail);
		//request.setAttribute("re", re);
		return "{\"result\":"+re+"}";
	}

}
