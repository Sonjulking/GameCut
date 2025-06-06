package com.gamecut.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.CommentDAO;
import com.gamecut.vo.CommentVO;
import com.google.gson.Gson;

public class ListParentCommentAction implements GameCutAction {

    @Override
    public String pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        System.out.println("ListParentCommentAction 동작!");
        // TODO Auto-generated method stub
        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        System.out.println("boardNo : " +  boardNo);
        CommentDAO dao = new CommentDAO();
        List<CommentVO> commentList = dao.selectParentComments(boardNo);
        ArrayList<CommentVO> resultList = new ArrayList<>();

        for (CommentVO comment : commentList) {
            resultList.add(comment);
        }
        System.out.println(commentList);
        Gson gson = new Gson();
        String jsonResult = gson.toJson(resultList);
        System.out.println("JSON 결과: " + jsonResult); // 콘솔에 출력
        return jsonResult; // JSP Ajax에서 받을 수 있는 JSON

    }

}
