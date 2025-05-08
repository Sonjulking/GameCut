package com.gamecut.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.UserVO;

public class UserDAO {
	
	public UserVO selectUser(int userNo) {
		UserVO user = new UserVO();
		String sql = "select USER_NO, USER_ID, USER_PWD, USER_NAME, USER_NICKNAME,  PHONE, EMAIL, USER_CREATE_DATE, USER_DELETE_DATE, IS_SOCIAL, ROLE, USER_POINT, ITEM_NO, PHOTO_NO from USER_TB WHERE USER_NO = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
			    user.setUserNo(rs.getInt(1));
			    user.setUserId(rs.getString(2));
			    user.setUserPwd(rs.getString(3));
			    user.setUserName(rs.getString(4));
			    user.setUserNickname(rs.getString(5));
			    user.setPhone(rs.getString(6));
			    user.setEmail(rs.getString(7));
			    user.setUserCreateDate(rs.getDate(8));
			    user.setUserDeleteDate(rs.getDate(9));
			    user.setIsSocial(rs.getString(10));
			    user.setRole(rs.getString(11));
			    user.setUserPoint(rs.getInt(12));
			    user.setItemNo(rs.getInt(13));
			    user.setPhotoNo(rs.getInt(14));
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("UserDAO 예외발생 : " + e.getMessage() );
		}
		return user;
	}
}
