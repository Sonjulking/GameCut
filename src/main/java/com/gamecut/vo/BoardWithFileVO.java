package com.gamecut.vo;

public class BoardWithFileVO {
    private BoardVO board;
    private FileVO file;

    public BoardWithFileVO(BoardVO board, FileVO file) {
        this.board = board;
        this.file = file;
    }


    public BoardVO getBoard() {
        return board;
    }

    public FileVO getFile() {
        return file;
    }
}
