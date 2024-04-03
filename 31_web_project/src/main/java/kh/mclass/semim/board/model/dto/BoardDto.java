package kh.mclass.semim.board.model.dto;

import java.util.List;

public class BoardDto {
//	BOARD_ID     NOT NULL NUMBER         
//	SUBJECT      NOT NULL VARCHAR2(120)  
//	CONTENT      NOT NULL VARCHAR2(4000) 
//	WRITE_TIME   NOT NULL TIMESTAMP(6)   
//	LOG_IP                VARCHAR2(15)   
//	BOARD_WRITER NOT NULL VARCHAR2(20)   
//	READ_COUNT   NOT NULL NUMBER
	private Integer boardId;
	private String subject;
	private String content;
	private String writeTime;  // TIMESTAMP
	private String logIp;
	private String boardWriter;
	private Integer readCount;
	
	
	@Override
	public String toString() {
		return "BoardDto [boardId=" + boardId + ", subject=" + subject + ", content=" + content + ", writeTime="
				+ writeTime + ", logIp=" + logIp + ", boardWriter=" + boardWriter + ", readCount=" + readCount + "]";
	}
	public BoardDto() {
		super();
	}
	public BoardDto(Integer boardId, String subject, String content, String writeTime, String logIp, String boardWriter,
			Integer readCount) {
		super();
		this.boardId = boardId;
		this.subject = subject;
		this.content = content;
		this.writeTime = writeTime;
		this.logIp = logIp;
		this.boardWriter = boardWriter;
		this.readCount = readCount;
	}
	public Integer getBoardId() {
		return boardId;
	}
	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriteTime() {
		return writeTime;
	}
	public void setWriteTime(String writeTime) {
		this.writeTime = writeTime;
	}
	public String getLogIp() {
		return logIp;
	}
	public void setLogIp(String logIp) {
		this.logIp = logIp;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public Integer getReadCount() {
		return readCount;
	}
	public void setReadCount(Integer readCount) {
		this.readCount = readCount;
	}
	
}
