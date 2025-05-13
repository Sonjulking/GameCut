package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.ItemDAO;
import com.gamecut.dao.UserDAO;
import com.gamecut.vo.ItemVO;
import com.gamecut.vo.UserVO;

public class ItemShopAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("itemShopAction 접근완료");
		HttpSession session = request.getSession();
		UserVO user = (UserVO) session.getAttribute("loginUSER");

		if (user == null) {
            response.sendRedirect("login.do");
            return null;
        }

        int userNo = user.getUserNo();
        System.out.println("userNO : " + userNo);
        String userRole = user.getRole();

        ItemDAO dao = new ItemDAO();
        ArrayList<ItemVO> items = dao.selectAllItems();
        ArrayList<Integer> ownedItemNos = dao.getOwnedItemNos(userNo);

        request.setAttribute("items", items);
        request.setAttribute("ownedItemNos", ownedItemNos);
        request.setAttribute("userNo", userNo);
        request.setAttribute("userPoint", user.getUserPoint());
        request.setAttribute("userRole", userRole);

        int refreshedPoint = dao.getUserPoint(user.getUserNo());
        request.setAttribute("userPoint", refreshedPoint);


        return "view/itemshop/itemShop.jsp";
	}

}
