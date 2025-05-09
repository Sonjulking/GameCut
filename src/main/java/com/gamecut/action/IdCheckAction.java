package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;

public class IdCheckAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		UserDAO dao = new UserDAO();
		int re = dao.isAlreadyId(id);
		//request.setAttribute("re", re);
		return "{\"result\":"+re+"}";
	}

}
