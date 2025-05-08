package com.gamecut.vo;

import java.sql.Date;

public class UserVO {
	private int user_no;
	private String user_id;
	private String user_pwd;
	private String user_name;
	private String user_nickname;
	private String phone;
	private String email;
	private Date user_create_date;
	private Date user_delete_date;
	private String is_social;
	private String role;
	private int user_point;
	private int item_no;
	private int photo_no;
	public UserVO(int user_no, String user_id, String user_pwd, String user_name, String user_nickname, String phone,
			String email, Date user_create_date, Date user_delete_date, String is_social, String role, int user_point,
			int item_no, int photo_no) {
		super();
		this.user_no = user_no;
		this.user_id = user_id;
		this.user_pwd = user_pwd;
		this.user_name = user_name;
		this.user_nickname = user_nickname;
		this.phone = phone;
		this.email = email;
		this.user_create_date = user_create_date;
		this.user_delete_date = user_delete_date;
		this.is_social = is_social;
		this.role = role;
		this.user_point = user_point;
		this.item_no = item_no;
		this.photo_no = photo_no;
	}
	public UserVO() {
		super();
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_nickname() {
		return user_nickname;
	}
	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
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
	public Date getUser_create_date() {
		return user_create_date;
	}
	public void setUser_create_date(Date user_create_date) {
		this.user_create_date = user_create_date;
	}
	public Date getUser_delete_date() {
		return user_delete_date;
	}
	public void setUser_delete_date(Date user_delete_date) {
		this.user_delete_date = user_delete_date;
	}
	public String getIs_social() {
		return is_social;
	}
	public void setIs_social(String is_social) {
		this.is_social = is_social;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getUser_point() {
		return user_point;
	}
	public void setUser_point(int user_point) {
		this.user_point = user_point;
	}
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}
	public int getPhoto_no() {
		return photo_no;
	}
	public void setPhoto_no(int photo_no) {
		this.photo_no = photo_no;
	}
	
	
	
}
