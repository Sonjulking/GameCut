package com.gamecut.vo;

public class PhotoVO {
    private int photoNo;      // PHOTO_NO
    private int attachNo;     // ATTACH_NO (FILE_TB 외래키)
    private int boardNo;
    private int photoOrder;   // PHOTO_ORDER (기본값 1)

    public int getPhotoNo() {
        return photoNo;
    }

    public void setPhotoNo(int photoNo) {
        this.photoNo = photoNo;
    }

    public int getAttachNo() {
        return attachNo;
    }

    public void setAttachNo(int attachNo) {
        this.attachNo = attachNo;
    }

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public int getPhotoOrder() {
        return photoOrder;
    }

    public void setPhotoOrder(int photoOrder) {
        this.photoOrder = photoOrder;
    }
}
