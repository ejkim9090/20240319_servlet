package kh.mclass.semim.board.model.dto;

public class BoardReplyDto {
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
	private Integer boardId;
	private String boardReplyWriter;
	private String boardReplyContent;
	private String boardReplyWriteTime;  // java.sql.Timestamp;
	private String boardReplyLogIp;
	private Integer boardReplyLevel;
	private Integer boardReplyRef;
	private Integer boardReplyStep;
	@Override
	public String toString() {
		return "BoardReplyDto [boardReplyId=" + boardReplyId + ", boardId=" + boardId + ", boardReplyWriter="
				+ boardReplyWriter + ", boardReplyContent=" + boardReplyContent + ", boardReplyWriteTime="
				+ boardReplyWriteTime + ", boardReplyLogIp=" + boardReplyLogIp + ", boardReplyLevel=" + boardReplyLevel
				+ ", boardReplyRef=" + boardReplyRef + ", boardReplyStep=" + boardReplyStep + "]";
	}
	public BoardReplyDto() {
		super();
	}
	public BoardReplyDto(Integer boardReplyId, Integer boardId, String boardReplyWriter, String boardReplyContent,
			String boardReplyWriteTime, String boardReplyLogIp, Integer boardReplyLevel, Integer boardReplyRef,
			Integer boardReplyStep) {
		super();
		this.boardReplyId = boardReplyId;
		this.boardId = boardId;
		this.boardReplyWriter = boardReplyWriter;
		this.boardReplyContent = boardReplyContent;
		this.boardReplyWriteTime = boardReplyWriteTime;
		this.boardReplyLogIp = boardReplyLogIp;
		this.boardReplyLevel = boardReplyLevel;
		this.boardReplyRef = boardReplyRef;
		this.boardReplyStep = boardReplyStep;
	}
	public Integer getBoardReplyId() {
		return boardReplyId;
	}
	public void setBoardReplyId(Integer boardReplyId) {
		this.boardReplyId = boardReplyId;
	}
	public Integer getBoardId() {
		return boardId;
	}
	public void setBoardId(Integer boardId) {
		this.boardId = boardId;
	}
	public String getBoardReplyWriter() {
		return boardReplyWriter;
	}
	public void setBoardReplyWriter(String boardReplyWriter) {
		this.boardReplyWriter = boardReplyWriter;
	}
	public String getBoardReplyContent() {
		return boardReplyContent;
	}
	public void setBoardReplyContent(String boardReplyContent) {
		this.boardReplyContent = boardReplyContent;
	}
	public String getBoardReplyWriteTime() {
		return boardReplyWriteTime;
	}
	public void setBoardReplyWriteTime(String boardReplyWriteTime) {
		this.boardReplyWriteTime = boardReplyWriteTime;
	}
	public String getBoardReplyLogIp() {
		return boardReplyLogIp;
	}
	public void setBoardReplyLogIp(String boardReplyLogIp) {
		this.boardReplyLogIp = boardReplyLogIp;
	}
	public Integer getBoardReplyLevel() {
		return boardReplyLevel;
	}
	public void setBoardReplyLevel(Integer boardReplyLevel) {
		this.boardReplyLevel = boardReplyLevel;
	}
	public Integer getBoardReplyRef() {
		return boardReplyRef;
	}
	public void setBoardReplyRef(Integer boardReplyRef) {
		this.boardReplyRef = boardReplyRef;
	}
	public Integer getBoardReplyStep() {
		return boardReplyStep;
	}
	public void setBoardReplyStep(Integer boardReplyStep) {
		this.boardReplyStep = boardReplyStep;
	}
	
}
