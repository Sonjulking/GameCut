package com.gamecut.dao;

import java.sql.*;
import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.CommentLikeVO;

public class CommentLikeDAO {

    // 좋아요가 이미 눌러져 있는지 확인
    public boolean isLiked(int commentNo, int userNo) {
        boolean result = false;
        String sql = "select count(*) from comment_like where comment_no =? and user_no = ?";
        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, commentNo);
            pstmt.setInt(2, userNo);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next() && rs.getInt(1) > 0) {
                result = true;
            }

        } catch (Exception e) {
        	System.out.println("예외발생:"+e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    // 좋아요 등록
    public int insertLike(int commentNo, int userNo) {
    	String sql = "insert into comment_like(comment_no, user_no values (?, ?)";
    	int result = 0;
    	try(Connection conn = ConnectionProvider.getConnection();
    		PreparedStatement pstmt = conn.prepareStatement(sql)){
    		
    		pstmt.setInt(1, commentNo);
    		pstmt.setInt(2, userNo);
    		
    		result = pstmt.executeUpdate();
    		
    	}catch(Exception e) {
    		System.out.println("예외발생:"+e.getMessage());
    		e.printStackTrace();
    	}
    	return result;
    }
        

    // 좋아요 삭제
    public int deleteLike(int commentNo, int userNo) {
        int result = 0;
        String sql = "delete from comment_like where comment_no = ? and user_no = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, commentNo);
            pstmt.setInt(2, userNo);

            result = pstmt.executeUpdate();

        } catch (Exception e) {
        	System.out.println("예외발생:"+e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    // 좋아요 수 조회
    public int countLikes(int commentNo) {
        int count = 0;
        String sql = "select count(*) from comment_like where comment_no = ?";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, commentNo);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (Exception e) {
        	System.out.println("예외발생:"+e.getMessage());
            e.printStackTrace();
        }

        return count;
    }

    // 좋아요 토글 처리 (좋아요 있으면 삭제, 없으면 등록)
    public boolean toggleLike(int commentNo, int userNo) {
        if (isLiked(commentNo, userNo)) {
            deleteLike(commentNo, userNo);
            return false; // 좋아요 취소
        } else {
            insertLike(commentNo, userNo);
            return true; // 좋아요 등록
        }
    }
}