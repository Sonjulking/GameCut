package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.BoardVO;

public class BoardDAO {

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    //게시글 작성
    public int insert(BoardVO b) {
    	 int boardNo = -1;
    	    String sql = "INSERT INTO board(board_no, user_no, board_type_no, video_no, board_content, board_title, board_count, board_like, board_create_date) "
    	               + "VALUES (SEQ_BOARD_NO.nextval, ?, ?, ?, ?, ?, DEFAULT, DEFAULT, DEFAULT)";
    	    
    	    String[] returnCols = { "board_no" };

    	    try {
    	        conn = ConnectionProvider.getConnection();
    	        pstmt = conn.prepareStatement(sql, returnCols);

    	        pstmt.setInt(1, b.getUserNo());
    	        pstmt.setInt(2, b.getBoardTypeNo());
    	        if (b.getVideoNo() != null) {
    	            pstmt.setInt(3, b.getVideoNo());
    	        } else {
    	            pstmt.setNull(3, java.sql.Types.INTEGER);
    	        }
    	        pstmt.setString(4, b.getBoardContent());
    	        pstmt.setString(5, b.getBoardTitle());

    	        int result = pstmt.executeUpdate();

    	        if (result > 0) {
    	            ResultSet rs = pstmt.getGeneratedKeys();
    	            if (rs.next()) {
    	                boardNo = rs.getInt(1);
    	            }
    	            rs.close();
    	        }

    	    } catch (Exception e) {
    	        System.out.println("예외 발생: " + e.getMessage());
    	    } finally {
    	        ConnectionProvider.close(conn, pstmt);
    	    }

    	    return boardNo;
    }

