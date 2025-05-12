package com.gamecut.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.UserVO;

public class UserDAO {
	public int userFollow(int followerNo, int followNo) {
		int re = 0;
		String sql = "insert into follow values(?, ?)";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, followerNo);
			pstmt.setInt(2, followNo);
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}
	public int userUnfollow(int followerNo, int followNo) {
		int re = 0;
		String sql = "delete from follow where follower_no=? and user_no=?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, followerNo);
			pstmt.setInt(2, followNo);
			re = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}
	
	public ArrayList<UserVO> selectFollow(int userNo) {
		ArrayList<UserVO> followList = new ArrayList<UserVO>();
		String sql = "select user_no from follow where follower_no = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				followList.add(selectUser(rs.getInt("user_no")));
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return followList;
	}
	
	public ArrayList<UserVO> selectFollower(int userNo) {
		ArrayList<UserVO> followerList = new ArrayList<UserVO>();
		String sql = "select follower_no from follow where user_no = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				followerList.add(selectUser(rs.getInt("follower_no")));
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return followerList;
	}

	public int updateUserPasswordByUserid(String userid, String newPassword) {
		int re = -1;
		String sql = "update user_tb set user_pwd = ? where user_id = ?";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPassword);
			pstmt.setString(2, userid);
			re = pstmt.executeUpdate();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}
	
	
	public int updateUser(UserVO vo) {
		int re = 0;
		String sql = "";
		System.out.println(vo);
		try {
			if(vo.getPhotoNo() == 0) {
				sql = "update user_tb set user_name = ?, user_nickname = ?, phone = ?, email =?, photo_no = null where user_no = ?";
			} else {
				sql = "update user_tb set user_name = ?, user_nickname = ?, phone = ?, email =?, photo_no = ? where user_no = ?";
			}
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getUserName());
			pstmt.setString(2, vo.getUserNickname());
			pstmt.setString(3, vo.getPhone());
			pstmt.setString(4, vo.getEmail());
			if(vo.getPhotoNo() == 0) {
				pstmt.setInt(5, vo.getUserNo());
			}
			if(vo.getPhotoNo() != 0) {
				pstmt.setInt(5, vo.getPhotoNo());
				pstmt.setInt(6, vo.getUserNo());
			}
			re = pstmt.executeUpdate();
			ConnectionProvider.close(conn, pstmt);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
	}
	public int insertUser(UserVO vo) {
		int re = -1;
		String sql = "insert into user_tb values(seq_user_no.nextval,?,?,?,?,?,?,sysdate,null,?,?,1000,null,null)";
		try {
			Connection conn =  ConnectionProvider.getConnection();
			PreparedStatement prst = conn.prepareStatement(sql);
			prst.setString(1, vo.getUserId());
			prst.setString(2, vo.getUserPwd());
			prst.setString(3, vo.getUserName());
			prst.setString(4, vo.getUserNickname());
			prst.setString(5, vo.getPhone());
			prst.setString(6, vo.getEmail());
			prst.setString(7, "basic");
			prst.setString(8, "role_user");
			//prst.setInt(9, vo.getPhotoNo());
			re = prst.executeUpdate();
			ConnectionProvider.close(conn, prst);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return re;
}
	
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
	
	// 아이디를 매개변수로 전달받아 그 아이디가 이미 있는지 판별하여 결과를 반환하는 메소드
    // 있으면:1, 없으면 :0
    public int isAlreadyId (String id){
        int re = 0;
        String sql = "select user_no, user_id from user_tb where user_id=?";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()) {
                re = 1;
            }
            ConnectionProvider.close(conn, pstmt,rs);
        }catch (Exception e) {
            System.out.println("예외발생:"+e.getMessage());
        }
        return re;
    }
    
    
    public int isAlreadyNickname(String userNickname) {
    	int re = 0;
    	String sql = "select user_nickname from user_tb where user_nickname = ?";
    	try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userNickname);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				re = 1;
			}
			ConnectionProvider.close(conn, pstmt, rs);
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
    	return re;
    }

    //id를 매개변수로 전달받아 회원의 정보를 반환하는 메소드
    public UserVO getUserById(String id) {
        UserVO vo = new UserVO();
        String sql =  "select user_no, user_id, user_pwd, user_name, user_nickname,"
        		+ "phone, email, user_create_date, user_delete_date, is_social, role, user_point,"
        		+ "item_no, photo_no from user_tb where user_id=?";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement psmt = conn.prepareStatement(sql);
            psmt.setString(1, id);
            ResultSet rs = psmt.executeQuery();
            if(rs.next()) {
                vo.setUserNo(rs.getInt("user_no"));
                vo.setUserId(rs.getString("user_id"));
                vo.setUserPwd(rs.getString("user_pwd"));
                vo.setUserName(rs.getString("user_name"));
                vo.setUserNickname(rs.getString("user_nickname"));
                vo.setPhone(rs.getString("phone"));
                vo.setEmail(rs.getString("email"));
                vo.setUserCreateDate(rs.getDate("user_create_date"));
                vo.setUserDeleteDate(rs.getDate("user_delete_date"));
                vo.setIsSocial(rs.getString("is_social"));
                vo.setRole(rs.getString("role"));
                vo.setUserPoint(rs.getInt("user_point"));
                vo.setItemNo(rs.getInt("item_no"));
                vo.setPhotoNo(rs.getInt("photo_no"));
        
            }
            ConnectionProvider.close(conn, psmt, rs);
        }catch (Exception e) {
            System.out.println("에외발생:"+e.getMessage());
        }
        return vo;
    }
	
	
	public int isMember( String id , String pwd){
        int re = -1;
        
        if(getUserById(id).getUserDeleteDate() == null) {
        	String sql = "select user_pwd from user_tb where user_id=?";
            try {
                Connection conn = ConnectionProvider.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, id);
                ResultSet rs = pstmt.executeQuery();
                if(rs.next()) {
                    String dbPwd = rs.getString(1);
                    if(dbPwd.equals(pwd)) {
                        re = 1;
                    }else {
                        re = 0;
                    }
                }
                ConnectionProvider.close(conn, pstmt, rs);
            }catch (Exception e) {
                System.out.println("예외발생:"+e.getMessage());
            }
        }else {
        	System.out.println("탈퇴한회원입니다.");
        	re = 2;
        }
        
        
        return re;
    }
}
