package com.gamecut.vo;

import java.util.Date;

public class ItemVO {
	private int itemNo;
	private String itemName;
	private int itemPrice;
	private Date itemDeleteDate;

	public ItemVO(int itemNo, String itemName, int itemPrice, Date itemDeleteDate) {
		super();
		this.itemNo = itemNo;
		this.itemName = itemName;
		this.itemPrice = itemPrice;
		this.itemDeleteDate = itemDeleteDate;
	}

	public ItemVO() {
		super();
	}

	public int getItemNo() {
		return itemNo;
	}

	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}

	public Date getItemDeleteDate() {
		return itemDeleteDate;
	}

	public void setItemDeleteDate(Date itemDeleteDate) {
		this.itemDeleteDate = itemDeleteDate;
	}



}
