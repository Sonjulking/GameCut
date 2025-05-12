package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.ReportDAO;
import com.gamecut.vo.ReportVO;
import com.gamecut.vo.UserVO;

public class MyReportAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		UserVO vo = (UserVO) session.getAttribute("loginUSER");
		ReportDAO dao = new ReportDAO();
		ArrayList<ReportVO> reportList = dao.selectReportByUserNo(vo.getUserNo()); 
		request.setAttribute("reportList", reportList);
		return "view/myPage/myReport.jsp";
	}

}
