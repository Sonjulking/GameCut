package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.PointHistoryDAO;

public class AddPointAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 request.setCharacterEncoding("utf-8");

	        int userNo = Integer.parseInt(request.getParameter("userNo"));
	        String source = request.getParameter("pointSource");
	        int amount = Integer.parseInt(request.getParameter("pointAmount")); // 양수: 지급, 음수: 차감

	        PointHistoryDAO dao = new PointHistoryDAO();
	        int result = dao.addPoint(userNo, source, amount);

	        response.getWriter().print(result > 0 ? "success" : "fail");
		return null;
	}

}
