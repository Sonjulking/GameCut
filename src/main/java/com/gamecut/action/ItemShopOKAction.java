package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.ItemDAO;
import com.gamecut.dao.UserDAO;

public class ItemShopOKAction implements GameCutAction{

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		int userNo = Integer.parseInt(request.getParameter("userNo"));

		ItemDAO dao = new ItemDAO();
		System.out.println(itemNo);
		System.out.println(userNo);

	    // 중복 구매 체크
        if (dao.hasUserItem(userNo, itemNo)) {
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write("ALREADY_OWNED");
            return null;
        }

        // 가격 조회
        int price = dao.getItemPrice(itemNo);
        // 포인트 보유량 체크
        int userPoint = dao.getUserPoint(userNo);
        if (userPoint < price) {
            response.setContentType("text/plain; charset=UTF-8");
            response.getWriter().write("NOT_ENOUGH_POINT");
            return null;
        }

        // 실제 구매 처리
        dao.purchaseItem(userNo, itemNo);

        HttpSession session = request.getSession();
        UserDAO userDao = new UserDAO();
        session.setAttribute("loginUSER", userDao.selectUser(userNo));

        // 성공 리턴
        response.setContentType("text/plain; charset=UTF-8");
        response.getWriter().write("SUCCESS");
        return null;
    }

}