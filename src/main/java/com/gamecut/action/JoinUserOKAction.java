package com.gamecut.action;

import java.io.IOException;	

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;
import com.gamecut.util.FileUtil;
import com.gamecut.vo.UserVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class JoinUserOKAction implements GameCutAction {

    @Override
    public String pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        UserVO vo = new UserVO();
        String userId = request.getParameter("userId");
        String userPwd = request.getParameter("userPwd");
        String userName = request.getParameter("userName");
        String userNickName = request.getParameter("userNickname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        vo.setUserId(userId);
        vo.setUserPwd(userPwd);
        vo.setUserName(userName);
        vo.setUserNickname(userNickName);
        vo.setPhone(phone);
        vo.setEmail(email);

        UserDAO dao = new UserDAO();
        int re = dao.insertUser(vo);
        request.setAttribute("re", re);

        return "view/user/joinUserOK.jsp";
    }

}
