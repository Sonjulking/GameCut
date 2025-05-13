package com.gamecut.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gamecut.dao.ReportDAO;
import com.gamecut.vo.ReportVO;

public class ReportBoardAction implements GameCutAction {

    @Override
    public String pro(HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {
    	request.setCharacterEncoding("UTF-8");

        int boardNo = Integer.parseInt(request.getParameter("boardNo"));
        int targetUserNo = Integer.parseInt(request.getParameter("targetUserNo"));
        String reportType = request.getParameter("reportType");
        String reportContent = request.getParameter("reportContent");

        ReportVO report = new ReportVO();
        report.setBoardNo(boardNo);
        report.setUserNo(targetUserNo); // 신고 대상
        report.setReportType(reportType);
        report.setReportContent(reportContent);

        ReportDAO dao = new ReportDAO();
        int result = dao.insert(report);

        if (result > 0) {
            return "view/board/reportSuccess.jsp";
        } else {
            request.setAttribute("error", "신고에 실패했습니다.");
            return "view/board/detailBoard.jsp";
        }
    }
}
