package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.ReportVO;

public class ReportDAO {
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
