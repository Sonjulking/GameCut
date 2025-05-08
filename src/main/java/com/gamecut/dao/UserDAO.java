package com.gamecut.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.UserVO;

public class UserDAO {
	
	
	public int getNextUserNo() {
		int no = 0;
		String sql = "select nvl(max(user_no),0) from user_tb";
		try {
			Connection conn =  ConnectionProvider.getConnection();
			java.sql.Statement stmt = conn.createStatement();	
			ResultSet rs = stmt.executeQuery(sql);
			if(rs.next()) {
				no = rs.getInt(1);
			}
			ConnectionProvider.close(conn, stmt, rs);
			
			
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		
		return no + 1;
	}

	public int insertUser(UserVO vo) {
		
		int re = -1;
		String sql = "insert into user_tb values(seq_user_no.nextval(),?,?,?,?,?,sysdate,?,?,?,?,1000,?,?)";
		
		try {
			Connection conn =  ConnectionProvider.getConnection();
			PreparedStatement prst = conn.prepareStatement(sql);
			prst.setString(1, vo.getUser_id());
			prst.setString(2, vo.getUser_pwd());
			prst.setString(3, vo.getUser_name());
			prst.setString(4, vo.getUser_nickname());
			prst.setString(5, vo.getPhone());
			prst.setString(6, vo.getEmail());
			prst.setDate(7, null);
			prst.setString(8, vo.getIs_social());
			prst.setString(9, vo.getRole());
			prst.setInt(10, vo.getItem_no());
			prst.setInt(11, vo.getPhoto_no());
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
                vo.setUser_no(rs.getInt(1));
                vo.setUser_id(rs.getString(2));
                vo.setUser_pwd(rs.getString(3));
                vo.setUser_name(rs.getString(4));
                vo.setUser_nickname(rs.getString(5));
                vo.setPhone(rs.getString(6));
                vo.setEmail(rs.getString(7));
                vo.setUser_create_date(rs.getDate(8));
                vo.setUser_delete_date(rs.getDate(9));
                vo.setIs_social(rs.getString(10));
                vo.setRole(rs.getString(11));
                vo.setUser_point(rs.getInt(12));
                vo.setItem_no(rs.getInt(13));
                vo.setPhoto_no(rs.getInt(14));
                
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
