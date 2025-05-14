package com.gamecut.controller;

import com.gamecut.action.GameCutAction;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

@WebServlet("*.do")
public class DispatcherServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    HashMap<String, GameCutAction> map = new HashMap<>();

    public DispatcherServlet() {
        super();
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        //super.init(config);
        String path = config.getServletContext().getRealPath("WEB-INF");
        try {
            Reader reader = new FileReader(path + "/gamecut.properties");
            Properties prop = new Properties();
            prop.load(reader);
            Iterator<Object> iter = prop.keySet().iterator();
            while (iter.hasNext()) {
                String key = (String) iter.next(); // ex) listBook.do
                String clsName = prop.getProperty(key); //LisBooAction 클래스
                Object obj = Class.forName(clsName).newInstance();
                map.put(key, (GameCutAction) obj);
            }
        } catch (Exception e) {
            System.out.println("예외발생 : " + e.getMessage());
        }


    }
//딱 한번만 실행
/*    @Override
    public void init() throws ServletException {
        map.put("listBook.do", new ListBookAction());
        map.put("listBoard.do", new ListBoardAction());
        map.put("detailBoard.do", new DetailBoardAction());
        map.put("insertBoard.do", new InsertBoardAction());
        map.put("insertBoardOK.do", new InsertBoardOKAction());
    }*/

    public void pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        String uri = request.getRequestURI();
        String cmd = uri.substring(uri.lastIndexOf("/") + 1);
        GameCutAction action = map.get(cmd);
        String viewPage = action.pro(request, response);

        if (viewPage == null) {
            return;
        }

        if (viewPage.endsWith(".do")) {
            response.sendRedirect(viewPage);
        } else if (viewPage.endsWith(".jsp")) {
            request.setAttribute("viewPage", viewPage);
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
            dispatcher.forward(request, response);
        } else {
            response.setContentType("application/json;charset=utf-8");
            PrintWriter out = response.getWriter();
            out.print(viewPage);
            out.close();
        }
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        pro(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        pro(request, response);
    }

}