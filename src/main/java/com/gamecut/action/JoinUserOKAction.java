package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.UserDAO;
import com.gamecut.vo.UserVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class JoinUserOKAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		UserVO vo = new UserVO();
		String path = request.getRealPath("upload");
		MultipartRequest multi = new MultipartRequest(request, 
				path,1024*1024*10,"utf-8",new DefaultFileRenamePolicy());
		String userId = multi.getParameter("userId");
		String userPwd = multi.getParameter("userPwd");
		String userName = multi.getParameter("userName");
		String userNickName = multi.getParameter("userNickname");
		String phone = multi.getParameter("phone");
		String email = multi.getParameter("email");
		String ProfileName = null;
		ProfileName = multi.getOriginalFileName("profile");
		vo.setUserId(userId);
		vo.setUserPwd(userPwd);
		vo.setUserName(userName);
		vo.setUserNickname(userNickName);
		vo.setPhone(phone);
		vo.setEmail(email);
		if(ProfileName!= null && !ProfileName.equals("")) {
			//프로필파일업로드시
			request.setAttribute("profileName", ProfileName);
			
		}
		
		UserDAO dao = new UserDAO();
		int re =dao.insertUser(vo);
		request.setAttribute("re", re);

		return "view/user/joinUserOK.jsp";
	}

}
