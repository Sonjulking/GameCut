package com.gamecut.dao;

import java.sql.*;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.LikeBoardVO;



public class LikeBoardDAO {

	public boolean isLiked(LikeBoardVO vo) {
        boolean liked = false;
        String sql = "SELECT * FROM BOARD_LIKE WHERE USER_NO = ? AND BOARD_NO = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, vo.getUserNo());
            pstmt.setInt(2, vo.getBoardNo());
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) liked = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return liked;
    }

    public int insertLike(LikeBoardVO vo) {
        int result = 0;
        String insertSql = "INSERT INTO BOARD_LIKE (USER_NO, BOARD_NO) VALUES (?, ?)";
        String updateSql = "UPDATE BOARD SET BOARD_LIKE = BOARD_LIKE + 1 WHERE BOARD_NO = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement ps1 = conn.prepareStatement(insertSql);
             PreparedStatement ps2 = conn.prepareStatement(updateSql)) {

            ps1.setInt(1, vo.getUserNo());
            ps1.setInt(2, vo.getBoardNo());
            result += ps1.executeUpdate();

            ps2.setInt(1, vo.getBoardNo());
            result += ps2.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int deleteLike(LikeBoardVO vo) {
        int result = 0;
        String deleteSql = "DELETE FROM BOARD_LIKE WHERE USER_NO = ? AND BOARD_NO = ?";
        String updateSql = "UPDATE BOARD SET BOARD_LIKE = BOARD_LIKE - 1 WHERE BOARD_NO = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement ps1 = conn.prepareStatement(deleteSql);
             PreparedStatement ps2 = conn.prepareStatement(updateSql)) {

            ps1.setInt(1, vo.getUserNo());
            ps1.setInt(2, vo.getBoardNo());
            result += ps1.executeUpdate();

            ps2.setInt(1, vo.getBoardNo());
            result += ps2.executeUpdate();

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