package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.FileVO;

public class FileDAO {

    public int insertFile(FileVO fileVO) {
        int re = -1;
        String sql = "insert into file_tb(ATTACH_NO, USER_NO, UUID, FILE_URL, MIME_TYPE, ORIGINAL_FILE_NAME)" +
                " values(SEQ_ATTACH_NO.nextval, ?, ?, ?, ?, ?)";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, fileVO.getUserNo());
            pstmt.setString(2, fileVO.getUuid());
            pstmt.setString(3, fileVO.getFileUrl());
            pstmt.setString(4, fileVO.getMimeType());
            pstmt.setString(5, fileVO.getOriginalFileName());
            re = pstmt.executeUpdate();
        } catch (Exception e) {
            System.out.println("예외발생 : " + e.getMessage());
        }
        return re;
    }

    // 유저의 번호를 이용해 프로필 사진의 파일 정보를 가져오기 위한 메소드
    public FileVO selectProfileFileByUserId(int userNo) {
        FileVO file = new FileVO();
        String sql = "select attach_no, user_no, uuid, file_url, mime_type, upload_time, original_file_name from file_tb where attach_no = (select attach_no from photo where photo_no = (select photo_no from user_tb where user_no = ?))";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userNo);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                file.setAttachNo(rs.getInt("attach_no"));
                file.setUserNo(rs.getInt("user_no"));
                file.setUuid(rs.getString("uuid"));
                file.setFileUrl(rs.getString("file_url"));
                file.setMimeType(rs.getString("mime_type"));
                file.setUploadTime(rs.getDate("upload_time"));
                file.setOriginalFileName(rs.getString("original_file_name"));
            }
            ConnectionProvider.close(conn, pstmt, rs);
        } catch (Exception e) {
            System.out.println("FileDAO 예외발생 : " + e.getMessage());
        }
        return file;
    }

    // 프로필 사진을 수정하는 구문

}
