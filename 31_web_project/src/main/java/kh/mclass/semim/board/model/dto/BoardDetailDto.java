package kh.mclass.semim.board.model.dto;

import java.util.List;

public class BoardDetailDto {
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
	private String boardWriter;
	private Integer readCount;
	
	private List<BoardReplyDto>  boardReplyList;
	
}
