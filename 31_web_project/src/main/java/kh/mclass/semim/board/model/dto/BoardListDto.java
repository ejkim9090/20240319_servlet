package kh.mclass.semim.board.model.dto;

import java.util.List;

public class BoardListDto {
//	BOARD_ID     NOT NULL NUMBER
//	SUBJECT      NOT NULL VARCHAR2(120)  
//	CONTENT      NOT NULL VARCHAR2(4000) 
//	WRITE_TIME   NOT NULL TIMESTAMP(6)   
//	LOG_IP                VARCHAR2(15)   
//	BOARD_WRITER NOT NULL VARCHAR2(20)   
//	READ_COUNT   NOT NULL NUMBER
	private Integer boardId;
	private String subject;
	private String writeTime;  // TIMESTAMP
	private String boardWriter;
	private Integer readCount;
	@Override
	public String toString() {
		return "BoardListDto [boardId=" + boardId + ", subject=" + subject + ", writeTime=" + writeTime
				+ ", boardWriter=" + boardWriter + ", readCount=" + readCount + "]";
	}
	public BoardListDto(Integer boardId, String subject, String writeTime, String boardWriter, Integer readCount) {
		super();
		this.boardId = boardId;
		this.subject = subject;
		this.writeTime = writeTime;
		this.boardWriter = boardWriter;
		this.readCount = readCount;
	}
	public Integer getBoardId() {
		return boardId;
	}
	public String getSubject() {
		return subject;
	}
	public String getWriteTime() {
		return writeTime;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public Integer getReadCount() {
		return readCount;
	}
	
	
	
}
