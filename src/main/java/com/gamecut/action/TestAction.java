package com.gamecut.action;

import com.gamecut.dao.TestDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class TestAction implements GameCutAction {

    @Override
    public String pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        String viewPage = "test.jsp";
        request.setCharacterEncoding("UTF-8");
        TestDAO dao = new TestDAO();
        request.setAttribute("list", dao.findAll());

        return viewPage;
    }
}
