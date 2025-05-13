package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.ItemDAO;

public class ItemShopOKAction implements GameCutAction{

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		int userNo = Integer.parseInt(request.getParameter("userNo"));

		ItemDAO dao = new ItemDAO();


		// 보유중인 아이템 중복 구매 방지
		if(dao.hasUserItem(userNo, itemNo)) {
			System.out.println("이미 구매한 아이템입니다.");
			return "itemShop.do";
		}

		int price = dao.getItemPrice(itemNo);
	    int userPoint = new ItemDAO().getUserPoint(userNo);

		if (userPoint < price) {
	        System.out.println("관리자님의 포인트가 부족합니다.");
	        response.getWriter().write("NOT_ENOUGH_POINT");
	        return null;
	    }

		dao.purchaseItem(userNo, itemNo);
		return "itemShop.do";
	}

}