    public ArrayList<BoardVO> findTop5() {
        ArrayList<BoardVO> list = new ArrayList<>();

        String sql = "SELECT * FROM (\n"
                + "    SELECT b.*, u.user_nickname\n"
                + "    FROM board b\n"
                + "    JOIN user_tb u ON b.user_no = u.user_no\n"
                + "    WHERE b.board_delete_date IS NULL\n"
                + "    AND b.video_no IS NOT NULL\n"
                + "    AND b.board_type_no  = 3\n"
                + "    ORDER BY DBMS_RANDOM.VALUE\n"
                + ") WHERE ROWNUM <= 5";

        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardVO vo = new BoardVO();
                vo.setBoardNo(rs.getInt("board_no"));
                vo.setUserNo(rs.getInt("user_no"));
                vo.setBoardTypeNo(rs.getInt("board_type_no"));
                vo.setVideoNo(rs.getObject("video_no") != null ? rs.getInt("video_no") : null);
                vo.setBoardContent(rs.getString("board_content"));
                vo.setBoardTitle(rs.getString("board_title"));
                vo.setBoardCount(rs.getInt("board_count"));
                vo.setBoardLike(rs.getInt("board_like"));
                vo.setBoardCreateDate(rs.getDate("board_create_date"));
                vo.setBoardDeleteDate(rs.getDate("board_delete_date"));
                vo.setUserNickname(rs.getString("USER_NICKNAME"));
                list.add(vo);

            }

        } catch (Exception e) {
            System.out.println("예외발생: " + e.getMessage());
        }

        ConnectionProvider.close(conn, pstmt, rs);
        return list;
    }

    //전체 목록
    public ArrayList<BoardVO> findAll() {
        ArrayList<BoardVO> list = new ArrayList<>();

        String sql = "SELECT b.*, u.user_nickname\n"
                + "        FROM board b\n"
                + "        JOIN user_tb u ON b.user_no = u.user_no\n"
                + "        WHERE b.board_delete_date IS NULL\n"
                + "        ORDER BY b.board_no DESC";
        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardVO vo = new BoardVO();
                vo.setBoardNo(rs.getInt("board_no"));
                vo.setUserNo(rs.getInt("user_no"));
                vo.setBoardTypeNo(rs.getInt("board_type_no"));
                vo.setVideoNo(rs.getObject("video_no") != null ? rs.getInt("video_no") : null);
                vo.setBoardContent(rs.getString("board_content"));
                vo.setBoardTitle(rs.getString("board_title"));
                vo.setBoardCount(rs.getInt("board_count"));
                vo.setBoardLike(rs.getInt("board_like"));
                vo.setBoardCreateDate(rs.getDate("board_create_date"));
                vo.setBoardDeleteDate(rs.getDate("board_delete_date"));
                vo.setUserNickname(rs.getString("USER_NICKNAME"));
                list.add(vo);

            }

        } catch (Exception e) {
            System.out.println("예외발생: " + e.getMessage());
        }

        ConnectionProvider.close(conn, pstmt, rs);
        return list;
    }

    //게시글 상세보기
    public BoardVO findById(int boardNo) {
        BoardVO board = null;

        String updateSql = "UPDATE BOARD SET BOARD_COUNT = BOARD_COUNT + 1 WHERE BOARD_NO = ?";
        String selectSql =
        	    "SELECT b.*, u.user_nickname " +
        	    "FROM board b " +
        	    "JOIN user_tb u ON b.user_no = u.user_no " +
        	    "WHERE b.board_no = ?";

        try (Connection conn = ConnectionProvider.getConnection()) {

            // 조회수 증가
            try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
                pstmt.setInt(1, boardNo);
                pstmt.executeUpdate();
            }

            // 게시글 정보 조회
            try (PreparedStatement pstmt = conn.prepareStatement(selectSql)) {
                pstmt.setInt(1, boardNo);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    board = new BoardVO();
                    board.setBoardNo(rs.getInt("BOARD_NO"));
                    board.setUserNo(rs.getInt("USER_NO"));
                    board.setBoardTitle(rs.getString("BOARD_TITLE"));
                    board.setBoardContent(rs.getString("BOARD_CONTENT"));
                    board.setBoardCreateDate(rs.getDate("BOARD_CREATE_DATE"));
                    board.setBoardCount(rs.getInt("BOARD_COUNT"));
                    board.setBoardLike(rs.getInt("BOARD_LIKE"));
                    board.setBoardTypeNo(rs.getInt("BOARD_TYPE_NO"));
                    board.setVideoNo(rs.getObject("VIDEO_NO") != null ? rs.getInt("VIDEO_NO") : null);
                    board.setUserNickname(rs.getString("USER_NICKNAME"));

                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return board;
    }

    //게시글 수정
    public int update(BoardVO b) {
        int result = -1;
        String sql = "update board set board_type_no = ?, video_no = ?, board_content = ?, board_title = ? where board_no = ?";

        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, b.getBoardTypeNo());
            if (b.getVideoNo() != null) {
                pstmt.setInt(2, b.getVideoNo());
            } else {
                pstmt.setNull(2, java.sql.Types.INTEGER);
            }
            pstmt.setString(3, b.getBoardContent());
            pstmt.setString(4, b.getBoardTitle());
            pstmt.setInt(5, b.getBoardNo());

            result = pstmt.executeUpdate();
            System.out.println("boardTypeNo: " + b.getBoardTypeNo());
        } catch (Exception e) {
            System.out.println("예외발생: " + e.getMessage());
        }

        ConnectionProvider.close(conn, pstmt);
        return result;
    }

    //게시글 삭제
    public int delete(int BoardNo) {
        int result = -1;

        String sql = "update board set board_delete_date = sysdate where board_no = ?";

        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, BoardNo);

            result = pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("예외발생: " + e.getMessage());
        }
        ConnectionProvider.close(conn, pstmt);
        return result;
    }
    
    // 회원 번호를 매개변수로 받아 게시글 조회
    public ArrayList<BoardVO> searchByUserNo(int userNo) {
    	ArrayList<BoardVO> list = new ArrayList<>();
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
    	
    	String sql = "select board_no, user_no, board_type_no, video_no, board_content, board_title, board_count, board_like, board_create_date, board_delete_date from board where board_delete_date is null and user_no = ?";
    	
    	try {
    		conn = ConnectionProvider.getConnection();
    		pstmt = conn.prepareStatement(sql.toString());
    		pstmt.setInt(1, userNo);
    		rs = pstmt.executeQuery();
    		while (rs.next()) {
    			BoardVO board = new BoardVO();
    			board.setBoardNo(rs.getInt("BOARD_NO"));
    			board.setUserNo(rs.getInt("USER_NO"));
    			board.setBoardTypeNo(rs.getInt("BOARD_TYPE_NO"));
    			board.setVideoNo(rs.getObject("VIDEO_NO") != null ? rs.getInt("VIDEO_NO") : null);
    			board.setBoardContent(rs.getString("BOARD_CONTENT"));
    			board.setBoardTitle(rs.getString("BOARD_TITLE"));
    			board.setBoardCount(rs.getInt("BOARD_COUNT"));
    			board.setBoardLike(rs.getInt("BOARD_LIKE"));
    			board.setBoardCreateDate(rs.getDate("BOARD_CREATE_DATE"));
    			board.setBoardDeleteDate(rs.getDate("BOARD_DELETE_DATE"));
    			list.add(board);
    		}
    	} catch (Exception e) {
    		e.printStackTrace();
    	} finally {
    		ConnectionProvider.close(conn, pstmt, rs);
    	}
    	
    	return list;
    }
    //게시글 검색
    public ArrayList<BoardVO> search(int boardTypeNo, String category, String keyword) {
    	ArrayList<BoardVO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT b.*, u.user_nickname ");
        sql.append("FROM board b ");
        sql.append("JOIN user_tb u ON b.user_no = u.user_no ");
        sql.append("WHERE b.board_type_no = ? ");
        sql.append("AND b.board_delete_date IS NULL ");

        if ("nickname".equals(category)) {
            sql.append("AND u.USER_NICKNAME LIKE ? ");
        } else if ("title".equals(category)) {
            sql.append("AND b.BOARD_TITLE LIKE ? ");
        } else if ("content".equals(category)) {
            sql.append("AND b.BOARD_CONTENT LIKE ? ");
        }

        sql.append("ORDER BY b.BOARD_NO DESC");

        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql.toString());

            pstmt.setInt(1, boardTypeNo);
            pstmt.setString(2, "%" + keyword + "%");

            rs = pstmt.executeQuery();
            while (rs.next()) {
                BoardVO board = new BoardVO();
                board.setBoardNo(rs.getInt("BOARD_NO"));
                board.setUserNo(rs.getInt("USER_NO"));
                board.setBoardTypeNo(rs.getInt("BOARD_TYPE_NO"));
                board.setVideoNo(rs.getObject("VIDEO_NO") != null ? rs.getInt("VIDEO_NO") : null);
                board.setBoardContent(rs.getString("BOARD_CONTENT"));
                board.setBoardTitle(rs.getString("BOARD_TITLE"));
                board.setBoardCount(rs.getInt("BOARD_COUNT"));
                board.setBoardLike(rs.getInt("BOARD_LIKE"));
                board.setBoardCreateDate(rs.getDate("BOARD_CREATE_DATE"));
                board.setBoardDeleteDate(rs.getDate("BOARD_DELETE_DATE"));
                board.setUserNickname(rs.getString("USER_NICKNAME"));
                list.add(board);
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            ConnectionProvider.close(conn, pstmt, rs);
        }

        return list;
    }
    public ArrayList<BoardVO> findByType(int type) {
        ArrayList<BoardVO> list = new ArrayList<>();
        String sql = "SELECT b.*, u.user_nickname\n"
                + "        FROM board b\n"
                + "        JOIN user_tb u ON b.user_no = u.user_no\n"
                + "        WHERE b.board_type_no = ? AND b.board_delete_date IS NULL\n"
                + "        ORDER BY b.board_no DESC";

        try (
                Connection conn = ConnectionProvider.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {
            pstmt.setInt(1, type);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardVO board = new BoardVO();
                board.setBoardNo(rs.getInt("BOARD_NO"));
                board.setBoardTitle(rs.getString("BOARD_TITLE"));
                board.setBoardContent(rs.getString("BOARD_CONTENT"));
                board.setBoardCreateDate(rs.getDate("BOARD_CREATE_DATE"));
                board.setUserNo(rs.getInt("USER_NO"));
                board.setBoardCount(rs.getInt("BOARD_COUNT"));
                board.setBoardLike(rs.getInt("BOARD_LIKE"));
                board.setUserNickname(rs.getString("USER_NICKNAME"));
                list.add(board);
            }
            System.out.println("type = " + type + ", result size = " + list.size());
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}