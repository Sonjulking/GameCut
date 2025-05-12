package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.FileDAO;
import com.gamecut.dao.UserDAO;
import com.gamecut.vo.UserVO;

public class MyFollowAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO userDao = new UserDAO();
		FileDAO fileDao = new FileDAO();
		HttpSession session = request.getSession();
		UserVO vo = (UserVO) session.getAttribute("loginUSER");
		
		ArrayList<UserVO> followerList =  userDao.selectFollower(vo.getUserNo());
		ArrayList<UserVO> followList =  userDao.selectFollow(vo.getUserNo());
		request.setAttribute("followerList", followerList);
		request.setAttribute("followList", followList);
		ArrayList<String> followImgUrlList = new ArrayList<String>();
		ArrayList<String> followerImgUrlList = new ArrayList<String>();
		for(UserVO u : followList) {
			System.out.println(u);
			followImgUrlList.add((fileDao.selectProfileFileByUserId(u.getUserNo())).getFileUrl());
		}
		for(UserVO u : followerList) {
			System.out.println(u);
			followerImgUrlList.add((fileDao.selectProfileFileByUserId(u.getUserNo())).getFileUrl());
		}
		request.setAttribute("followImgUrlList", followImgUrlList);
		request.setAttribute("followerImgUrlList", followerImgUrlList);
		return "view/myPage/myFollow.jsp";
	}

}
