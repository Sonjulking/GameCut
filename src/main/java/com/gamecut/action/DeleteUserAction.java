package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;

public class DeleteUserAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userNo = 1;
		UserDAO dao = new UserDAO();
		int re = dao.deleteUser(userNo);
		
		if(re == -1) {
			System.out.println("삭제 실패");
		} else {
			System.out.println("삭제 성공");
		}
		return "/view/main/main.jsp";
	}

}
