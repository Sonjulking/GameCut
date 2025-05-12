package com.gamecut.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.BoardDAO;
import com.gamecut.vo.BoardVO;

public class GetBoardListAjaxAction implements GameCutAction {

	@Override
	public String pro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int type = Integer.parseInt(request.getParameter("type"));

	    BoardDAO dao = new BoardDAO();
	    ArrayList<BoardVO> list = dao.findByType(type);

	    response.setContentType("text/html; charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    for (BoardVO b : list) {
	        out.printf("<tr>");
	        out.printf("<td><a href='detailBoard.do?boardNo=%d'>%s</a></td>", b.getBoardNo(), b.getBoardTitle());
	        out.printf("<td>%s</td>", b.getUserNickname());
	        out.printf("<td>%s</td>", b.getBoardCreateDate());
	        out.printf("<td>%d</td>", b.getBoardCount());
	        out.printf("<td>%d</td>", b.getBoardLike());
	        out.printf("</tr>");
	    }

	    return null; 
	}

}
