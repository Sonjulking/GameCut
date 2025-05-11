package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;

public class UpdatePasswordOKAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		String newPassword = request.getParameter("newUserPassword");
		String userID =  request.getParameter("userID");
		System.out.println("새로운비번 : " + newPassword);
		System.out.println("받아온 유저아이디 : " + userID);
		UserDAO dao = new UserDAO();
		int re = dao.updateUserPasswordByUserid(userID, newPassword);
		request.setAttribute("re", re);
		return "view/myPage/updatePasswordOK.jsp";
	}

}
