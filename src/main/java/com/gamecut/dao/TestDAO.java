package com.gamecut.dao;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.TestVO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class TestDAO {
    public ArrayList<TestVO> findAll() {
        ArrayList<TestVO> list = new ArrayList<>();
        String sql = "select * from board2";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = ConnectionProvider.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                TestVO t = new TestVO();
                t.setNo(rs.getInt("no"));
                t.setTitle(rs.getString("title"));
                t.setWriter(rs.getString("writer"));
                t.setContent(rs.getString("content"));
                t.setRegdate(rs.getDate("regdate"));
                t.setIp(rs.getString("ip"));
                t.setFname(rs.getString("fname"));
                list.add(t);
            }

        } catch (Exception e) {
            System.out.println("예외발생 : " + e.getMessage());
        } finally {
            ConnectionProvider.close(conn, pstmt, rs);
        }
        return list;
    }
}
