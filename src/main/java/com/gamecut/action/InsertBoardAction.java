package com.gamecut.action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.util.FileUtil;
import com.gamecut.vo.BoardVO;
import com.oreilly.servlet.MultipartRequest;

public class InsertBoardAction implements GameCutAction {

    @Override
    public String pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        MultipartRequest multi = FileUtil.uploadFile(request, "video", "board", 1);
        int userNo = Integer.parseInt(multi.getParameter("userNo"));
        int boardTypeNo = Integer.parseInt(multi.getParameter("boardTypeNo"));
        System.out.println("boardTypeNo : " + boardTypeNo);
        String boardTitle = multi.getParameter("boardTitle");
        String boardContent = multi.getParameter("boardContent");


        BoardVO vo = new BoardVO();
        vo.setUserNo(userNo);
        vo.setBoardTypeNo(boardTypeNo);
        vo.setBoardTitle(boardTitle);
        vo.setBoardContent(boardContent);
        if (request.getAttribute("videoNo") != null) {
            vo.setVideoNo((int) request.getAttribute("videoNo"));
        }

        BoardDAO dao = new BoardDAO();
        int result = dao.insert(vo);

        if (result > 0) {
            return "selectAllBoards.do";
        } else {
            request.setAttribute("error", "등록 실패");
            return "view/board/detailBoard.jsp";
        }

    }

}
