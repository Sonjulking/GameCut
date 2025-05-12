package com.gamecut.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.PointHistoryDAO;
import com.gamecut.vo.PointHistoryVO;
import com.gamecut.vo.UserVO;

public class ListPointHistoryAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
        int userNo = ((UserVO) session.getAttribute("loginUSER")).getUserNo();

        PointHistoryDAO dao = new PointHistoryDAO();
        List<PointHistoryVO> pointList = dao.getPointHistory(userNo);

        request.setAttribute("pointList", pointList);
        return "view/myPage/listPointHistory.jsp"; // 경로 일치 확인
    }
}