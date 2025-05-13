package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.vo.UserVO;

public class MyCommentListAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        int userNo = ((UserVO) session.getAttribute("loginUSER")).getUserNo();
        
		return "view/myPage/myComment.jsp";
	}

}
