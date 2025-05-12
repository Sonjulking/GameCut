package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.ReportVO;

public class ReportDAO {
	public ArrayList<ReportVO> selectReportByUserNo(int userNo) {
		ArrayList<ReportVO> reportList = new ArrayList<ReportVO>();
		String sql = "select report_no, user_no, board_no, report_content, report_type, report_date from report where user_no = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				ReportVO vo = new ReportVO(rs.getInt("report_no"), rs.getInt("user_no"), rs.getInt("board_no"), rs.getString("report_content"), rs.getString("report_type"), rs.getDate("report_date"));
				reportList.add(vo);
			}
			ConnectionProvider.close(conn, pstmt, rs);	
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return reportList;
	}
	
	public int insert(ReportVO report) {
	int result = 0;
    Connection conn = null;
    PreparedStatement pstmt = null;

    String sql = "INSERT INTO REPORT (REPORT_NO, USER_NO, BOARD_NO, REPORT_CONTENT, REPORT_TYPE, REPORT_DATE) "
               + "VALUES (REPORT_SEQ.NEXTVAL, ?, ?, ?, ?, SYSDATE)";

    try {
        conn = ConnectionProvider.getConnection();
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, report.getUserNo());
        pstmt.setInt(2, report.getBoardNo());
        pstmt.setString(3, report.getReportContent());
        pstmt.setString(4, report.getReportType());

        result = pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        ConnectionProvider.close(conn, pstmt);
    }

    return result;
}
}
