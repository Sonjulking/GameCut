package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.vo.UserVO;

public class ReportBoardFormAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String boardNoStr = request.getParameter("boardNo");
        String targetUserNoStr = request.getParameter("targetUserNo");

        if (boardNoStr == null || boardNoStr.isEmpty() ||
            targetUserNoStr == null || targetUserNoStr.isEmpty()) {
            request.setAttribute("errorMsg", "잘못된 접근입니다.");
            return "view/board/detailBoard.jsp";
        }

        int boardNo = Integer.parseInt(boardNoStr);
        int targetUserNo = Integer.parseInt(targetUserNoStr);

        request.setAttribute("boardNo", boardNo);
        request.setAttribute("targetUserNo", targetUserNo);

        return "/view/report/reportBoard.jsp";
	}

}
