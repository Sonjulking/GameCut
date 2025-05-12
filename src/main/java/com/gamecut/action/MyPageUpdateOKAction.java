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
        String path = request.getRealPath("upload");
        System.out.println("path : " + path);
        MultipartRequest multi = FileUtil.uploadFile(request, "originalFileName", "profile", 1);
        UserVO u = new UserVO();
        FileVO f = new FileVO();
        UserDAO userDao = new UserDAO();
        FileDAO fileDao = new FileDAO();
        PhotoDAO photoDao = new PhotoDAO();
        u.setUserName(multi.getParameter("userName"));
        u.setUserNo(Integer.parseInt(multi.getParameter("userNo")));
        u.setUserNickname(multi.getParameter("userNickname"));
        u.setPhone(multi.getParameter("phone"));
        u.setEmail(multi.getParameter("email"));
        if (request.getAttribute("photoNo") != null) {
            u.setPhotoNo((int) request.getAttribute("photoNo"));
        }
        System.out.println(u);
        userDao.updateUser(u);
        FileVO fvo = fileDao.selectProfileFileByUserId(u.getUserNo());
        HttpSession session = request.getSession();
        session.setAttribute("profileUrl", fvo.getFileUrl());
        return "myPage.do";
    }

}
