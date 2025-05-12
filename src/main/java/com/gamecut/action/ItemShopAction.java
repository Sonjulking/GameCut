package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.ItemDAO;
import com.gamecut.vo.ItemVO;
import com.gamecut.vo.UserVO;

public class ItemShopAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		UserVO loginUser = (UserVO) session.getAttribute("loginUSER");
        if (loginUser == null) {
            response.sendRedirect("login.do");
            return null;
        }

        int userNo = loginUser.getUserNo();
        String userRole = loginUser.getRole();

        ItemDAO dao = new ItemDAO();
        ArrayList<ItemVO> items = dao.selectAllItems();

        ArrayList<Integer> ownedItemNos = dao.getOwnedItemNos(userNo);

        request.setAttribute("items", items);
        request.setAttribute("ownedItemNos", ownedItemNos);
        request.setAttribute("userPoint", loginUser.getUserPoint());
        request.setAttribute("userRole", userRole);


        return "view/itemshop/itemShop.jsp";
	}

}
