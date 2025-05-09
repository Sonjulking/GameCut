package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;

public class NickNameCheckAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String nickName = request.getParameter("nickName");
		System.out.println("양식에서 받아온 닉네임 : " + nickName);
		UserDAO dao = new UserDAO();
		int re = dao.isAlreadyNickname(nickName);
		System.out.println("re : " + re);
		return "{\"result\":"+re+"}";

	}

}
