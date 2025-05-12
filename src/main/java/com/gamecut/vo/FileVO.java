package com.gamecut.vo;

import java.sql.Date;

public class FileVO {
	private int attachNo;
	private int userNo;
	private String uuid;
	private String fileUrl;
	private String mimeType;
	private Date uploadTime;
	private String originalFileName;
	public FileVO(int attachNo, int userNo, String uuid, String fileUrl, String mimeType, Date uploadTime,
			String originalFileName) {
		super();
		this.attachNo = attachNo;
		this.userNo = userNo;
		this.uuid = uuid;
		this.fileUrl = fileUrl;
		this.mimeType = mimeType;
		this.uploadTime = uploadTime;
		this.originalFileName = originalFileName;
	}
	public int getAttachNo() {
		return attachNo;
	}
	public void setAttachNo(int attachNo) {
		this.attachNo = attachNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public String getFileUrl() {
		return fileUrl;
	}
	public void setFileUrl(String fileUrl) {
		this.fileUrl = fileUrl;
	}
	public String getMimeType() {
		return mimeType;
	}
	public void setMimeType(String mimeType) {
		this.mimeType = mimeType;
	}
	public Date getUploadTime() {
		return uploadTime;
	}
	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public FileVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
}
