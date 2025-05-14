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


		request.setAttribute("success", true);
		return "view/itemshop/itemRegisterResult.jsp";
	}

}