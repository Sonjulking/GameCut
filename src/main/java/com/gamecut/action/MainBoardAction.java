package com.gamecut.action;

import com.gamecut.dao.BoardDAO;
import com.gamecut.dao.CommentDAO;
import com.gamecut.dao.FileDAO;
import com.gamecut.vo.BoardVO;
import com.gamecut.vo.BoardWithFileVO;
import com.gamecut.vo.CommentVO;
import com.gamecut.vo.FileVO;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

public class MainBoardAction implements GameCutAction {
    @Override
    public String pro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BoardDAO dao = new BoardDAO();
        FileDAO fileDAO = new FileDAO();
        CommentDAO commentDAO = new CommentDAO();
        ArrayList<BoardVO> boardList = dao.findTop5();
        ArrayList<BoardWithFileVO> resultList = new ArrayList<>();

        for (BoardVO board : boardList) {
            FileVO file = fileDAO.selectFileByVideoId(board.getVideoNo());
            ArrayList<CommentVO> commentVOList = commentDAO.selectParentComments(board.getBoardNo());
            BoardWithFileVO boardWithFileVO = new BoardWithFileVO();
            boardWithFileVO.setBoard(board);
            boardWithFileVO.setCommentVOList(commentVOList);
            boardWithFileVO.setFile(file);
            resultList.add(boardWithFileVO);
        }

        Gson gson = new Gson();
        System.out.println(gson.toJson(resultList));
        return gson.toJson(resultList); // JSP Ajax에서 받을 수 있는 JSON
    }
}
