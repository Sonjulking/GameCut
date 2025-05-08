package com.gamecut.vo;

import java.sql.Date;

public class UserVO {
	private int userNo;
	private String userId;
	private String userPwd;
	private String userName;
	private String userNickname;
	private String phone;
	private String email;
	private Date userCreateDate;
	private Date userDeleteDate;
	private String isSocial;
	private String role;
	private int userPoint;
	private int itemNo;
	private int photoNo;
	public UserVO(int userNo, String userId, String userPwd, String userName, String userNickname, String phone,
			String email, Date userCreateDate, Date userDeleteDate, String isSocial, String role, int userPoint,
			int itemNo, int photoNo) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.userNickname = userNickname;
		this.phone = phone;
		this.email = email;
		this.userCreateDate = userCreateDate;
		this.userDeleteDate = userDeleteDate;
		this.isSocial = isSocial;
		this.role = role;
		this.userPoint = userPoint;
		this.itemNo = itemNo;
		this.photoNo = photoNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPwd() {
		return userPwd;
	}
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserNickname() {
		return userNickname;
	}
	public void setUserNickname(String userNickname) {
		this.userNickname = userNickname;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getUserCreateDate() {
		return userCreateDate;
	}
	public void setUserCreateDate(Date userCreateDate) {
		this.userCreateDate = userCreateDate;
	}
	public Date getUserDeleteDate() {
		return userDeleteDate;
	}
	public void setUserDeleteDate(Date userDeleteDate) {
		this.userDeleteDate = userDeleteDate;
	}
	public String getIsSocial() {
		return isSocial;
	}
	public void setIsSocial(String isSocial) {
		this.isSocial = isSocial;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getUserPoint() {
		return userPoint;
	}
	public void setUserPoint(int userPoint) {
		this.userPoint = userPoint;
	}
	public int getItemNo() {
		return itemNo;
	}
	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}
	public int getPhotoNo() {
		return photoNo;
	}
	public void setPhotoNo(int photoNo) {
		this.photoNo = photoNo;
	}
	public UserVO() {
		super();
		// TODO Auto-generated constructor stub
	}
}
