package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.vo.UserVO;

public class ItemRegisterAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		UserVO user = (UserVO)session.getAttribute("loginUSER");

		if(user == null || !"ROLE_ADMIN".equals(user.getRole())) {
			return "itemShop.do";
		}

		return "view/itemshop/itemRegister.jsp";
	}

}
