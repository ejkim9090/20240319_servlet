package kh.mclass.semim.board.model.dto;

public class FileWriteDto {
	private String filePath;
	private String orginalFileName;
	@Override
	public String toString() {
		return "FileWriteDto [filePath=" + filePath + ", orginalFileName=" + orginalFileName + "]";
	}
	public FileWriteDto(String filePath, String orginalFileName) {
		super();
		this.filePath = filePath;
		this.orginalFileName = orginalFileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public String getOrginalFileName() {
		return orginalFileName;
	}
	
}
