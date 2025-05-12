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
//		String oldFileName = multi.getParameter("oldFileName");
//		String oldFileUrl = multi.getParameter("oldFileUrl");
//		if(multi.getParameter("originalFileName") == null || multi.getParameter("originalFileName").equals("")) { // 수정하기 위해 넣은 프로필 사진이 없음
//			if(multi.getParameter("oldFileName")!= null || !multi.getParameter("oldFileName").equals("")) { // 원래 있었음
//				// 파일 삭제구문 오면 넣기
////				File file = new File(path + "/" + oldFileUrl);
////				file.delete();
//				int photoNo = userDao.selectUser(Integer.parseInt(multi.getParameter("userNo"))).getPhotoNo();
//				int re = photoDao.deletePhotoById(photoNo);
//			}
//		} else { // 사진을 넣을거임
//			if(multi.getParameter("oldFileName")!= null || !multi.getParameter("oldFileName").equals("")) { // 있던걸 수정
//				// 파일을 수정하는 구문
//				
//			} else { // 없었는데 넣을경우
//				// 파일 넣는구문
//				
//				// 사진 넣는구문
//				
//				// 수정구문
//				
//			}
//		}
        FileVO fvo = fileDao.selectProfileFileByUserId(u.getUserNo());
        if (multi.getParameter("isProfileDeleted").equals("true")) {
            FileUtil.deleteFile(fvo.getAttachNo(), fvo.getRealPath());
        }


        HttpSession session = request.getSession();
        session.setAttribute("profileUrl", fvo.getFileUrl());
        return "/view/myPage/myPage.jsp";
    }

}
