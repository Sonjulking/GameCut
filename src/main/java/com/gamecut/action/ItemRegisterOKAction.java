package com.gamecut.action;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.ItemDAO;
import com.gamecut.util.FileUtil;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class ItemRegisterOKAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		MultipartRequest multi = FileUtil.uploadFile(request, "itemImage", "item", 1);
		if (multi == null ) {
		    request.setAttribute("success", false);
		    return "view/itemshop/itemRegisterResult.jsp";
		}

		int attachNo = -1;
		System.out.println(multi.getParameter("attachNo"));
		if (multi.getParameter("attachNo") != null) {
		    attachNo = Integer.parseInt(multi.getParameter("attachNo"));
		}

		String name = multi.getParameter("itemName");
		int price = Integer.parseInt(multi.getParameter("itemPrice"));

		ItemDAO dao = new ItemDAO();
		boolean result = dao.insertItem(attachNo, name, price);

		request.setAttribute("success", result);
		return "view/itemshop/itemRegisterResult.jsp";
	}

}
