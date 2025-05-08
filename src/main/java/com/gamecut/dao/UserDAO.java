package com.gamecut.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.UserVO;

public class UserDAO {
	

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
	
	
	// 아이디를 매개변수로 전달받아 그 아이디가 이미 있는지 판별하여 결과를 반환하는 메소드
    // 있으면:1, 없으면 :0
    public int isAlreadyId (String id){
        int re = 0;
        String sql = "select * from user_tb where user_id=?";
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
    
    
    //id를 매개변수로 전달받아 회원의 정보를 반환하는 메소드
    public UserVO getMember(String id) {
        UserVO vo = new UserVO();
        String sql =  "select * from user_tb where user_id=?";
        try {
            Connection conn = ConnectionProvider.getConnection();
            PreparedStatement psmt = conn.prepareStatement(sql);
            psmt.setString(1, id);
            ResultSet rs = psmt.executeQuery();
            if(rs.next()) {
                vo.setUserNo(rs.getInt(1));
                vo.setUserId(rs.getString(2));
                vo.setUserPwd(rs.getString(3));
                vo.setUserName(rs.getString(4));
                vo.setUserNickname(rs.getString(5));
                vo.setPhone(rs.getString(6));
                vo.setEmail(rs.getString(7));
                vo.setUserCreateDate(rs.getDate(8));
                vo.setUserDeleteDate(rs.getDate(9));
                vo.setIsSocial(rs.getString(10));
                vo.setRole(rs.getString(11));
                vo.setUserPoint(rs.getInt(12));
                vo.setItemNo(rs.getInt(13));
                vo.setPhotoNo(rs.getInt(14));
        
            }
            ConnectionProvider.close(conn, psmt, rs);
        }catch (Exception e) {
            System.out.println("에외발생:"+e.getMessage());
        }
        return vo;
    }
	
	
	public int isMember( String id , String pwd){
        int re = -1;
        String sql = "select pwd from user_tb where user_id=?";
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
        return re;
    }
}
