package com.gamecut.vo;

public class CommentLikeVO {
	private int commentNo;
	private int userNo;
	
	public CommentLikeVO(int commentNo, int userNo) {
		super();
		this.commentNo = commentNo;
		this.userNo = userNo;
	}
	
	public CommentLikeVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	
}
