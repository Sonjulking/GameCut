package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.PhotoVO;

public class PhotoDAO {

    public int insertPhoto(PhotoVO photoVO, String type) {
        int photoNo = -1;
        String getSeqSql = "SELECT SEQ_PHOTO_NO.NEXTVAL FROM dual";
        String sql = "insert into photo(photo_no, attach_no,BOARD_NO, photo_order) values(?, ?, ?, ?) ";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement seqStmt = conn.prepareStatement(getSeqSql);
            // 시퀀스 먼저 조회
            ResultSet rs = seqStmt.executeQuery();
            if (rs.next()) {
                photoNo = rs.getInt(1); // 시퀀스 값
            }

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, photoNo);
            pstmt.setInt(2, photoVO.getAttachNo());
            if(type.equals("board")) {
                pstmt.setInt(3, photoVO.getBoardNo());
            }else if(type.equals("profile")) {
                pstmt.setNull(3, java.sql.Types.INTEGER);

            }
            pstmt.setInt(4, photoVO.getPhotoOrder());
         pstmt.executeUpdate();
            ConnectionProvider.close(conn, pstmt);
        } catch (Exception e) {
            System.out.println("예외발생 : " + e.getMessage());
        }
        return photoNo;
    }


    // 사진 번호를 매개변수로 해당 사진 데이터삭제
    public int deletePhotoById(int photoNo) {
        int re = -1;
        String sql = "delete from photo where photo_no = ?";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, photoNo);
            re = pstmt.executeUpdate();
            ConnectionProvider.close(conn, pstmt);
        } catch (Exception e) {
            System.out.println("예외발생 : " + e.getMessage());
        }
        return re;
    }
}
