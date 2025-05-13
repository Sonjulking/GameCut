package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.ItemDAO;
import com.gamecut.vo.FileVO;
import com.gamecut.vo.ItemVO;
import com.gamecut.vo.UserVO;

public class MyItemListAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ItemDAO dao = new ItemDAO();
		UserVO vo = (UserVO) session.getAttribute("loginUSER");
		ArrayList<ItemVO> itemList = dao.selectItemByUserNo(vo.getUserNo());
		ArrayList<FileVO> imgList = new ArrayList<FileVO>();
		for(ItemVO item : itemList) {
			imgList.add(dao.selectItemImg(item.getItemNo()));
		}
		request.setAttribute("userItem", itemList);
		request.setAttribute("file", imgList);
		return "view/myPage/myItem.jsp";
	}

}
