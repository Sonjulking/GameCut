package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.gamecut.dao.BoardDAO;
import com.gamecut.util.FileUtil;
import com.gamecut.vo.BoardVO;
import com.gamecut.vo.UserVO;
import com.oreilly.servlet.MultipartRequest;

public class InsertBoardAction implements GameCutAction {

    @Override
    public String pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
    	
    	HttpSession session = request.getSession();
        UserVO loginUser = (UserVO) session.getAttribute("loginUSER");

        if (loginUser == null) {
            request.setAttribute("error", "로그인이 필요합니다.");
            return "view/user/login.jsp";
        }

        MultipartRequest multi = FileUtil.uploadFile(request, "video", "board", 1);
        String boardTypeStr = multi.getParameter("boardTypeNo");
        String boardTitle = multi.getParameter("boardTitle");
        String boardContent = multi.getParameter("boardContent");

        if (boardTypeStr == null || boardTypeStr.trim().isEmpty()) {
            request.setAttribute("error", "게시판 종류를 선택해주세요.");
            return "view/board/insertBoard.jsp";
        }

        int userNo = loginUser.getUserNo();
        int boardTypeNo = Integer.parseInt(boardTypeStr);


        BoardVO vo = new BoardVO();
        vo.setUserNo(userNo);
        vo.setBoardTypeNo(boardTypeNo);
        vo.setBoardTitle(boardTitle);
        vo.setBoardContent(boardContent);
        if (request.getAttribute("videoNo") != null) {
            vo.setVideoNo((int) request.getAttribute("videoNo"));
        }

        BoardDAO dao = new BoardDAO();
        int boardNo = dao.insert(vo);

        if (boardNo > 0) {
            request.setAttribute("boardNo", boardNo);
            return "view/board/insertSuccess.jsp";
        } else {
            request.setAttribute("error", "게시글 등록에 실패했습니다.");
            return "view/board/insertBoard.jsp";
        }


    }

}
