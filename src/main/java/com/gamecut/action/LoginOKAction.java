package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.UserDAO;

public class LoginOKAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		UserDAO dao = new UserDAO();
		int re = dao.isMember(userId, userPwd);
		request.setAttribute("re", re);
		switch(re) {
		case -1:
			//회원이아님
			
			break;
		case 0:
			//암호가다름
			
			break;
		case 1:
			//회원인증완료.
			HttpSession session = request.getSession();
			session.setAttribute("loginUSER", dao.getMember(userId));
			break;
		}
		return "view/user/loginOK.jsp";
	}

}
