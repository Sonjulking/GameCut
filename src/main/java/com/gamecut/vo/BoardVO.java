package com.gamecut.vo;

import java.util.Date;

public class BoardVO {
    private int boardNo;           
    private int userNo;           
    private int boardTypeNo;      
    private Integer videoNo;     
    private String boardContent;  
    private String boardTitle;     
    private int boardCount;       
    private int boardLike;         
    private Date boardCreateDate;  
    private Date boardDeleteDate; 

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

    public int getBoardTypeNo() {
        return boardTypeNo;
    }

    public void setBoardTypeNo(int boardTypeNo) {
        this.boardTypeNo = boardTypeNo;
    }

    public Integer getVideoNo() {
        return videoNo;
    }

    public void setVideoNo(Integer videoNo) {
        this.videoNo = videoNo;
    }

    public String getBoardContent() {
        return boardContent;
    }

    public void setBoardContent(String boardContent) {
        this.boardContent = boardContent;
    }

    public String getBoardTitle() {
        return boardTitle;
    }

    public void setBoardTitle(String boardTitle) {
        this.boardTitle = boardTitle;
    }

    public int getBoardCount() {
        return boardCount;
    }

    public void setBoardCount(int boardCount) {
        this.boardCount = boardCount;
    }

    public int getBoardLike() {
        return boardLike;
    }

    public void setBoardLike(int boardLike) {
        this.boardLike = boardLike;
    }

    public Date getBoardCreateDate() {
        return boardCreateDate;
    }

    public void setBoardCreateDate(Date boardCreateDate) {
        this.boardCreateDate = boardCreateDate;
    }

    public Date getBoardDeleteDate() {
        return boardDeleteDate;
    }

    public void setBoardDeleteDate(Date boardDeleteDate) {
        this.boardDeleteDate = boardDeleteDate;
    }
}
