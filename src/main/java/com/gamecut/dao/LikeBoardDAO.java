package com.gamecut.dao;

import java.sql.*;

import com.gamecut.db.ConnectionProvider;



public class LikeBoardDAO {

    public int updateLikeCount(int boardNo, boolean isLike) {
        int result = 0;
        String sql = isLike
            ? "UPDATE BOARD SET BOARD_LIKE = BOARD_LIKE + 1 WHERE BOARD_NO = ?"
            : "UPDATE BOARD SET BOARD_LIKE = BOARD_LIKE - 1 WHERE BOARD_NO = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, boardNo);
            result = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int getLikeCount(int boardNo) {
        int count = 0;
        String sql = "SELECT BOARD_LIKE FROM BOARD WHERE BOARD_NO = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, boardNo);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("BOARD_LIKE");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}
