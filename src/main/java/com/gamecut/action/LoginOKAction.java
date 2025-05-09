package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.UserDAO;
import com.gamecut.vo.UserVO;

public class LoginOKAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		
		UserDAO dao = new UserDAO();
		
		int re = dao.isMember(userId, userPwd);
		UserVO vo = dao.getUserById(userId);
		System.out.println("회원닉네임 : " + vo.getUserNickname() );
		HttpSession session = request.getSession();
		request.setAttribute("re", re);
		switch(re) {
		case -1:
			//회원이아님
			System.out.println("회원이존재하지않습니다.");
			break;
		case 0:
			//암호가다름
			System.out.println("암호가다릅니다.");
			break;
		case 1:
			//회원인증완료.
			session.setAttribute("loginUSER", dao.getUserById(userId));
			
			System.out.println("loginUER : " + dao.getUserById(userId));
			System.out.println("회원인증완료");
			break;
		case 2:
			//이미 탈퇴한 회원
			
			break;
			
		}
		return "view/user/loginOK.jsp";
	}

}
