package com.gamecut.vo;

import java.sql.Date;

public class PointHistoryVO {
	private int pointHistoryNo;
	private int userNo;
	private Date pointDate;
	private int pointAmount;
	private String pointSource;
	public PointHistoryVO(int pointHistoryNo, int userNo, Date pointDate, int pointAmount, String pointSource) {
		super();
		this.pointHistoryNo = pointHistoryNo;
		this.userNo = userNo;
		this.pointDate = pointDate;
		this.pointAmount = pointAmount;
		this.pointSource = pointSource;
	}
	public PointHistoryVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getPointHistoryNo() {
		return pointHistoryNo;
	}
	public void setPointHistoryNo(int pointHistoryNo) {
		this.pointHistoryNo = pointHistoryNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public Date getPointDate() {
		return pointDate;
	}
	public void setPointDate(Date pointDate) {
		this.pointDate = pointDate;
	}
	public int getPointAmount() {
		return pointAmount;
	}
	public void setPointAmount(int pointAmount) {
		this.pointAmount = pointAmount;
	}
	public String getPointSource() {
		return pointSource;
	}
	public void setPointSource(String pointSource) {
		this.pointSource = pointSource;
	}
	
	
}
