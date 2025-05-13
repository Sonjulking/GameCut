package com.gamecut.vo;

import java.sql.Date;

public class CommentVO {
	private int commentNo;
	private int boardNo;
	private int userNo;
	private int parentCommentNo;
	private String commentContent;
	private Date commentCreateDate;
	private Date commentDeleteDate;
    //유저 댓글
	public String commentWriter;
	public int getCommentNo() {
		return commentNo;
	}
	public CommentVO(int commentNo, int boardNo, int userNo, int parentCommentNo, String commentContent,
			Date commentCreateDate, Date commentDeleteDate) {
		super();
		this.commentNo = commentNo;
		this.boardNo = boardNo;
		this.userNo = userNo;
		this.parentCommentNo = parentCommentNo;
		this.commentContent = commentContent;
		this.commentCreateDate = commentCreateDate;
		this.commentDeleteDate = commentDeleteDate;
	}
	public CommentVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getParentCommentNo() {
		return parentCommentNo;
	}
	public void setParentCommentNo(int parentCommentNo) {
		this.parentCommentNo = parentCommentNo;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	public Date getCommentCreateDate() {
		return commentCreateDate;
	}
	public void setCommentCreateDate(Date commentCreateDate) {
		this.commentCreateDate = commentCreateDate;
	}
	public Date getCommentDeleteDate() {
		return commentDeleteDate;
	}
	public void setCommentDeleteDate(Date commentDeleteDate) {
		this.commentDeleteDate = commentDeleteDate;
	}

    public String getCommentWriter() {
        return commentWriter;
    }

    public void setCommentWriter(String commentWriter) {
        this.commentWriter = commentWriter;
    }
}
