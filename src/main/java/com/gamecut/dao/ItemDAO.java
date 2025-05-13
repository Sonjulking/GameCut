package com.gamecut.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.gamecut.db.ConnectionProvider;
import com.gamecut.vo.FileVO;
import com.gamecut.vo.ItemVO;

public class ItemDAO {
	// 아이템 번호로 해당 아이템 사진 조회 메소드
	public FileVO selectItemImg(int itemNo) {
		FileVO vo = new FileVO();
		String sql = "select attach_no, user_no, uuid, file_url, real_path, mime_type, upload_time from file_tb where attach_no = (select attach_no from item_img where item_no = ?)";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, itemNo);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setAttachNo(rs.getInt("attach_no"));
				vo.setUserNo(rs.getInt("user_no"));
				vo.setUuid(rs.getString("uuid"));
				vo.setFileUrl(rs.getString("file_url"));
				vo.setRealPath(rs.getString("real_path"));
				vo.setUploadTime(rs.getDate("upload_time"));
				vo.setMimeType(rs.getString("mime_type"));
			}
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return vo;
	}

	// 보유아이템 전체 정보 조회
	public ArrayList<ItemVO> selectItemByUserNo(int userNo) {
		ArrayList<ItemVO> list = new ArrayList<ItemVO>();
		String sql = "select item_no, item_name, item_price from item where item_no in (select item_no from user_item where user_no = ?)";
		try {
			Connection conn = ConnectionProvider.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userNo);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				ItemVO item = new ItemVO();
				item.setItemNo(rs.getInt("item_no"));
				item.setItemName(rs.getString("item_name"));
				item.setItemPrice(rs.getInt("item_price"));
				list.add(item);
			}
		} catch (Exception e) {
			System.out.println("예외발생 : " + e.getMessage());
		}
		return list;
	}
	// 포인트 상점 아이템 전체 조회 메서드
	public ArrayList<ItemVO> selectAllItems(){
		ArrayList<ItemVO> list = new ArrayList();
		try {
			String sql = "select ITEM_NO, ITEM_NAME, "
					+ "ITEM_PRICE, ITEM_DELETE_DATE "
					+ "from ITEM order by ITEM_NO ";
			Connection conn = ConnectionProvider.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ItemVO item = new ItemVO(
						rs.getInt("ITEM_NO"),
						rs.getString("ITEM_NAME"),
						rs.getInt("ITEM_PRICE"),
						rs.getDate("ITEM_DELETE_DATE")
						);
				list.add(item);
			}
		}catch (Exception e) {
			System.out.println("ItemDAO 예외발생 :" + e.getMessage());
		}

		return list;
	}

	// 포인트 차감 및 구매 처리
	public void purchaseItem(int userNo, int itemNo) {
		try {

			// 사용자 유무 및 포인트 확인
			String userSql = "SELECT USER_POINT, USER_NAME FROM USER_TB WHERE USER_NO = ? AND USER_DELETE_DATE IS NULL";
			Connection conn = ConnectionProvider.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(userSql);
	        pstmt.setInt(1, userNo);
	        ResultSet rs = pstmt.executeQuery();
	        if(!rs.next()) {
	        	System.out.println("사용자를 찾을 수 없습니다.");
	        	return;
	        }

	        int userPoint = rs.getInt("USER_POINT");
	        String userName = rs.getString("USER_NAME");

	        // 아이템 유무 확인
	        String itemSql = "SELECT ITEM_PRICE, ITEM_NAME FROM ITEM WHERE ITEM_NO = ? AND ITEM_DELETE_DATE IS NULL";
	        pstmt = conn.prepareStatement(itemSql);
	        pstmt.setInt(1, itemNo);
	        rs = pstmt.executeQuery();

	        if (!rs.next()) {
	            System.out.println("해당 아이템을 찾을 수 없습니다.");
	            return;
	        }

	        int itemPrice = rs.getInt("ITEM_PRICE");
	        String itemName = rs.getString("ITEM_NAME");

	        if(userPoint < itemPrice) {
	        	System.out.println(userName +"님의 포인트가 부족합니다.");
	        	return;
	        }

	        // 포인트 차감
	        String updateSql = "UPDATE USER_TB SET USER_POINT = USER_POINT - ? WHERE USER_NO = ?";
	        pstmt = conn.prepareStatement(updateSql);
	        pstmt.setInt(1, itemPrice);
	        pstmt.setInt(2, itemNo);
	        pstmt.setInt(3, userNo);
	        int result = pstmt.executeUpdate();

	        if(result > 0) {
	        	System.out.println(itemName + "을(를) 구매하였습니다.");
	        }else {
				System.out.println(itemName +" 구매에 실패하였습니다.");
			}

	        ConnectionProvider.close(conn, pstmt, rs);


		}catch (Exception e) {
			System.out.println("ItemDAO 예외발생 :" + e.getMessage());
		}
	}

	// 아이템 등록
	public boolean insertItem(int attachNo, String name, int price) {
		try {
			// ITEM 테이블에 아이템 등록
			String sql = "INSERT INTO ITEM (ITEM_NO, ITEM_NAME, ITEM_PRICE) VALUES (SEQ_ITEM_NO.NEXTVAL, ?, ?)";
			Connection conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			PreparedStatement pstmt = conn.prepareStatement(sql, new String[] {"ITEM_NO"}); // 자동 생성 키
			pstmt.setString(1, name);
			pstmt.setInt(2, price);
			pstmt.executeUpdate();

			// 입력한 item_no 조회
			ResultSet rs = pstmt.getGeneratedKeys();
			int itemNo = -1;
			if(rs.next()) {
				itemNo = rs.getInt(1);
			}else {
				conn.rollback();
				System.out.println("ITEM_NO 생성 실패");
				return false;
			}

			// ITEM_IMG 테이블에 등록
			String sql2 = "insert into ITEM_IMG(ITEM_NO, ATTACH_NO) values(?,?)";
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1, itemNo);
			pstmt2.setInt(2, attachNo);
			pstmt2.executeUpdate();

			conn.commit();
			return true;

		}catch (Exception e) {
			System.out.println("아이템 등록 실패");
			System.out.println("ItemDAO 예외발생 :" + e.getMessage());
		}
		return false;
	}

	// 보유 아이템 조회
	public ArrayList<Integer> getOwnedItemNos(int userNo) {
	    ArrayList<Integer> list = new ArrayList<>();
	    try {
	        String sql = "SELECT ITEM_NO FROM USER_ITEM WHERE USER_NO = ?";
	        Connection conn = ConnectionProvider.getConnection();
	        PreparedStatement pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, userNo);
	        ResultSet rs = pstmt.executeQuery();
	        while (rs.next()) {
	            list.add(rs.getInt("ITEM_NO"));
	        }
	        ConnectionProvider.close(conn, pstmt, rs);
	    } catch (Exception e) {
	    	System.out.println("보유 아이템 조회 실패");
	        System.out.println("ItemDAO 예외발생 : " + e.getMessage());
	    }
	    return list;
	}

	// 아이템 중복 보유 확인
		public boolean hasUserItem(int userNo, int itemNo) {
		    boolean hasItem = false;
		    try {
		        String sql = "select count(*) from USER_ITEM where USER_NO = ? AND ITEM_NO = ?";
		        Connection conn = ConnectionProvider.getConnection();
		        PreparedStatement pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, userNo);
		        pstmt.setInt(2, itemNo);
		        ResultSet rs = pstmt.executeQuery();
		        if (rs.next()) {
		            hasItem = rs.getInt(1) > 0;
		        }
		        ConnectionProvider.close(conn, pstmt, rs);
		    } catch (Exception e) {
		    	System.out.println("보유 여부 체크 실패");
		    	System.out.println("ItemDAO 예외발생 : " + e.getMessage());
		    }
		    return hasItem;
		}

		// 잔여포인트 조회
		public int getUserPoint(int userNo) {
		    int point = 0;
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    try {
		        conn = ConnectionProvider.getConnection();
		        String sql = "SELECT USER_POINT FROM USER_TB WHERE USER_NO = ?";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1, userNo);
		        rs = pstmt.executeQuery();
		        if (rs.next()) {
		            point = rs.getInt("USER_POINT");
		        }
		    } catch (Exception e) {
		    	System.out.println("잔여포인트 조회 실패");
		    	System.out.println("ItemDAO 예외발생 : " + e.getMessage());
		    } finally {
		        ConnectionProvider.close(conn, pstmt, rs);
		    }
		    return point;
		}

		// 아이템 가격 조회
		public int getItemPrice(int itemNo) {
			int price = 0;
			try {
				String priceSql = "select ITEM_PRICE from ITEM where ITEM_NO =?";
				Connection conn = ConnectionProvider.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(priceSql);
				ResultSet rs = pstmt.executeQuery();
				pstmt.setInt(1, itemNo);
				if(rs.next()) {
					price = rs.getInt("ITEM_PRICE");
				}
				ConnectionProvider.close(conn, pstmt, rs);
			}catch (Exception e) {
				System.out.println("ItemDAO 예외발생 : " + e.getMessage());
			}
			return price;
		}

}


















