package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        MultipartRequest multi = FileUtil.uploadFile(request, "originalFileName");
        UserVO u = new UserVO();
        FileVO f = new FileVO();
        u.setUserNo(Integer.parseInt(multi.getParameter("userNo")));
        u.setUserNickname(multi.getParameter("userNickname"));
        u.setPhone(multi.getParameter("phone"));
        u.setEmail(multi.getParameter("email"));
        String oldFileName = multi.getParameter("oldFileName");
        if (1 == 1) {
            if (multi.getParameter("originalFileName") != null && !multi.getParameter("originalFileName").equals("")) {
                f.setOriginalFileName(multi.getParameter("originalFileName"));
            } else {
                f.setOriginalFileName(oldFileName);
            }
        }
        f.setFileUrl(path);
        return null;
    }
}
