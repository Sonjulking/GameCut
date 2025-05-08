package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.FileVO;

public class FileDAO {
	
	// 유저의 번호를 이용해 프로필 사진의 파일 정보를 가져오기 위한 메소드
	public FileVO selectProfileFileByUserId(int userNo) {
		FileVO file = new FileVO();
		String sql = "select attach_no, user_no, uuid, file_url, mime_type, upload_time, original_file_name from file_tb where attach_no = (select attach_no from photo where photo_no = (select photo_no from user_tb where user_no = ?))";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				file.setAttachNo(rs.getInt(1));
				file.setUserNo(rs.getInt(2));
				file.setFileUrl(rs.getString(3));
				file.setMimeType(rs.getString(4));
				file.setUploadTime(rs.getDate(5));
				file.setOriginalFileName(rs.getString(6));
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return file;
	}
	
}
