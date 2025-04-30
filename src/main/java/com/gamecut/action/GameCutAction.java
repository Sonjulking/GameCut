package com.gamecut.action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface GameCutAction {
    String pro(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException; //view페이지를 반환
}
