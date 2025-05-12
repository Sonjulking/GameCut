package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.UserDAO;
import com.gamecut.vo.UserVO;

public class FollowUserAction implements GameCutAction {

	@Override
    public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션에서 로그인한 사용자 정보 가져오기
        HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUSER");
        
        // 팔로우할 사용자 번호 가져오기
        int followNo = Integer.parseInt(request.getParameter("followNo"));
        
        // DAO를 통해 팔로우 처리
        UserDAO userDao = new UserDAO();
        int re = userDao.userFollow(loginUser.getUserNo(), followNo);
        
        // 리다이렉트할 페이지 (다시 팔로우 페이지로 이동)
        return "myFollow.do";
    }
}
