package com.gamecut.dao;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.VideoVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class VideoDAO {
    public int insertVideo(VideoVO videoVO) {
        int re = -1;
        String sql = "insert into VIDEO(video_no, attach_no) values(SEQ_VIDEO_NO.nextval, ?) ";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, videoVO.getAttachNo());
            re = pstmt.executeUpdate();
            ConnectionProvider.close(conn, pstmt);
        } catch (Exception e) {
            System.out.println("예외발생 : " + e.getMessage());
        }
        return re;

    }
}
