package kh.mclass.semim.board.model.dto;

public class FileReadDto {
//	(BOARD_ID, BOARD_FILE_ID, SAVED_FILE_PATH_NAME, ORIGINAL_FILENAME)
	private Integer boardId;
	private Integer boardFileId;
	private String savedFilePathName;
	private String orginalFileName;
	@Override
	public String toString() {
		return "FileReadDto [boardId=" + boardId + ", boardFileId=" + boardFileId + ", savedFilePathName="
				+ savedFilePathName + ", orginalFileName=" + orginalFileName + "]";
	}
	public FileReadDto(Integer boardId, Integer boardFileId, String savedFilePathName, String orginalFileName) {
		super();
		this.boardId = boardId;
		this.boardFileId = boardFileId;
		this.savedFilePathName = savedFilePathName;
		this.orginalFileName = orginalFileName;
	}
	public Integer getBoardId() {
		return boardId;
	}
	public Integer getBoardFileId() {
		return boardFileId;
	}
	public String getSavedFilePathName() {
		return savedFilePathName;
	}
	public String getOrginalFileName() {
		return orginalFileName;
	}
	
}
