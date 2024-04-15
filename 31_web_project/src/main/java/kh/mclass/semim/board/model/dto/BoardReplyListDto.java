package kh.mclass.semim.board.model.dto;

public class BoardReplyListDto {
//BOARD_REPLY_ID         NOT NULL NUMBER         
//BOARD_ID               NOT NULL NUMBER         
//BOARD_REPLY_WRITER     NOT NULL VARCHAR2(20)   
//BOARD_REPLY_CONTENT    NOT NULL VARCHAR2(4000) 
//BOARD_REPLY_WRITE_TIME NOT NULL TIMESTAMP(6)   
//BOARD_REPLY_LOG_IP              VARCHAR2(15)   
//BOARD_REPLY_LEVEL      NOT NULL NUMBER(2)      
//BOARD_REPLY_REF        NOT NULL NUMBER         
//BOARD_REPLY_STEP       NOT NULL NUMBER(3)      
	// Integer 초기값 null
	// int 초기값 0
	private Integer boardReplyId;
	private String boardReplyWriter;
	private String boardReplyContent;
	private String boardReplyWriteTime;  // java.sql.Timestamp;
	private Integer boardReplyLevel;
	private Integer boardReplyRef;
	private Integer boardReplyStep;
	@Override
	public String toString() {
		return "BoardReplyListDto [boardReplyId=" + boardReplyId + ", boardReplyWriter=" + boardReplyWriter
				+ ", boardReplyContent=" + boardReplyContent + ", boardReplyWriteTime=" + boardReplyWriteTime
				+ ", boardReplyLevel=" + boardReplyLevel + ", boardReplyRef=" + boardReplyRef + ", boardReplyStep="
				+ boardReplyStep + "]";
	}
	public BoardReplyListDto(Integer boardReplyId, String boardReplyWriter, String boardReplyContent,
			String boardReplyWriteTime, Integer boardReplyLevel, Integer boardReplyRef, Integer boardReplyStep) {
		super();
		this.boardReplyId = boardReplyId;
		this.boardReplyWriter = boardReplyWriter;
		this.boardReplyContent = boardReplyContent;
		this.boardReplyWriteTime = boardReplyWriteTime;
		this.boardReplyLevel = boardReplyLevel;
		this.boardReplyRef = boardReplyRef;
		this.boardReplyStep = boardReplyStep;
	}
	public Integer getBoardReplyId() {
		return boardReplyId;
	}
	public String getBoardReplyWriter() {
		return boardReplyWriter;
	}
	public String getBoardReplyContent() {
		return boardReplyContent;
	}
	public String getBoardReplyWriteTime() {
		return boardReplyWriteTime;
	}
	public Integer getBoardReplyLevel() {
		return boardReplyLevel;
	}
	public Integer getBoardReplyRef() {
		return boardReplyRef;
	}
	public Integer getBoardReplyStep() {
		return boardReplyStep;
	}
	
	
}
