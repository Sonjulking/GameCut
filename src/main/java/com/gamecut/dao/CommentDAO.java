package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.CommentVO;

public class CommentDAO {

	// 부모 댓글 조회
	public ArrayList<CommentVO> selectParentComments(int boardNo) {
	    ArrayList<CommentVO> list = new ArrayList<>();
	    String sql = "select comment_no, board_no, user_no, comment_content, comment_create_date, parent_comment_no FROM comment WHERE board_no = ? AND parent_comment_no = 0 AND comment_delete_date IS NULL ORDER BY comment_create_date ASC";

	    try (Connection conn = ConnectionProvider.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, boardNo);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            CommentVO vo = new CommentVO();
	            vo.setCommentNo(rs.getInt("comment_no"));
	            vo.setBoardNo(rs.getInt("board_no"));
	            vo.setUserNo(rs.getInt("user_no"));
	            vo.setCommentContent(rs.getString("comment_content"));
	            vo.setCommentCreateDate(rs.getDate("comment_create_date"));
	            vo.setParentCommentNo(rs.getInt("parent_comment_no"));
	            list.add(vo);
	        }
	    } catch (Exception e) {
	    	System.out.println("예외발생:"+e.getMessage());
	        e.printStackTrace();
	    }

	    return list;
	}
	
	// 대댓글 조회
	public ArrayList<CommentVO> selectReplies(int parentCommentNo) {
	    ArrayList<CommentVO> list = new ArrayList<>();
	    String sql = "select commet_no, board_no, user_no, comment_content, comment_create_date, parent_comment_no from comment WHERE parent_comment_no = ? and comment_delete_date is null order by comment_create_date";

	    try (Connection conn = ConnectionProvider.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, parentCommentNo);
	        ResultSet rs = pstmt.executeQuery();

	        while (rs.next()) {
	            CommentVO vo = new CommentVO();
	            vo.setCommentNo(rs.getInt("comment_no"));
	            vo.setBoardNo(rs.getInt("board_no"));
	            vo.setUserNo(rs.getInt("user_no"));
	            vo.setCommentContent(rs.getString("comment_content"));
	            vo.setCommentCreateDate(rs.getDate("comment_create_date"));
	            vo.setParentCommentNo(rs.getInt("parent_comment_no"));
	            list.add(vo);
	        }
	   
	    } catch (Exception e) {
	    	System.out.println("예외발생:"+e.getMessage());
	        e.printStackTrace();
	    }

	    return list;
	}
	
	// 특정 user의 댓글 조회
	public ArrayList<CommentVO> selectUserComments(int userNo){
		ArrayList<CommentVO> list = new ArrayList<>();
		String sql = "select comment_no, board_no, user_no, comment_content, comment_create_date, parent_comment_no "
				+ "from comment where user_no = ? and comment_delete_date is null order by comment_create_date desc";
		try (Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql)){
				pstmt.setInt(1, userNo);
				ResultSet rs = pstmt.executeQuery();
				
				while(rs.next()) {
					CommentVO vo = new CommentVO();
					vo.setCommentNo(rs.getInt("comment_no"));
		            vo.setBoardNo(rs.getInt("board_no"));
		            vo.setUserNo(rs.getInt("user_no"));
		            vo.setCommentContent(rs.getString("comment_content"));
		            vo.setCommentCreateDate(rs.getDate("comment_create_date"));
		            vo.setParentCommentNo(rs.getInt("parent_comment_no"));
		            list.add(vo);
				}
			ConnectionProvider.close(conn, pstmt, rs);
		}catch(Exception e) {
			System.out.println("예외발생:"+e.getMessage());
			e.printStackTrace();
		}
		return list;
	}
	

	// 댓글 작성
	public int insertComment(CommentVO vo) {
        int result = 0;
        String sql = "insert into comment(comment_no, board_no, user_no, parent_comment_no, comment_content, comment_create_date) values (SEQ_COMMENT_NO.NEXTVAL, ?, ?, ?, ?, SYSDATE)";

        try (Connection conn = ConnectionProvider.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, vo.getBoardNo());
            pstmt.setInt(2, vo.getUserNo());
            pstmt.setInt(3, vo.getParentCommentNo());
            pstmt.setString(4, vo.getCommentContent());

            result = pstmt.executeUpdate();
        } catch (Exception e) {
        	System.out.println("예외발생:"+e.getMessage());
            e.printStackTrace();
        }
        return result;
	}
	
	// 댓글 수정
	public int updateComment(CommentVO vo) {
	    int result = 0;
	    String sql = "update comment set comment_content = ? where comment_no = ? and comment_delete_date is null";

	    try (Connection conn = ConnectionProvider.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setString(1, vo.getCommentContent());
	        pstmt.setInt(2, vo.getCommentNo());

	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	    	System.out.println("예외발생:"+e.getMessage());
	        e.printStackTrace();
	    }

	    return result;
	}
	
	
	// 댓글 삭제
	public int deleteComment(int commentNo) {
	    int result = 0;
	    String sql = "update comment set comment_delete_date = SYSDATE where comment_no = ? and comment_delete_date is null";

	    try (Connection conn = ConnectionProvider.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {

	        pstmt.setInt(1, commentNo);

	        result = pstmt.executeUpdate();
	    } catch (Exception e) {
	    	System.out.println("예외발생:"+e.getMessage());
	        e.printStackTrace();
	    }

	    return result;
	}
	
	// 댓글 번호로 댓글 1개 조회
	public CommentVO getCommentByNo(int commentNo) {
	    CommentVO vo = null;
	    String sql = "select comment_no, board_no, user_no, comment_content, parent_comment_no, comment_create_date, comment_delete_date from comment where comment_no = ?";

	    try (Connection conn = ConnectionProvider.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setInt(1, commentNo);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            vo = new CommentVO();
	            vo.setCommentNo(rs.getInt("comment_no"));
	            vo.setBoardNo(rs.getInt("board_no"));
	            vo.setUserNo(rs.getInt("user_no"));
	            vo.setParentCommentNo(rs.getInt("parent_comment_no"));
	            vo.setCommentContent(rs.getString("comment_content"));
	            vo.setCommentCreateDate(rs.getDate("comment_create_date"));
	            vo.setCommentDeleteDate(rs.getDate("comment_delete_date"));
	        }
	    } catch (Exception e) {
	    	System.out.println("예외발생:"+e.getMessage());
	        e.printStackTrace();
	    }

	    return vo;
	}
}