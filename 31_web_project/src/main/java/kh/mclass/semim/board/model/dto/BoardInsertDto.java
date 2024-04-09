package kh.mclass.semim.board.model.dto;

public class BoardInsertDto {
//	BOARD_ID     NOT NULL NUMBER         
//	SUBJECT      NOT NULL VARCHAR2(120)  
//	CONTENT      NOT NULL VARCHAR2(4000) 
//	WRITE_TIME   NOT NULL TIMESTAMP(6)   
//	LOG_IP                VARCHAR2(15)   
//	BOARD_WRITER NOT NULL VARCHAR2(20)   
//	READ_COUNT   NOT NULL NUMBER
	private String subject;
	private String content;
	//private String logIp;
	private String boardWriter;
	@Override
	public String toString() {
		return "BoardInsertDto [subject=" + subject + ", content=" + content + ", boardWriter=" + boardWriter + "]";
	}
	public BoardInsertDto(String subject, String content, String boardWriter) {
		super();
		this.subject = subject;
		this.content = content;
		this.boardWriter = boardWriter;
	}
	public String getSubject() {
		return subject;
	}
	public String getContent() {
		return content;
	}
	public String getBoardWriter() {
		return boardWriter;
	}

}
