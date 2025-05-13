package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.vo.UserVO;

public class InsertBoardFormAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUSER");

        if (loginUser == null) {
            request.setAttribute("error", "로그인이 필요합니다.");
            return "view/user/login.jsp";  // 로그인 페이지로 보내거나 에러 처리
        }

        // 파라미터로 전달된 게시판 타입 번호 가져오기 (자유:1, 팁:2, 영상:3)
        String boardTypeNo = request.getParameter("boardTypeNo");

        request.setAttribute("boardTypeNo", "1"); // 기본값 자유게시판
        return "view/board/insertBoard.jsp"; 
	}

}
