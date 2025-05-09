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
		System.out.println("들어옴");
		String userNickname = request.getParameter("userNickname");
		int userNo = 0;
		if(request.getParameter("userNo")!=null) {
			userNo = Integer.parseInt(request.getParameter("userNo"));
		}
		UserDAO dao = new UserDAO();
		int re = 0;
		if(userNo == 0) {
			re = dao.isAlreadyNickname(userNickname);
		}else {
			if(!(dao.selectUser(userNo).getUserNickname()).equals(userNickname)) {
				re = dao.isAlreadyNickname(userNickname);
			}
		}
		
		System.out.println(re);
		return "{\"result\":"+re+"}";
	}

}
