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
		dao.purchaseItem(userNo, itemNo);

		return "itemShop.do";
	}

}
