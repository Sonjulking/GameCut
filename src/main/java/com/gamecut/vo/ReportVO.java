package com.gamecut.vo;

import java.util.Date;

public class ReportVO {
    private int reportNo;       
    private int userNo;         
    private int boardNo;        
    private String reportContent; 
    private String reportType;    
    private Date reportDate;     


    public ReportVO(int reportNo, int userNo, int boardNo, String reportContent, String reportType, Date reportDate) {
		super();
		this.reportNo = reportNo;
		this.userNo = userNo;
		this.boardNo = boardNo;
		this.reportContent = reportContent;
		this.reportType = reportType;
		this.reportDate = reportDate;
	}

	public ReportVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public int getReportNo() {
        return reportNo;
    }

    public void setReportNo(int reportNo) {
        this.reportNo = reportNo;
    }

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

    public String getReportContent() {
        return reportContent;
    }

    public void setReportContent(String reportContent) {
        this.reportContent = reportContent;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }
}
