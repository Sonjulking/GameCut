package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;

public class NicknameCheckAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String userNickname = request.getParameter("userNickname");
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		UserDAO dao = new UserDAO();
		int re = dao.isAlreadyNickname(userNickname, userNo);
		System.out.println(re);
		return "{\"result\":"+re+"}";
	}

}
