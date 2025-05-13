package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.FileVO;

public class FileDAO {
	public int deleteFileByAttachNo(int attachNo) {
		int re = 0;
		String sql = "delete file_tb where attach_no = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, attachNo);
			re = pstmt.executeUpdate();
        	System.out.println("파일 db 삭제 완료");
			conn.commit();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}
	
	public int deleteFileByPhotoNo(int photoNo) {
		int re = 0;
		String sql = "delete file_tb where attach_no = (select attach_no from photo where photo_no = ?)";
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
	
	
    public int insertFile(FileVO fileVO) {
        int attachNo = -1;

        String getSeqSql = "SELECT SEQ_ATTACH_NO.NEXTVAL FROM dual";
        String insertSql = "INSERT INTO file_tb(ATTACH_NO, USER_NO, UUID, FILE_URL, REAL_PATH, MIME_TYPE, ORIGINAL_FILE_NAME) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (
                Connection conn = ConnectionProvider.getConnection();
                PreparedStatement seqStmt = conn.prepareStatement(getSeqSql);
                PreparedStatement pstmt = conn.prepareStatement(insertSql);
        ) {
            // 시퀀스 먼저 조회
            ResultSet rs = seqStmt.executeQuery();
            if (rs.next()) {
                attachNo = rs.getInt(1); // 시퀀스 값
            }

            System.out.println("realPath : " + fileVO.getRealPath());
            System.out.println("fileUrl : " + fileVO.getFileUrl());
            // INSERT 수행
            pstmt.setInt(1, attachNo);
            pstmt.setInt(2, fileVO.getUserNo());
            pstmt.setString(3, fileVO.getUuid());
            pstmt.setString(4, fileVO.getFileUrl());
            pstmt.setString(5, fileVO.getRealPath());
            pstmt.setString(6, fileVO.getMimeType());
            pstmt.setString(7, fileVO.getOriginalFileName());

            pstmt.executeUpdate();

        } catch (Exception e) {
            System.out.println("예외발생 : " + e.getMessage());
        }

        return attachNo;
    }


    // 유저의 번호를 이용해 프로필 사진의 파일 정보를 가져오기 위한 메소드
    public FileVO selectProfileFileByUserId(int userNo) {
        FileVO file = new FileVO();
        String sql = "select attach_no, user_no, uuid, file_url, real_path, mime_type, upload_time, original_file_name from file_tb where attach_no = (select attach_no from photo where photo_no = (select photo_no from user_tb where user_no = ?))";
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

                System.out.println("rs.getString(\"real_path\")" + rs.getString("real_path"));
                file.setRealPath(rs.getString("real_path"));
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
