package com.gamecut.vo;

public class LikeBoardVO {
	private int userNo;
    private int boardNo;

    public int getUserNo() {
        return userNo;
    }
    public void setUserNo(int userNo) {
        this.userNo = userNo;
    }
    public int getBoardNo() {
        return boardNo;
    }
    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }
	public LikeBoardVO(int userNo, int boardNo) {
		super();
		this.userNo = userNo;
		this.boardNo = boardNo;
	}
	public LikeBoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}
    
    
}
