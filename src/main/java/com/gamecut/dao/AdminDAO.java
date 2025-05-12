package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.ReportVO;
import com.gamecut.vo.UserVO;

public class AdminDAO {

	// 회원 전체 조회
	public ArrayList<UserVO> getUserList() {

		ArrayList<UserVO> list = new ArrayList<UserVO>();
		try {
			String sql = "select USER_NO, USER_ID, USER_PWD, USER_NAME, USER_NICKNAME,  PHONE, EMAIL, USER_CREATE_DATE, USER_DELETE_DATE, IS_SOCIAL, ROLE, USER_POINT, ITEM_NO, PHOTO_NO from user_tb" + "order by userNo";
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				UserVO u = new UserVO(rs.getInt("USER_NO"),
									  rs.getString("USER_ID"),
									  rs.getString("USER_PWD"),
									  rs.getString("USER_NAME"),
									  rs.getString("USER_NICKNAME"),
									  rs.getString("PHONE"),
									  rs.getString("EMAIL"),
									  rs.getDate("USER_CREATE_DATE"),
									  rs.getDate("USER_DELETE_DATE"),
									  rs.getString("IS_SOCIAL"),
									  rs.getString("ROLE"),
									  rs.getInt("USER_POINT"),
									  rs.getInt("ITEM_NO"),
									  rs.getInt("PHOTO_NO"));
				list.add(u);
			}
			ConnectionProvider.close(conn, stmt, rs);
		}catch (Exception e) {
			System.out.println("AdminDAO 예외발생:" + e.getMessage());
		}
		return list;
	}

	// 회원번호로 회원 조회
	public UserVO getUserByNo(int userNo) {
		UserVO u = new UserVO();
		String sql = "select USER_NO, USER_ID, USER_PWD, USER_NAME, USER_NICKNAME,  PHONE, EMAIL, USER_CREATE_DATE, USER_DELETE_DATE, IS_SOCIAL, ROLE, USER_POINT, ITEM_NO, PHOTO_NO from USER_TB WHERE USER_NO = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setInt(1, userNo);
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				u.setUserNo(rs.getInt("USER_NO"));
			    u.setUserId(rs.getString("USER_ID"));
			    u.setUserPwd(rs.getString("USER_PWD"));
			    u.setUserName(rs.getString("USER_NAME"));
			    u.setUserNickname(rs.getString("USER_NICKNAME"));
			    u.setPhone(rs.getString("PHONE"));
			    u.setEmail(rs.getString("EMAIL"));
			    u.setUserCreateDate(rs.getDate("USER_CREATE_DATE"));
			    u.setUserDeleteDate(rs.getDate("USER_DELETE_DATE"));
			    u.setIsSocial(rs.getString("IS_SOCIAL"));
			    u.setRole(rs.getString("ROLE"));
			    u.setUserPoint(rs.getInt("USER_POINT"));
			    u.setItemNo(rs.getInt("ITEM_NO"));
			    u.setPhotoNo(rs.getInt("PHOTO_NO"));
			}
			ConnectionProvider.close(conn, psmt, rs);
		}catch (Exception e) {
			System.out.println("AdminDAO 예외발생:" + e.getMessage());
		}
		return u;
	}

	// 회원아이디로 회원 조회
	public UserVO getUserById(String userId) {
		UserVO u = new UserVO();
		String sql = "select USER_NO, USER_ID, USER_PWD, USER_NAME, USER_NICKNAME, PHONE, EMAIL, USER_CREATE_DATE, USER_DELETE_DATE, IS_SOCIAL, ROLE, USER_POINT, ITEM_NO, PHOTO_NO from USER_TB WHERE USER_id = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(2, userId);
			ResultSet rs = psmt.executeQuery();
			if(rs.next()) {
				u.setUserNo(rs.getInt("USER_NO"));
			    u.setUserId(rs.getString("USER_ID"));
			    u.setUserPwd(rs.getString("USER_PWD"));
			    u.setUserName(rs.getString("USER_NAME"));
			    u.setUserNickname(rs.getString("USER_NICKNAME"));
			    u.setPhone(rs.getString("PHONE"));
			    u.setEmail(rs.getString("EMAIL"));
			    u.setUserCreateDate(rs.getDate("USER_CREATE_DATE"));
			    u.setUserDeleteDate(rs.getDate("USER_DELETE_DATE"));
			    u.setIsSocial(rs.getString("IS_SOCIAL"));
			    u.setRole(rs.getString("ROLE"));
			    u.setUserPoint(rs.getInt("USER_POINT"));
			    u.setItemNo(rs.getInt("ITEM_NO"));
			    u.setPhotoNo(rs.getInt("PHOTO_NO"));
			}
		}catch (Exception e) {
			System.out.println("AdminDAO 예외발생:" + e.getMessage());
		}
		return u;
	}


	// 회원아이디로 회원닉네임 수정
	public void updateUser(UserVO user) {
		String sql = "update user_tb set USER_NICKNAME=? where USER_ID=?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, user.getUserNickname());

			psmt.executeUpdate();
			System.out.println("회원 닉네임 수정 완료");
		}catch (Exception e) {
			System.out.println("회원 닉네임 수정 실패");
			System.out.println("AdminDAO 예외발생:" + e.getMessage());
		}
	}


	// 회원아이디로 회원 삭제
	public void deleteUser(String userId) {
		String sql = "delete from user_tb where userId=?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement psmt = conn.prepareStatement(sql);
			psmt.setString(1, userId);
			psmt.executeUpdate();
			System.out.println("회원 삭제 완료");
		}catch (Exception e) {
			System.out.println("회원 삭제 실패");
			System.out.println("AdminDAO 예외발생:" + e.getMessage());
		}
	}

	// 신고된 게시글 목록 조회

	public ArrayList<ReportVO> getReportedBoard(){

		ArrayList<ReportVO> list = new ArrayList<ReportVO>();
		try {
			String sql = "select REPORT_NO, USER_NO, BOARD_NO, REPORT_CONTENT, REPORT_TYPE, REPORT_DATE from report where REPORT_TYPE = '게시글신고'";
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				list.add(new ReportVO(
									rs.getInt("REPORT_NO"),
									rs.getInt("USER_NO"),
									rs.getInt("BOARD_NO"),
									rs.getString("REPORT_CONTENT"),
									rs.getString("REPORT_TYPE"),
									rs.getDate("REPORT_DATE")));
			}
			ConnectionProvider.close(conn, stmt, rs);
		}catch (Exception e) {
			System.out.println("AdminDAO 예외발생:" + e.getMessage());
		}
		return list;
	}

	// 신고된 댓글 목록 조회
	public ArrayList<ReportVO> getReportedComments(){

		ArrayList<ReportVO> list = new ArrayList<ReportVO>();
		try {
			String sql = "select REPORT_NO, USER_NO, BOARD_NO, REPORT_CONTENT, REPORT_TYPE, REPORT_DATE from report where REPORT_TYPE = '댓글신고'";
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				list.add(new ReportVO(
						rs.getInt("REPORT_NO"),
						rs.getInt("USER_NO"),
						rs.getInt("BOARD_NO"),
						rs.getString("REPORT_CONTENT"),
						rs.getString("REPORT_TYPE"),
						rs.getDate("REPORT_DATE")));
			}
			ConnectionProvider.close(conn, stmt, rs);
		}catch (Exception e) {
			System.out.println("신고된 댓글 목록 조회 실패");
			System.out.println("AdminDAO 예외발생:" + e.getMessage());
		}
		return list;
	}

}








