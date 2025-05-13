package com.gamecut.action;

import com.gamecut.dao.FileDAO;
import com.gamecut.vo.FileVO;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SelectBoardVideo implements GameCutAction {
    @Override
    public String pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int videoId = Integer.parseInt(request.getParameter("videId"));
        FileDAO fileDAO = new FileDAO();
        FileVO file = fileDAO.selectFileByVideoId(videoId);
        Gson gson = new Gson();
        String result = gson.toJson(file);
        return result;
    }
}
