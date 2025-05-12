package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.PointHistoryVO;

public class PointHistoryDAO {
	 // 포인트 지급 또는 차감 기록 저장
    public int addPoint(int userNo, String pointSource, int amount) {
        int result = 0;
        String sql = "insert into point_history (point_history_no, user_no, point_date, point_amount, point_source) "
                   + "values (SEQ_GTR_HISTORY_NO.NEXTVAL, ?, SYSDATE, ?, ?)";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userNo);
            pstmt.setInt(2, amount); // 양수: 지급, 음수: 차감
            pstmt.setString(3, pointSource);

            result = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    // 특정 사용자 포인트 내역 전체 조회
    public ArrayList<PointHistoryVO> getPointHistory(int userNo) {
        ArrayList<PointHistoryVO> list = new ArrayList<>();
        String sql = "select point_history_no, user_no, point_date, point_amount, point_source from point_history where user_no = ? order by point_date desc";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userNo);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PointHistoryVO vo = new PointHistoryVO();
                vo.setPointHistoryNo(rs.getInt("point_history_no"));
                vo.setUserNo(rs.getInt("user_no"));
                vo.setPointDate(rs.getDate("point_date"));
                vo.setPointAmount(rs.getInt("point_amount"));
                vo.setPointSource(rs.getString("point_source"));
                list.add(vo);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
