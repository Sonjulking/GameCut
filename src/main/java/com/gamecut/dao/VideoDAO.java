package com.gamecut.dao;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.VideoVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VideoDAO {
    public int insertVideo(VideoVO videoVO) {
        int videoNo = -1;
        String getSeqSql = "SELECT SEQ_VIDEO_NO.NEXTVAL FROM dual";
        String sql = "insert into VIDEO(video_no, attach_no) values(?, ?) ";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement seqStmt = conn.prepareStatement(getSeqSql);
            // 시퀀스 먼저 조회
            ResultSet rs = seqStmt.executeQuery();
            if (rs.next()) {
                videoNo = rs.getInt(1); // 시퀀스 값
            }
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, videoNo);
            pstmt.setInt(2, videoVO.getAttachNo());
            pstmt.executeUpdate();
            ConnectionProvider.close(conn, pstmt);
        } catch (Exception e) {
            System.out.println("예외발생 : " + e.getMessage());
        }
        return videoNo;

    }
}
