package com.gamecut.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.UserVO;

public class UserDAO {
	// 유저의 번호를 받아 해당 유저를 탈퇴하는 메소드
	public int deleteUser(int userNo) {
		int re = -1;
		String sql = "update user_tb set user_delete_date = sysdate where user_no = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			re = pstmt.executeUpdate();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("UserDAO 예외발생 : " + e.getMessage());
		}
		return re;
	}
	
	public UserVO selectUser(int userNo) {
		UserVO user = new UserVO();
		String sql = "select USER_NO, USER_ID, USER_PWD, USER_NAME, USER_NICKNAME,  PHONE, EMAIL, USER_CREATE_DATE, USER_DELETE_DATE, IS_SOCIAL, ROLE, USER_POINT, ITEM_NO, PHOTO_NO from USER_TB WHERE USER_NO = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
			    user.setUserNo(rs.getInt("user_no"));
			    user.setUserId(rs.getString("user_id"));
			    user.setUserPwd(rs.getString("user_pwd"));
			    user.setUserName(rs.getString("user_name"));
			    user.setUserNickname(rs.getString("user_nickname"));
			    user.setPhone(rs.getString("phone"));
			    user.setEmail(rs.getString("email"));
			    user.setUserCreateDate(rs.getDate("user_create_date"));
			    user.setUserDeleteDate(rs.getDate("user_delete_date"));
			    user.setIsSocial(rs.getString("is_social"));
			    user.setRole(rs.getString("role"));
			    user.setUserPoint(rs.getInt("user_point"));
			    user.setItemNo(rs.getInt("item_no"));
			    user.setPhotoNo(rs.getInt("photo_no"));
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("UserDAO 예외발생 : " + e.getMessage() );
		}
		return user;
	}
	
	public int insertUser(UserVO vo) {
	      
	      int re = -1;
	      String sql = "insert into user_tb values(seq_user_no.nextval(),?,?,?,?,?,?,sysdate,null,?,?,1000,null,?)";
	      
	      try {
	         Connection conn =  ConnectionProvider.getConnection();
	         PreparedStatement prst = conn.prepareStatement(sql);
	         prst.setString(1, vo.getUserId());
	         prst.setString(2, vo.getUserPwd());
	         prst.setString(3, vo.getUserName());
	         prst.setString(4, vo.getUserNickname());
	         prst.setString(5, vo.getPhone());
	         prst.setString(6, vo.getEmail());
	         prst.setString(7, vo.getIsSocial());
	         prst.setString(8, vo.getRole());
	         prst.setInt(9, vo.getPhotoNo());
	         re = prst.executeUpdate();
	         ConnectionProvider.close(conn, prst);
	      } catch (Exception e) {
	         System.out.println("예외발생 : " + e.getMessage());
	      }
	      return re;
	      
	   }

}
