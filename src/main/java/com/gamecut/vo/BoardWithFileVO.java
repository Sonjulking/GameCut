package com.gamecut.vo;

import java.util.ArrayList;

public class BoardWithFileVO {
    private BoardVO board;
    private FileVO file;
    private ArrayList<CommentVO> commentVOList;

    public BoardVO getBoard() {
        return board;
    }

    public void setBoard(BoardVO board) {
        this.board = board;
    }

    public ArrayList<CommentVO> getCommentVOList() {
        return commentVOList;
    }

    public void setCommentVOList(ArrayList<CommentVO> commentVOList) {
        this.commentVOList = commentVOList;
    }

    public FileVO getFile() {
        return file;
    }

    public void setFile(FileVO file) {
        this.file = file;
    }
}
