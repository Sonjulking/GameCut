package com.gamecut.action;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.gamecut.dao.FileDAO;
import com.gamecut.dao.PhotoDAO;
import com.gamecut.dao.UserDAO;

import com.gamecut.util.FileUtil;

import com.gamecut.vo.FileVO;
import com.gamecut.vo.UserVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;


public class MyPageUpdateOKAction implements GameCutAction {


    @Override
    public String pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        MultipartRequest multi = FileUtil.uploadFile(request, "originalFileName", "profile", 1);
        UserVO u = new UserVO();
        UserDAO userDao = new UserDAO();
        FileDAO fileDao = new FileDAO();
        u.setUserName(multi.getParameter("userName"));
        u.setUserNo(Integer.parseInt(multi.getParameter("userNo")));
        u.setUserNickname(multi.getParameter("userNickname"));
        u.setPhone(multi.getParameter("phone"));
        u.setEmail(multi.getParameter("email"));
        int oldPhotoNo = Integer.parseInt(multi.getParameter("oldPhotoNo"));
        FileVO fvo = fileDao.selectProfileFileByUserId(u.getUserNo()); // 기존의 프로필 fileVO
//        if(multi.getParameter("isProfileDeleted").equals("true")) {
//        	u.setPhotoNo(0);
//        } else if(multi.getParameter("oldPhotoNo") != null && Integer.parseInt(multi.getParameter("oldPhotoNo")) != 0) {
//        	u.setPhotoNo(Integer.parseInt((multi.getParameter("oldPhotoNo"))));
//        } else {
//        	u.setPhotoNo((int)request.getAttribute("photoNo"));
//        }
        if(multi.getParameter("isProfileDeleted").equals("false")) {
        	if(multi.getOriginalFileName("originalFileName") != null && !multi.getOriginalFileName("originalFileName").equals("")) {
        		FileUtil.deleteFile(u.getUserNo(), fvo.getAttachNo(), fvo.getRealPath());
        		u.setPhotoNo((int)(request.getAttribute("photoNo")));
        		System.out.println("프사 넣었을때 photono : " + request.getAttribute("photoNo"));
        	} else {
        		u.setPhotoNo(oldPhotoNo);
        	}
        } else {
        	FileUtil.deleteFile(u.getUserNo(), fvo.getAttachNo(), fvo.getRealPath());
        	u.setPhotoNo(0);
        }
        userDao.updateUser(u);
        fvo = fileDao.selectProfileFileByUserId(u.getUserNo());
        HttpSession session = request.getSession();
        session.setAttribute("profileUrl", fvo.getFileUrl());
        return "myPage.do";
    }

}
